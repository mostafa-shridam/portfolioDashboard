import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:userportfolio/core/local_service/save_user.dart';
import 'package:userportfolio/feature/home/data/providers/about_provider.dart';

import '../../../models/about.dart';
import '../../../models/education.dart';
import '../../../models/experience.dart';

class AboutSection extends ConsumerWidget {
  const AboutSection({super.key, required this.selectedColor});
  final int selectedColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final workExperience =
        ref.read(saveUserProvider.select((e) => e.getWorkExperience())) ?? [];
    final education =
        ref.read(saveUserProvider.select((e) => e.getEducation())) ?? [];
    final aboutData =
        ref.read(saveUserProvider.select((e) => e.getAboutData())) ??
        ref.watch(
          aboutProviderProvider.select((e) => e.about ?? AboutModel()),
        ) ??
        AboutModel();
    final isLoading = ref.watch(
      aboutProviderProvider.select((e) => e.isLoading ?? false),
    );
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 16 : 32,
      ),
      child: isMobile
          ? _buildMobileLayout(
              context: context,
              theme: theme,
              isDark: isDark,
              aboutData: aboutData,
              workExperience: workExperience,
              education: education,
            )
          : _buildDesktopLayout(
              context: context,
              theme: theme,
              aboutData: aboutData,
              workExperience: workExperience,
              education: education,
            ),
    );
  }

  Widget _buildMobileLayout({
    required BuildContext context,
    required ThemeData theme,
    required bool isDark,
    required AboutModel aboutData,
    required List<Experience> workExperience,
    required List<Education> education,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'About Me'),
        const SizedBox(height: 16),
        Text(
          aboutData.bio ?? '',
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.6,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on, size: 16),
            const SizedBox(width: 8),
            Text(
              aboutData.location ?? '',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.circle, color: Colors.green, size: 12),
            const SizedBox(width: 8),
            Text(
              aboutData.isAvailableForWork ?? false
                  ? 'Available for new projects'
                  : 'Not available for new projects',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        if (workExperience.isNotEmpty) ...[
          _buildSectionTitle(context, 'Work Experience'),
          const SizedBox(height: 16),
          ...workExperience.map(
            (e) => _buildWorkExperienceItem(
              context: context,
              title: e.position ?? '',
              company: e.company ?? '',
              period:
                  e.startDate?.toString() ??
                  ' - ${e.endDate?.toString() ?? ''}',
              responsibilities: e.responsibilities ?? [],
              theme: theme,
              selectedColor: selectedColor,
            ),
          ),
        ],
        if (education.isNotEmpty) ...[
          _buildSectionTitle(context, 'Education'),
          const SizedBox(height: 16),
          ...education.map(
            (e) => _buildEducationItem(
              context: context,
              title: e.degree ?? '',
              subtitle: e.institution ?? '',
              year:
                  e.startDate?.toString() ??
                  ' - ${e.endDate?.toString() ?? ''}',
            ),
          ),
        ],
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildDesktopLayout({
    required BuildContext context,
    required ThemeData theme,
    required AboutModel aboutData,
    required List<Experience> workExperience,
    required List<Education> education,
  }) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (aboutData.bio != null) ...[
                _buildSectionTitle(context, 'About Me'),
                const SizedBox(height: 16),
                Text(
                  aboutData.bio ?? '',
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 32),
              ],
              if (workExperience.isNotEmpty) ...[
                _buildSectionTitle(context, 'Work Experience'),
                const SizedBox(height: 16),
                ...workExperience.map(
                  (e) => _buildWorkExperienceItem(
                    context: context,
                    title: e.position ?? '',
                    company: e.company ?? '',
                    period:
                        e.startDate?.toString() ??
                        ' - ${e.endDate?.toString() ?? ''}',
                    responsibilities: e.responsibilities ?? [],
                    theme: theme,
                    selectedColor: selectedColor,
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ],
          ),
        ),
        SizedBox(width: isMobile ? 24 : 32),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (education.isNotEmpty) ...[
                _buildSectionTitle(context, 'Education'),
                const SizedBox(height: 16),
                ...education.map(
                  (e) => _buildEducationItem(
                    context: context,
                    title: e.degree ?? '',
                    subtitle: e.institution ?? '',
                    year:
                        e.startDate?.toString() ??
                        ' - ${e.endDate?.toString() ?? ''}',
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    ).animate().fadeIn().slideX(begin: -0.2, end: 0);
  }

  Widget _buildWorkExperienceItem({
    required BuildContext context,
    required String title,
    required String company,
    required String period,
    required List<String> responsibilities,
    required ThemeData theme,
    required int selectedColor,
  }) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: Color(selectedColor).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(selectedColor).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            company,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(period, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 12),
          ...responsibilities.map(
            (responsibility) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.circle,
                    size: isMobile ? 6 : 8,
                    color: Color(selectedColor),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      responsibility,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark ? Colors.white70 : Colors.black54,
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

  Widget _buildEducationItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String year,
  }) {
    {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
          Text(
            year,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      );
    }
  }
}
