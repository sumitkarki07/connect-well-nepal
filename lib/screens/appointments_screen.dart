import 'package:flutter/material.dart';
import 'package:connect_well_nepal/utils/colors.dart';

/// AppointmentsScreen - Manage user appointments
/// 
/// Features:
/// - View upcoming appointments
/// - View past appointments
/// - Book new appointments
/// - Cancel/reschedule appointments
/// 
/// TODO (Team Member 1): Implement full appointment management
class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});
  
  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  // Track selected tab (0: Upcoming, 1: Past)
  int _selectedTab = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Appointments'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to book appointment screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Book appointment - Coming Soon!')),
              );
            },
            tooltip: 'Book Appointment',
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab selector
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.backgroundOffWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildTabButton('Upcoming', 0),
                ),
                Expanded(
                  child: _buildTabButton('Past', 1),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: _selectedTab == 0 
                ? _buildUpcomingAppointments()
                : _buildPastAppointments(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTabButton(String label, int index) {
    final bool isSelected = _selectedTab == index;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryNavyBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
  
  Widget _buildUpcomingAppointments() {
    // TODO: Replace with real data from Firebase
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            size: 80,
            color: AppColors.primaryNavyBlue.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          const Text(
            'No Upcoming Appointments',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Book your first appointment',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Navigate to booking screen
            },
            icon: const Icon(Icons.add),
            label: const Text('Book Appointment'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPastAppointments() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80,
            color: AppColors.primaryNavyBlue.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          const Text(
            'No Past Appointments',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

