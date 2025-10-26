import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../feature/home/data/providers/home_provider.dart';
import '../../../gen/assets.gen.dart';
import '../../../feature/settings/data/providers/settings.dart';
import '../../extensions/theme_mode.dart';
import '../../models/user_model.dart';
import 'widgets/about_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/courses_section.dart';
import 'widgets/hero_section.dart';
import 'widgets/projects_section.dart';
import 'widgets/skills_section.dart';
import 'widgets/nav_item.dart';

class ProfessionalDev extends ConsumerStatefulWidget {
  final UserModel userData;
  const ProfessionalDev({super.key, required this.userData});
  @override
  ConsumerState<ProfessionalDev> createState() => _ProfessionalDevState();
}

class _ProfessionalDevState extends ConsumerState<ProfessionalDev> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    final userData = widget.userData;
    final selectedColor =
        ref.watch(homeProviderProvider).colorCallback?.toARGB32() ??
        userData.selectedColor ??
        0;
    return Scaffold(
      backgroundColor: Color(selectedColor).withValues(alpha: 0.1),
      drawer: isMobile
          ? Drawer(
              backgroundColor: Color(selectedColor),
              surfaceTintColor: Color(selectedColor),
              child: ListView(
                children: [
                  NavItemMobile(
                    index: 0,
                    title: 'Home',
                    selectedColor: selectedColor,
                  ),
                  NavItemMobile(
                    index: 1,
                    title: 'About',
                    selectedColor: selectedColor,
                  ),
                  NavItemMobile(
                    index: 2,
                    title: 'Skills',
                    selectedColor: selectedColor,
                  ),
                  NavItemMobile(
                    index: 3,
                    title: 'Projects',
                    selectedColor: selectedColor,
                  ),
                  NavItemMobile(
                    index: 4,
                    title: 'Courses',
                    selectedColor: selectedColor,
                  ),
                  NavItemMobile(
                    index: 5,
                    title: 'Contact',
                    selectedColor: selectedColor,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    width: double.infinity,
                    color: Color(selectedColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Theme mode',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            isDarkMode ? Icons.light_mode : Icons.dark_mode,
                          ),
                          onPressed: () {
                            ref
                                .read(settingsProvider.notifier)
                                .changeThemeMode(
                                  isDarkMode ? Thememode.light : Thememode.dark,
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Color(selectedColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Download CV',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Icon(Icons.download),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
      appBar: AppBar(
        backgroundColor: Color(selectedColor).withValues(alpha: 0.3),
        leading: isMobile
            ? null
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  clipBehavior: Clip.antiAlias,
                  child: SvgPicture.asset(Assets.images.google),
                ),
              ),
        actionsPadding: EdgeInsets.zero,
        actions: isMobile
            ? null
            : [
                IconButton(
                  icon: Icon(
                    isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: Color(selectedColor),
                  ),
                  onPressed: () {
                    ref
                        .read(settingsProvider.notifier)
                        .changeThemeMode(
                          isDarkMode ? Thememode.light : Thememode.dark,
                        );
                  },
                ),
                const SizedBox(width: 16),
                NavItem(index: 0, title: 'Home'),
                NavItem(index: 1.2, title: 'About'),
                NavItem(index: 2.15, title: 'Skills'),
                NavItem(index: 2.54, title: 'Projects'),
                NavItem(index: 3.04, title: 'Courses'),
                NavItem(index: 5, title: 'Contact'),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    margin: const EdgeInsets.only(top: 12, bottom: 8),
                    decoration: BoxDecoration(
                      color: Color(selectedColor).withAlpha(60),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Download CV',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.download, color: Color(selectedColor)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
        title: Text(
          '${userData.name ?? ''} Portfolio',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        controller: ref.watch(settingsProvider.notifier).scrollController,

        child: Column(
          children: [
            HeroSection(
              userData: widget.userData,
              selectedColor: selectedColor,
            ),
            AboutSection(selectedColor: selectedColor),
            SkillsSection(selectedColor: selectedColor),
            ProjectsSection(selectedColor: selectedColor),
            CoursesSection(selectedColor: selectedColor),
            ContactSection(
              userData: widget.userData,
              selectedColor: selectedColor,
            ),
          ],
        ),
      ),
    );
  }
}
