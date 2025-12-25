import 'package:flutter/material.dart';
import 'package:connect_well_nepal/utils/colors.dart';

/// ConsultationScreen - Video/Voice consultation interface
/// 
/// Features:
/// - Start video consultation
/// - Start voice call
/// - Chat with doctor
/// - View doctor profile
/// 
/// TODO (Team Member 2): Implement video/voice call integration
/// Consider using: Agora, Jitsi, or Firebase WebRTC
class ConsultationScreen extends StatelessWidget {
  const ConsultationScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Consultation'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            const Text(
              'Choose Your Consultation Type',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavyBlue,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 32),
            
            // Video Consultation Card
            _buildConsultationCard(
              context,
              icon: Icons.video_call,
              title: 'Video Consultation',
              description: 'Face-to-face consultation with doctor',
              color: AppColors.primaryNavyBlue,
              onTap: () {
                _showComingSoonDialog(context, 'Video Consultation');
              },
            ),
            
            const SizedBox(height: 16),
            
            // Voice Call Card
            _buildConsultationCard(
              context,
              icon: Icons.phone,
              title: 'Voice Call',
              description: 'Audio consultation with doctor',
              color: AppColors.secondaryCrimsonRed,
              onTap: () {
                _showComingSoonDialog(context, 'Voice Call');
              },
            ),
            
            const SizedBox(height: 16),
            
            // Chat Consultation Card
            _buildConsultationCard(
              context,
              icon: Icons.chat_bubble,
              title: 'Chat Consultation',
              description: 'Text-based consultation',
              color: AppColors.successGreen,
              onTap: () {
                _showComingSoonDialog(context, 'Chat Consultation');
              },
            ),
            
            const Spacer(),
            
            // Emergency Button
            OutlinedButton.icon(
              onPressed: () {
                _showEmergencyDialog(context);
              },
              icon: const Icon(Icons.emergency),
              label: const Text('Emergency Contacts'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.secondaryCrimsonRed,
                side: const BorderSide(color: AppColors.secondaryCrimsonRed),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildConsultationCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
  
  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(feature),
        content: Text('$feature will be available soon!\n\nOur team is working on integrating video/voice call functionality.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  
  void _showEmergencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.emergency, color: AppColors.secondaryCrimsonRed),
            SizedBox(width: 8),
            Text('Emergency Contacts'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🚑 Ambulance: 102'),
            SizedBox(height: 8),
            Text('🏥 Police: 100'),
            SizedBox(height: 8),
            Text('🔥 Fire: 101'),
            SizedBox(height: 8),
            Text('☎️ Nepal Red Cross: 1130'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

