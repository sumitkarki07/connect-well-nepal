/// PlaceModel - Represents a nearby clinic or hospital
///
/// This model stores place information from Google Places API:
/// - Basic info (name, address)
/// - Location coordinates
/// - Rating and reviews
/// - Distance from user
class PlaceModel {
  final String placeId;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final double? rating;
  final int? totalRatings;
  final bool isOpen;
  final String? photoReference;
  final List<String> types;
  double? distanceKm;
  String? distanceText;

  PlaceModel({
    required this.placeId,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.rating,
    this.totalRatings,
    this.isOpen = false,
    this.photoReference,
    this.types = const [],
    this.distanceKm,
    this.distanceText,
  });

  /// Create PlaceModel from Google Places API response
  factory PlaceModel.fromGooglePlaces(Map<String, dynamic> json) {
    final geometry = json['geometry']?['location'] ?? {};
    final openingHours = json['opening_hours'] ?? {};

    return PlaceModel(
      placeId: json['place_id'] ?? '',
      name: json['name'] ?? 'Unknown',
      address: json['vicinity'] ?? json['formatted_address'] ?? 'No address',
      latitude: (geometry['lat'] ?? 0).toDouble(),
      longitude: (geometry['lng'] ?? 0).toDouble(),
      rating: json['rating']?.toDouble(),
      totalRatings: json['user_ratings_total'],
      isOpen: openingHours['open_now'] ?? false,
      photoReference: json['photos']?[0]?['photo_reference'],
      types: List<String>.from(json['types'] ?? []),
    );
  }

  /// Create PlaceModel from Map (for local storage)
  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      placeId: map['placeId'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      latitude: map['latitude'] ?? 0.0,
      longitude: map['longitude'] ?? 0.0,
      rating: map['rating'],
      totalRatings: map['totalRatings'],
      isOpen: map['isOpen'] ?? false,
      photoReference: map['photoReference'],
      types: List<String>.from(map['types'] ?? []),
      distanceKm: map['distanceKm'],
      distanceText: map['distanceText'],
    );
  }

  /// Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'placeId': placeId,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'totalRatings': totalRatings,
      'isOpen': isOpen,
      'photoReference': photoReference,
      'types': types,
      'distanceKm': distanceKm,
      'distanceText': distanceText,
    };
  }

  /// Check if this is a hospital
  bool get isHospital => types.contains('hospital');

  /// Check if this is a clinic/doctor
  bool get isClinic =>
      types.contains('doctor') ||
      types.contains('health') ||
      types.contains('physiotherapist') ||
      types.contains('dentist');

  /// Get place type display name
  String get typeDisplayName {
    if (types.contains('hospital')) return 'Hospital';
    if (types.contains('doctor')) return 'Clinic';
    if (types.contains('dentist')) return 'Dental Clinic';
    if (types.contains('pharmacy')) return 'Pharmacy';
    if (types.contains('physiotherapist')) return 'Physiotherapy';
    return 'Healthcare';
  }

  /// Get formatted rating text
  String get ratingText {
    if (rating == null) return 'No ratings';
    return '$rating (${totalRatings ?? 0} reviews)';
  }
}

