import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:responsive_framework/responsive_framework.dart';

import '../../../mixins/url_launcher.dart';
import '../../../models/user_model.dart';
import '../../../widgets/social_links_display.dart';
import '../../../widgets/languages_display.dart';

class HeroSection extends ConsumerWidget with UrlLauncherMixin {
  const HeroSection({
    super.key,
    required this.userData,
    required this.selectedColor,
  });
  final UserModel userData;
  final int selectedColor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(selectedColor),
            Color(selectedColor).withAlpha(100),
            Color(selectedColor).withAlpha(50),
            Color(selectedColor).withAlpha(25),
          ],
        ),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(end: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 32,
                    vertical: isMobile ? 16 : 56,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: isMobile ? 80 : 120,
                        backgroundColor: Color(
                          selectedColor,
                        ).withValues(alpha: 0.2),
                        backgroundImage: NetworkImage(
                          userData.profileImage ?? '',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        userData.bio ?? '',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      Text(
                            userData.name ?? '',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          )
                          .animate()
                          .fadeIn(duration: 600.ms)
                          .slideX(begin: -0.2, end: 0, duration: 600.ms),
                      const SizedBox(height: 16),
                      if (userData.jobTitle != null &&
                          userData.jobTitle!.isNotEmpty)
                        Text(
                              userData.jobTitle!,
                              style: textTheme.bodyLarge?.copyWith(
                                color: isDark ? Colors.white70 : Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                            .animate()
                            .fadeIn(delay: 200.ms, duration: 600.ms)
                            .slideX(begin: -0.2, end: 0, duration: 600.ms),

                      const SizedBox(height: 32),
                      SocialLinksDisplay(userData: userData),
                    ],
                  ),
                ),
              ),
              // Location
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 8,
                children: [
                  SizedBox(height: 32),
                  if (!isMobile)
                    Center(
                      child: Icon(
                        Icons.code,
                        size: isMobile ? 150 : 200,
                        color: Colors.white,
                      ),
                    ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
                  if (userData.location != null &&
                      userData.location!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              userData.location!,
                              style: textTheme.bodyMedium?.copyWith(
                                color: isDark ? Colors.white60 : Colors.black45,
                              ),
                            ),
                            const SizedBox(width: 8),

                            Icon(
                              FontAwesomeIcons.locationDot,
                              size: 14,
                              color: isDark ? Colors.white60 : Colors.black45,
                            ),
                          ],
                        )
                        .animate()
                        .fadeIn(delay: 300.ms, duration: 600.ms)
                        .slideX(begin: -0.2, end: 0, duration: 600.ms),
                  ],
                  // Languages
                  if (userData.languages != null &&
                      userData.languages!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    SizedBox(
                      width: 500,
                      child:
                          Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                alignment: WrapAlignment.end,

                                children: [
                                  Icon(
                                    FontAwesomeIcons.language,
                                    size: 14,
                                    color: isDark
                                        ? Colors.white60
                                        : Colors.black45,
                                  ),
                                  LanguagesDisplay(
                                    languageCodes: userData.languages!,
                                    showNativeNames: false,
                                    spacing: 6,
                                    runSpacing: 4,
                                    selectedColor: selectedColor,
                                  ),
                                ],
                              )
                              .animate()
                              .fadeIn(delay: 400.ms, duration: 600.ms)
                              .slideX(begin: -0.2, end: 0, duration: 600.ms),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
