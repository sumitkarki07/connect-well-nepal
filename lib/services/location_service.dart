import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';

/// LocationService - Handles user location functionality
///
/// Features:
/// - Get current user location
/// - Calculate distance between two points
/// - Check and request location permissions
class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  Position? _currentPosition;
  bool _isInitialized = false;

  /// Get cached current position
  Position? get currentPosition => _currentPosition;

  /// Check if location is available
  bool get hasLocation => _currentPosition != null;

  /// Initialize location service and get current position
  Future<Position?> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('Location services are disabled.');
        return null;
      }

      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied.');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint('Location permissions are permanently denied.');
        return null;
      }

      // Get current position
      _currentPosition = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      _isInitialized = true;
      debugPrint(
          'Location obtained: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}');

      return _currentPosition;
    } catch (e) {
      debugPrint('Error getting location: $e');
      return null;
    }
  }

  /// Calculate distance between current location and a destination
  /// Returns distance in kilometers
  double calculateDistance(double destLat, double destLng) {
    if (_currentPosition == null) return 0;

    return Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          destLat,
          destLng,
        ) /
        1000; // Convert meters to kilometers
  }

  /// Format distance for display
  String formatDistance(double distanceKm) {
    if (distanceKm < 1) {
      return '${(distanceKm * 1000).round()} m';
    } else if (distanceKm < 10) {
      return '${distanceKm.toStringAsFixed(1)} km';
    } else {
      return '${distanceKm.round()} km';
    }
  }

  /// Get distance text from current location to a point
  String getDistanceText(double destLat, double destLng) {
    final distance = calculateDistance(destLat, destLng);
    return formatDistance(distance);
  }

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Request location permission
  Future<bool> requestPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      return permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    } catch (e) {
      debugPrint('Error requesting permission: $e');
      return false;
    }
  }

  /// Open app settings for location
  Future<bool> openSettings() async {
    return await Geolocator.openAppSettings();
  }

  /// Open location settings
  Future<bool> openLocationSettings() async {
    return await Geolocator.openLocationSettings();
  }
}

