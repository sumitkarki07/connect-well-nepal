import 'package:flutter/material.dart';
import 'package:connect_well_nepal/utils/colors.dart';
import 'package:connect_well_nepal/screens/main_screen.dart';

/// SplashScreen - Initial loading screen with logo
/// 
/// Displays the Connect Well Nepal logo and branding
/// Auto-navigates to MainScreen after 2 seconds
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }
  
  /// Navigate to main screen after delay
  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Connect Well Nepal Logo
            Image.asset(
              'assets/logos/logo.png',
              width: 200,
              height: 200,
            ),
            
            const SizedBox(height: 24),
            
            // App Name
            const Text(
              'Connect Well',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavyBlue,
              ),
            ),
            
            const Text(
              'Nepal',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryCrimsonRed,
              ),
            ),
            
            const SizedBox(height: 8),
            
            const Text(
              'Your Telehealth Partner',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Loading indicator
            const CircularProgressIndicator(
              color: AppColors.primaryNavyBlue,
            ),
          ],
        ),
      ),
    );
  }
}

