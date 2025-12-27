import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:connect_well_nepal/models/place_model.dart';
import 'package:connect_well_nepal/services/location_service.dart';

/// PlacesService - Handles Google Places API integration
///
/// Features:
/// - Search nearby hospitals and clinics
/// - Get place details
/// - Get place photos
class PlacesService {
  static final PlacesService _instance = PlacesService._internal();
  factory PlacesService() => _instance;
  PlacesService._internal();

  // TODO: Replace with your actual Google Places API key
  // Get your API key from: https://console.cloud.google.com/apis/credentials
  // Enable "Places API" and "Maps SDK for Android/iOS" in Google Cloud Console
  static const String _apiKey = 'YOUR_GOOGLE_PLACES_API_KEY';

  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
  // ignore: unused_field
  static const String _detailsUrl =
      'https://maps.googleapis.com/maps/api/place/details/json';
  static const String _photoUrl =
      'https://maps.googleapis.com/maps/api/place/photo';

  final LocationService _locationService = LocationService();

  // Cache for places
  List<PlaceModel> _cachedClinics = [];
  List<PlaceModel> _cachedHospitals = [];
  DateTime? _lastFetch;

  /// Get cached clinics
  List<PlaceModel> get cachedClinics => _cachedClinics;

  /// Get cached hospitals
  List<PlaceModel> get cachedHospitals => _cachedHospitals;

  /// Check if API key is configured
  bool get isConfigured => _apiKey != 'YOUR_GOOGLE_PLACES_API_KEY';

  /// Fetch nearby hospitals
  Future<List<PlaceModel>> getNearbyHospitals({
    int radius = 5000,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && _cachedHospitals.isNotEmpty && _isCacheValid()) {
      return _cachedHospitals;
    }

    final places = await _searchNearbyPlaces(
      type: 'hospital',
      radius: radius,
    );

    _cachedHospitals = places;
    return places;
  }

  /// Fetch nearby clinics/doctors
  Future<List<PlaceModel>> getNearbyClinics({
    int radius = 5000,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && _cachedClinics.isNotEmpty && _isCacheValid()) {
      return _cachedClinics;
    }

    final places = await _searchNearbyPlaces(
      type: 'doctor',
      radius: radius,
    );

    _cachedClinics = places;
    return places;
  }

  /// Fetch all nearby healthcare facilities
  Future<List<PlaceModel>> getNearbyHealthcare({
    int radius = 5000,
    bool forceRefresh = false,
  }) async {
    final hospitals = await getNearbyHospitals(
      radius: radius,
      forceRefresh: forceRefresh,
    );
    final clinics = await getNearbyClinics(
      radius: radius,
      forceRefresh: forceRefresh,
    );

    // Combine and sort by distance
    final allPlaces = [...hospitals, ...clinics];
    allPlaces.sort((a, b) => (a.distanceKm ?? 999).compareTo(b.distanceKm ?? 999));

    _lastFetch = DateTime.now();
    return allPlaces;
  }

