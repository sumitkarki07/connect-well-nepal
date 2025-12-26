/// ClinicModel - Data model representing a healthcare clinic
/// 
/// This model stores information about clinics that will be displayed
/// in the app's home screen, including location and contact details.
class ClinicModel {
  // Clinic name (e.g., "Bir Hospital")
  final String name;
  
  // Physical address of the clinic
  final String address;
  
  // Contact phone number
  final String phoneNumber;
  
  // Distance from user in kilometers
  final double distance;
  
  /// Constructor for creating a ClinicModel instance
  /// 
  /// All fields are required to ensure complete clinic information
  ClinicModel({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.distance,
  });
  
  // Optional: Add a factory constructor for JSON parsing in the future
  // factory ClinicModel.fromJson(Map<String, dynamic> json) {
  //   return ClinicModel(
  //     name: json['name'],
  //     address: json['address'],
  //     phoneNumber: json['phoneNumber'],
  //     distance: json['distance'].toDouble(),
  //   );
  // }
}

