import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:connect_well_nepal/models/place_model.dart';
import 'package:connect_well_nepal/services/location_service.dart';

/// OSM Places Service - Uses OpenStreetMap Overpass API (FREE, works worldwide!)
///
/// This is a free alternative to Google Places API that works globally
class OSMPlacesService {
  static final OSMPlacesService _instance = OSMPlacesService._internal();
  factory OSMPlacesService() => _instance;
  OSMPlacesService._internal();

  // Multiple Overpass API endpoints for redundancy
  static const List<String> _overpassUrls = [
    'https://overpass-api.de/api/interpreter',
    'https://overpass.kumi.systems/api/interpreter',
    'https://maps.mail.ru/osm/tools/overpass/api/interpreter',
  ];
  
  final LocationService _locationService = LocationService();

  // Cache
  List<PlaceModel> _cachedPlaces = [];
  DateTime? _lastFetch;
  double? _lastLat;
  double? _lastLng;
  int _currentUrlIndex = 0;

  List<PlaceModel> get cachedPlaces => _cachedPlaces;

  /// Fetch nearby healthcare facilities (hospitals, clinics, doctors)
  /// Works anywhere in the world!
  Future<List<PlaceModel>> getNearbyHealthcare({
    int radiusMeters = 5000,
    bool forceRefresh = false,
  }) async {
    try {
      // Get current location
      final position = await _locationService.getCurrentLocation();
      if (position == null) {
        debugPrint('OSM: Could not get location, using demo data');
        return _getDemoData(null, null);
      }

      final lat = position.latitude;
      final lng = position.longitude;

      // Check cache (valid for 5 minutes and same location within ~100m)
      if (!forceRefresh && 
          _cachedPlaces.isNotEmpty && 
          _lastFetch != null &&
          _lastLat != null &&
          _lastLng != null &&
          DateTime.now().difference(_lastFetch!).inMinutes < 5 &&
          _isNearby(lat, lng, _lastLat!, _lastLng!)) {
        debugPrint('OSM: Using cached data (${_cachedPlaces.length} places)');
        return _cachedPlaces;
      }

      debugPrint('OSM: Fetching healthcare near $lat, $lng');

      // Simplified query for faster response (hospitals and clinics only)
      final query = '''
[out:json][timeout:15];
(
  node["amenity"="hospital"](around:$radiusMeters,$lat,$lng);
  node["amenity"="clinic"](around:$radiusMeters,$lat,$lng);
  way["amenity"="hospital"](around:$radiusMeters,$lat,$lng);
  way["amenity"="clinic"](around:$radiusMeters,$lat,$lng);
);
out center;
''';

      // Try multiple endpoints with retry
      http.Response? response;
      String? lastError;
      
      for (int attempt = 0; attempt < _overpassUrls.length; attempt++) {
        final urlIndex = (_currentUrlIndex + attempt) % _overpassUrls.length;
        final url = _overpassUrls[urlIndex];
        
        try {
          debugPrint('OSM: Trying endpoint ${urlIndex + 1}/${_overpassUrls.length}');
          
          response = await http.post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: {'data': query},
          ).timeout(const Duration(seconds: 15));
          
          if (response.statusCode == 200) {
            _currentUrlIndex = urlIndex; // Remember working endpoint
            break;
          } else {
            lastError = 'Status ${response.statusCode}';
            debugPrint('OSM: Endpoint $urlIndex returned ${response.statusCode}');
          }
        } catch (e) {
          lastError = e.toString();
          debugPrint('OSM: Endpoint $urlIndex failed: $e');
        }
      }

      if (response == null || response.statusCode != 200) {
        debugPrint('OSM: All endpoints failed. Last error: $lastError');
        debugPrint('OSM: Using demo data as fallback');
        return _getDemoData(lat, lng);
      }

      final data = json.decode(response.body);
      final elements = data['elements'] as List? ?? [];

      debugPrint('OSM: Found ${elements.length} places');

      if (elements.isEmpty) {
        debugPrint('OSM: No places found, using demo data');
        return _getDemoData(lat, lng);
      }

      final places = <PlaceModel>[];
      
      for (final element in elements) {
        try {
          final tags = element['tags'] as Map<String, dynamic>? ?? {};
          final name = tags['name'] ?? 
                      tags['name:en'] ?? 
                      tags['brand'] ?? 
                      _getGenericName(tags);
          
          // Get coordinates (for ways, use center)
          double placeLat, placeLng;
          if (element['type'] == 'way' && element['center'] != null) {
            placeLat = (element['center']['lat'] as num).toDouble();
            placeLng = (element['center']['lon'] as num).toDouble();
          } else {
            placeLat = (element['lat'] as num?)?.toDouble() ?? lat;
            placeLng = (element['lon'] as num?)?.toDouble() ?? lng;
          }

          // Calculate distance
          final distance = _locationService.calculateDistance(placeLat, placeLng);

          // Determine type
          final types = _getPlaceTypes(tags);

          places.add(PlaceModel(
            placeId: 'osm_${element['id']}',
            name: name,
            address: _buildAddress(tags),
            latitude: placeLat,
            longitude: placeLng,
            rating: _generateMockRating(element['id']),
            totalRatings: _generateMockReviewCount(element['id']),
            isOpen: _checkIfOpen(tags),
            types: types,
            distanceKm: distance,
          ));
        } catch (e) {
          debugPrint('OSM: Error parsing place: $e');
        }
      }

      // Sort by distance
      places.sort((a, b) => (a.distanceKm ?? 999).compareTo(b.distanceKm ?? 999));

      _cachedPlaces = places;
      _lastFetch = DateTime.now();
      _lastLat = lat;
      _lastLng = lng;

      return places.isNotEmpty ? places : _getDemoData(lat, lng);
    } catch (e) {
      debugPrint('OSM fetch error: $e');
      final position = _locationService.currentPosition;
      return _getDemoData(position?.latitude, position?.longitude);
    }
  }

  /// Check if two locations are nearby (within ~100m)
  bool _isNearby(double lat1, double lng1, double lat2, double lng2) {
    const threshold = 0.001; // ~100m
    return (lat1 - lat2).abs() < threshold && (lng1 - lng2).abs() < threshold;
  }

  /// Get generic name based on place type
  String _getGenericName(Map<String, dynamic> tags) {
    final amenity = tags['amenity'];
    final healthcare = tags['healthcare'];
    
    if (amenity == 'hospital' || healthcare == 'hospital') return 'Hospital';
    if (amenity == 'clinic' || healthcare == 'clinic') return 'Medical Clinic';
    if (amenity == 'doctors' || healthcare == 'doctor') return 'Doctor\'s Office';
    if (amenity == 'pharmacy') return 'Pharmacy';
    if (healthcare == 'centre') return 'Healthcare Center';
    return 'Healthcare Facility';
  }

  /// Get place types from OSM tags
  List<String> _getPlaceTypes(Map<String, dynamic> tags) {
    final types = <String>[];
    final amenity = tags['amenity'];
    final healthcare = tags['healthcare'];
    
    if (amenity == 'hospital' || healthcare == 'hospital') {
      types.add('hospital');
    }
    if (amenity == 'clinic' || healthcare == 'clinic' || healthcare == 'centre') {
      types.add('clinic');
    }
    if (amenity == 'doctors' || healthcare == 'doctor') {
      types.add('doctor');
    }
    if (amenity == 'pharmacy') {
      types.add('pharmacy');
    }
    
    return types.isEmpty ? ['clinic'] : types;
  }

  /// Generate mock rating for better UX (deterministic based on ID)
  double? _generateMockRating(dynamic id) {
    if (id == null) return 4.0;
    final hash = id.hashCode.abs();
    return 3.5 + (hash % 16) / 10.0; // 3.5 to 5.0
  }

  /// Generate mock review count (deterministic based on ID)
  int _generateMockReviewCount(dynamic id) {
    if (id == null) return 50;
    final hash = id.hashCode.abs();
    return 50 + (hash % 450); // 50 to 499 reviews
  }

  /// Check if place is open based on opening_hours tag
  bool _checkIfOpen(Map<String, dynamic> tags) {
    final openingHours = tags['opening_hours'];
    if (openingHours == null) return true;
    if (openingHours == '24/7') return true;
    
    final hour = DateTime.now().hour;
    return hour >= 8 && hour < 20;
  }

  String _buildAddress(Map<String, dynamic> tags) {
    final parts = <String>[];
    
    if (tags['addr:housenumber'] != null && tags['addr:street'] != null) {
      parts.add('${tags['addr:housenumber']} ${tags['addr:street']}');
    } else if (tags['addr:street'] != null) {
      parts.add(tags['addr:street']);
    }
    
    if (tags['addr:city'] != null) {
      parts.add(tags['addr:city']);
    } else if (tags['addr:town'] != null) {
      parts.add(tags['addr:town']);
    } else if (tags['addr:suburb'] != null) {
      parts.add(tags['addr:suburb']);
    }
    
    if (tags['addr:district'] != null) {
      parts.add(tags['addr:district']);
    } else if (tags['addr:state'] != null) {
      parts.add(tags['addr:state']);
    }
    
    if (tags['addr:country'] != null) {
      parts.add(tags['addr:country']);
    }
    
    if (parts.isEmpty) {
      if (tags['operator'] != null) return tags['operator'];
      if (tags['description'] != null) return tags['description'];
      return 'Address not available';
    }
    
    return parts.join(', ');
  }

  /// Demo data when API fails or no results (location-aware)
  List<PlaceModel> _getDemoData(double? userLat, double? userLng) {
    final baseLat = userLat ?? 27.7172;
    final baseLng = userLng ?? 85.3240;
    
    debugPrint('OSM: Generating demo data near $baseLat, $baseLng');
    
    return [
      PlaceModel(
        placeId: 'demo_1',
        name: 'City General Hospital',
        address: 'Main Street, City Center',
        latitude: baseLat + 0.008,
        longitude: baseLng + 0.005,
        rating: 4.2,
        totalRatings: 328,
        isOpen: true,
        types: ['hospital'],
        distanceKm: 1.2,
      ),
      PlaceModel(
        placeId: 'demo_2',
        name: 'University Medical Center',
        address: 'University Road',
        latitude: baseLat + 0.015,
        longitude: baseLng - 0.008,
        rating: 4.5,
        totalRatings: 256,
        isOpen: true,
        types: ['hospital'],
        distanceKm: 2.1,
      ),
      PlaceModel(
        placeId: 'demo_3',
        name: 'International Hospital',
        address: 'International Zone',
        latitude: baseLat - 0.012,
        longitude: baseLng + 0.018,
        rating: 4.6,
        totalRatings: 412,
        isOpen: true,
        types: ['hospital'],
        distanceKm: 2.8,
      ),
      PlaceModel(
        placeId: 'demo_4',
        name: 'Community Health Center',
        address: 'Community Square',
        latitude: baseLat + 0.003,
        longitude: baseLng - 0.004,
        rating: 4.4,
        totalRatings: 189,
        isOpen: true,
        types: ['clinic'],
        distanceKm: 0.6,
      ),
      PlaceModel(
        placeId: 'demo_5',
        name: 'Family Medical Clinic',
        address: 'Downtown',
        latitude: baseLat - 0.005,
        longitude: baseLng + 0.007,
        rating: 4.3,
        totalRatings: 145,
        isOpen: true,
        types: ['clinic'],
        distanceKm: 0.9,
      ),
      PlaceModel(
        placeId: 'demo_6',
        name: 'Wellness Clinic',
        address: 'Residential Area',
        latitude: baseLat + 0.020,
        longitude: baseLng + 0.010,
        rating: 4.1,
        totalRatings: 98,
        isOpen: true,
        types: ['clinic', 'doctor'],
        distanceKm: 2.5,
      ),
      PlaceModel(
        placeId: 'demo_7',
        name: 'Emergency Care Center',
        address: 'Highway Junction',
        latitude: baseLat - 0.025,
        longitude: baseLng - 0.015,
        rating: 4.0,
        totalRatings: 76,
        isOpen: true,
        types: ['hospital'],
        distanceKm: 3.5,
      ),
    ];
  }
}
