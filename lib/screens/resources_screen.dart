import 'package:flutter/material.dart';
import 'package:connect_well_nepal/utils/colors.dart';

/// ResourcesScreen - Health education and self-care resources
/// 
/// Features:
/// - Health articles
/// - Video tutorials
/// - Self-care tips
/// - Mental health resources
/// - COVID-19 information
/// 
/// TODO (Team Member 3): Populate with actual health content
/// Consider integrating a CMS or using Firebase for content management
class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Resources'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Search bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search health topics...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: AppColors.backgroundOffWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Categories
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryNavyBlue,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Category Cards
          _buildCategoryCard(
            icon: Icons.favorite,
            title: 'Heart Health',
            color: AppColors.secondaryCrimsonRed,
            onTap: () {},
          ),
          
          _buildCategoryCard(
            icon: Icons.psychology,
            title: 'Mental Wellness',
            color: Colors.purple,
            onTap: () {},
          ),
          
          _buildCategoryCard(
            icon: Icons.restaurant,
            title: 'Nutrition',
            color: Colors.green,
            onTap: () {},
          ),
          
          _buildCategoryCard(
            icon: Icons.fitness_center,
            title: 'Fitness & Exercise',
            color: Colors.orange,
            onTap: () {},
          ),
          
          _buildCategoryCard(
            icon: Icons.vaccines,
            title: 'Vaccinations',
            color: Colors.blue,
            onTap: () {},
          ),
          
          _buildCategoryCard(
            icon: Icons.masks,
            title: 'COVID-19 Info',
            color: AppColors.primaryNavyBlue,
            onTap: () {},
          ),
          
          const SizedBox(height: 24),
          
          // Featured Article Section
          const Text(
            'Featured Articles',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryNavyBlue,
            ),
          ),
          
          const SizedBox(height: 16),
          
          _buildArticleCard(
            title: 'Managing Stress During Difficult Times',
            readTime: '5 min read',
            imageIcon: Icons.self_improvement,
          ),
          
          _buildArticleCard(
            title: 'Understanding Common Health Conditions',
            readTime: '8 min read',
            imageIcon: Icons.health_and_safety,
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
  
  Widget _buildArticleCard({
    required String title,
    required String readTime,
    required IconData imageIcon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder image
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: AppColors.primaryNavyBlue.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Center(
              child: Icon(
                imageIcon,
                size: 60,
                color: AppColors.primaryNavyBlue.withValues(alpha: 0.5),
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      readTime,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