  /// Search for nearby places
  Future<List<PlaceModel>> _searchNearbyPlaces({
    required String type,
    int radius = 5000,
  }) async {
    try {
      // Check if API key is configured
      if (!isConfigured) {
        debugPrint('Google Places API key not configured. Using demo data.');
        return _getDemoPlaces(type);
      }

      // Get current location
      final position = await _locationService.getCurrentLocation();
      if (position == null) {
        debugPrint('Could not get location. Using demo data.');
        return _getDemoPlaces(type);
      }

      final url = Uri.parse(
        '$_baseUrl?location=${position.latitude},${position.longitude}'
        '&radius=$radius'
        '&type=$type'
        '&key=$_apiKey',
      );

      debugPrint('Fetching places from: $url');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final results = data['results'] as List;

          final places = results.map((place) {
            final placeModel = PlaceModel.fromGooglePlaces(place);

            // Calculate distance
            placeModel.distanceKm = _locationService.calculateDistance(
              placeModel.latitude,
              placeModel.longitude,
            );
            placeModel.distanceText = _locationService.formatDistance(
              placeModel.distanceKm!,
            );

            return placeModel;
          }).toList();

          // Sort by distance
          places.sort(
              (a, b) => (a.distanceKm ?? 999).compareTo(b.distanceKm ?? 999));

          return places;
        } else {
          debugPrint('Places API error: ${data['status']}');
          return _getDemoPlaces(type);
        }
      } else {
        debugPrint('HTTP error: ${response.statusCode}');
        return _getDemoPlaces(type);
      }
    } catch (e) {
      debugPrint('Error fetching places: $e');
      return _getDemoPlaces(type);
    }
  }

  /// Get place photo URL
  String getPhotoUrl(String photoReference, {int maxWidth = 400}) {
    if (!isConfigured) return '';
    return '$_photoUrl?maxwidth=$maxWidth&photo_reference=$photoReference&key=$_apiKey';
  }

  /// Check if cache is still valid (5 minutes)
  bool _isCacheValid() {
    if (_lastFetch == null) return false;
    return DateTime.now().difference(_lastFetch!).inMinutes < 5;
  }

  /// Clear cache
  void clearCache() {
    _cachedClinics = [];
    _cachedHospitals = [];
    _lastFetch = null;
  }

  /// Get demo places for development/testing
  List<PlaceModel> _getDemoPlaces(String type) {
    if (type == 'hospital') {
      return [
        PlaceModel(
          placeId: 'demo_hospital_1',
          name: 'Grande International Hospital',
          address: 'Tokha Road, Kathmandu',
          latitude: 27.7372,
          longitude: 85.3240,
          rating: 4.5,
          totalRatings: 1250,
          isOpen: true,
          types: ['hospital', 'health'],
          distanceKm: 2.3,
          distanceText: '2.3 km',
        ),
        PlaceModel(
          placeId: 'demo_hospital_2',
          name: 'Norvic International Hospital',
          address: 'Thapathali, Kathmandu',
          latitude: 27.6939,
          longitude: 85.3157,
          rating: 4.3,
          totalRatings: 890,
          isOpen: true,
          types: ['hospital', 'health'],
          distanceKm: 3.5,
          distanceText: '3.5 km',
        ),
        PlaceModel(
          placeId: 'demo_hospital_3',
          name: 'Bir Hospital',
          address: 'Mahaboudha, Kathmandu',
          latitude: 27.7048,
          longitude: 85.3126,
          rating: 4.0,
          totalRatings: 2100,
          isOpen: true,
          types: ['hospital', 'health'],
          distanceKm: 4.1,
          distanceText: '4.1 km',
        ),
        PlaceModel(
          placeId: 'demo_hospital_4',
          name: 'Nepal Medical College',
          address: 'Jorpati, Kathmandu',
          latitude: 27.7407,
          longitude: 85.3681,
          rating: 4.2,
          totalRatings: 650,
          isOpen: true,
          types: ['hospital', 'health'],
          distanceKm: 5.8,
          distanceText: '5.8 km',
        ),
      ];
    } else {
      return [
        PlaceModel(
          placeId: 'demo_clinic_1',
          name: 'Nepal Mediciti',
          address: 'Bhaisepati, Lalitpur',
          latitude: 27.6651,
          longitude: 85.3003,
          rating: 4.6,
          totalRatings: 520,
          isOpen: true,
          types: ['doctor', 'health'],
          distanceKm: 1.8,
          distanceText: '1.8 km',
        ),
        PlaceModel(
          placeId: 'demo_clinic_2',
          name: 'Hams Hospital',
          address: 'Dhumbarahi, Kathmandu',
          latitude: 27.7285,
          longitude: 85.3365,
          rating: 4.4,
          totalRatings: 380,
          isOpen: true,
          types: ['doctor', 'health'],
          distanceKm: 2.1,
          distanceText: '2.1 km',
        ),
        PlaceModel(
          placeId: 'demo_clinic_3',
          name: 'Om Hospital',
          address: 'Chabahil, Kathmandu',
          latitude: 27.7176,
          longitude: 85.3497,
          rating: 4.1,
          totalRatings: 290,
          isOpen: false,
          types: ['doctor', 'health'],
          distanceKm: 3.2,
          distanceText: '3.2 km',
        ),
        PlaceModel(
          placeId: 'demo_clinic_4',
          name: 'Vayodha Hospital',
          address: 'Balkhu, Kathmandu',
          latitude: 27.6856,
          longitude: 85.2989,
          rating: 4.3,
          totalRatings: 410,
          isOpen: true,
          types: ['doctor', 'health'],
          distanceKm: 4.5,
          distanceText: '4.5 km',
        ),
      ];
    }
  }
}

