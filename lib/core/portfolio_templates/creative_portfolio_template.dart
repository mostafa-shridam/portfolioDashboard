import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../theme/style.dart';

class CreativePortfolioTemplate extends StatelessWidget {
  final UserModel userData;

  const CreativePortfolioTemplate({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [accentColor.withAlpha(10), primaryColor.withAlpha(10)],
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(48),
        child: Column(
          children: [
            // Creative Header
            Container(
              padding: EdgeInsets.all(48),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [primaryColor, accentColor]),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage:
                          userData.profileImage != null &&
                              userData.profileImage!.isNotEmpty
                          ? NetworkImage(userData.profileImage!)
                          : null,
                      child:
                          userData.profileImage == null ||
                              userData.profileImage!.isEmpty
                          ? Icon(Icons.person, size: 70, color: primaryColor)
                          : null,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    userData.name ?? 'Creative Professional',
                    style: textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    userData.bio ?? 'Bringing ideas to life',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withAlpha(90),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 48),

            // Colorful Cards
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.2,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                final colors = [
                  primaryColor,
                  accentColor,
                  successGreen,
                  infoColor,
                ];
                return Container(
                  decoration: BoxDecoration(
                    color: colors[index].withAlpha(20),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colors[index], width: 2),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.palette, size: 64, color: colors[index]),
                        SizedBox(height: 16),
                        Text(
                          'Creative Work ${index + 1}',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
