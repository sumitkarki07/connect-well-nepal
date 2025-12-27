import 'package:flutter/material.dart';
import 'package:connect_well_nepal/models/clinic_model.dart';
import 'package:connect_well_nepal/widgets/clinic_card.dart';
import 'package:connect_well_nepal/screens/profile_screen.dart';
import 'package:connect_well_nepal/screens/appointments_screen.dart';
import 'package:connect_well_nepal/screens/consultation_screen.dart';
import 'package:connect_well_nepal/screens/resources_screen.dart';
import 'package:connect_well_nepal/utils/colors.dart';

/// MainScreen - Primary navigation shell of the app
/// 
/// This screen manages the bottom navigation bar and displays:
/// 1. Home Tab: List of nearby clinics + quick actions
/// 2. Appointments Tab: Manage appointments
/// 3. Resources Tab: Health education content
/// 4. Profile Tab: User profile management
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Track currently selected tab (0: Home, 1: Appointments, 2: Resources, 3: Profile)
  int _currentIndex = 0;
  
  // Hardcoded sample clinic data for demonstration
  // TODO: Replace with Firebase data in the future
  final List<ClinicModel> _sampleClinics = [
    ClinicModel(
      name: 'Bir Hospital',
      address: 'Mahaboudha, Kathmandu',
      phoneNumber: '+977-1-4221119',
      distance: 2.3,
    ),
    ClinicModel(
      name: 'Patan Hospital',
      address: 'Lagankhel, Lalitpur',
      phoneNumber: '+977-1-5522266',
      distance: 4.7,
    ),
    ClinicModel(
      name: 'TU Teaching Hospital',
      address: 'Maharajgunj, Kathmandu',
      phoneNumber: '+977-1-4412303',
      distance: 5.2,
    ),
  ];
  
  /// Builds the Home tab with quick actions and clinic listings
  Widget _buildHomeTab() {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Connect Well Nepal Logo Icon
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/logos/logo_icon.png',
                height: 32,
                width: 32,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            const Text('Connect Well Nepal'),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          // Quick Actions Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryNavyBlue,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildQuickActionCard(
                        icon: Icons.video_call,
                        label: 'Consult Now',
                        color: AppColors.secondaryCrimsonRed,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ConsultationScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildQuickActionCard(
                        icon: Icons.calendar_today,
                        label: 'Book Appointment',
                        color: AppColors.primaryNavyBlue,
                        onTap: () {
                          setState(() => _currentIndex = 1);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Nearby Clinics Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Nearby Clinics',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavyBlue,
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Clinic Cards
          ...List.generate(
            _sampleClinics.length,
            (index) => ClinicCard(clinic: _sampleClinics[index]),
          ),
        ],
      ),
    );
  }
  
  Widget _buildQuickActionCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  
  /// Returns the appropriate widget based on selected tab
  Widget _getSelectedScreen() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return const AppointmentsScreen();
      case 2:
        return const ResourcesScreen();
      case 3:
        return const ProfileScreen();
      default:
        return _buildHomeTab();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Display the selected screen
      body: _getSelectedScreen(),
      
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryNavyBlue,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            activeIcon: Icon(Icons.library_books),
            label: 'Resources',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

