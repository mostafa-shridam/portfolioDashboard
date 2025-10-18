import 'package:flutter/material.dart';
import '../models/user_model.dart';

class PhotographyTemplate extends StatelessWidget {
  final UserModel userData;

  const PhotographyTemplate({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      color: Colors.black,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Full-width hero image
            Container(
              height: 500,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withAlpha(50), Colors.black],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          userData.profileImage != null &&
                              userData.profileImage!.isNotEmpty
                          ? NetworkImage(userData.profileImage!)
                          : null,
                      child:
                          userData.profileImage == null ||
                              userData.profileImage!.isEmpty
                          ? Icon(
                              Icons.camera_alt,
                              size: 70,
                              color: Colors.black,
                            )
                          : null,
                    ),
                    SizedBox(height: 24),
                    Text(
                      userData.name ?? 'Photographer Name',
                      style: textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      userData.bio ?? 'Visual Storyteller',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 48),

            // Gallery grid
            Padding(
              padding: EdgeInsets.all(24),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.image,
                        size: 64,
                        color: Colors.grey[600],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
