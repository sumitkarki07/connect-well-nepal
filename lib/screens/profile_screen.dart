import 'package:flutter/material.dart';
import 'package:connect_well_nepal/utils/colors.dart';

/// ProfileScreen - User profile management screen
/// 
/// Allows users to:
/// - View and edit their full name
/// - Update medical history information
/// - Save profile changes
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _medicalHistoryController = TextEditingController();
  
  @override
  void dispose() {
    // Clean up controllers when widget is disposed
    _nameController.dispose();
    _medicalHistoryController.dispose();
    super.dispose();
  }
  
  /// Handles the save profile action
  void _saveProfile() {
    // TODO: In the future, integrate with Firebase to save user data
    final String name = _nameController.text;
    final String medicalHistory = _medicalHistoryController.text;
    
    // Show confirmation to user
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile saved successfully!'),
        backgroundColor: AppColors.successGreen,
        duration: Duration(seconds: 2),
      ),
    );
    
    // Log for debugging (remove in production)
    debugPrint('Profile saved - Name: $name, Medical History: $medicalHistory');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              
              // Large Circular Avatar
              CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.primaryNavyBlue.withValues(alpha: 0.1),
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: AppColors.primaryNavyBlue,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // User hint text
              Text(
                'Update your profile information',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Full Name TextField
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primaryNavyBlue,
                      width: 2,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Medical History TextField (Multi-line)
              TextField(
                controller: _medicalHistoryController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Medical History',
                  hintText: 'Enter any relevant medical history...',
                  prefixIcon: const Icon(Icons.medical_services_outlined),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primaryNavyBlue,
                      width: 2,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Save Profile Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryCrimsonRed,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Save Profile',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

