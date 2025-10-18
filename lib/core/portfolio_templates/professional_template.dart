import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../theme/style.dart';

class ProfessionalTemplate extends StatelessWidget {
  final UserModel userData;

  const ProfessionalTemplate({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      color: isDark ? greenSwatch.shade900 : Colors.white,
      child: Row(
        children: [
          // Sidebar
          Container(
            width: 300,
            color: isDark ? greenSwatch.shade800 : greenSwatch.shade900,
            padding: EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      userData.profileImage != null &&
                          userData.profileImage!.isNotEmpty
                      ? NetworkImage(userData.profileImage!)
                      : null,
                  child:
                      userData.profileImage == null ||
                          userData.profileImage!.isEmpty
                      ? Icon(Icons.person, size: 60)
                      : null,
                ),
                SizedBox(height: 24),
                Text(
                  userData.name ?? 'Professional Name',
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  userData.email ?? 'email@example.com',
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 32),
                _buildSidebarItem(Icons.work, 'Experience', context),
                _buildSidebarItem(Icons.school, 'Education', context),
                _buildSidebarItem(Icons.code, 'Skills', context),
                _buildSidebarItem(Icons.folder, 'Projects', context),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Professional Profile',
                    style: textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    userData.bio ?? 'Professional summary goes here...',
                    style: textTheme.bodyMedium?.copyWith(fontSize: 14),
                  ),
                  SizedBox(height: 48),
                  Text(
                    'Experience',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 24),
                  ...List.generate(
                    3,
                    (index) => Padding(
                      padding: EdgeInsets.only(bottom: 24),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Position ${index + 1}',
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Company Name',
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '2020 - Present',
                                style: textTheme.bodySmall?.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String label, BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 18),
          SizedBox(width: 12),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
