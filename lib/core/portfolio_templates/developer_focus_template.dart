import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../theme/style.dart';

class DeveloperFocusTemplate extends StatelessWidget {
  final UserModel userData;

  const DeveloperFocusTemplate({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      color: isDark ? Color(0xFF0D1117) : Color(0xFFFFFFFF),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Terminal-style header
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? Color(0xFF161B22) : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? Color(0xFF30363D) : Colors.grey[300]!,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            userData.profileImage != null &&
                                userData.profileImage!.isNotEmpty
                            ? NetworkImage(userData.profileImage!)
                            : null,
                        child:
                            userData.profileImage == null ||
                                userData.profileImage!.isEmpty
                            ? Icon(Icons.person, size: 40)
                            : null,
                      ),
                      SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '> ${userData.name ?? 'Developer Name'}',
                              style: textTheme.headlineMedium?.copyWith(
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.bold,
                                color: successGreen,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '# ${userData.bio ?? 'Full Stack Developer'}',
                              style: textTheme.bodyMedium?.copyWith(
                                fontFamily: 'monospace',
                                color: isDark
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 48),

            // GitHub-style stats
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    '150+',
                    'Repositories',
                    Icons.folder_outlined,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(context, '500+', 'Commits', Icons.code),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    context,
                    '50+',
                    'Pull Requests',
                    Icons.merge_type,
                  ),
                ),
              ],
            ),
            SizedBox(height: 48),

            // Projects
            Text(
              '📁 Projects',
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 24),
            ...List.generate(4, (index) => _buildProjectCard(context, index)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String value,
    String label,
    IconData icon,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? Color(0xFF161B22) : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Color(0xFF30363D) : Colors.grey[300]!,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: successGreen, size: 32),
          SizedBox(height: 12),
          Text(
            value,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: successGreen,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 4),
          Text(label, style: textTheme.bodySmall?.copyWith(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? Color(0xFF161B22) : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Color(0xFF30363D) : Colors.grey[300]!,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.folder, color: successGreen, size: 32),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'awesome-project-${index + 1}',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: successGreen,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'A cool project description',
                  style: textTheme.bodySmall?.copyWith(fontSize: 13),
                ),
              ],
            ),
          ),
          Chip(
            label: Text('Flutter'),
            backgroundColor: primaryColor.withAlpha(20),
          ),
        ],
      ),
    );
  }
}
