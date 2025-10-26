import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../models/project.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key, required this.selectedColor});
  final int selectedColor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 16 : 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Projects',
            style: Theme.of(context).textTheme.titleLarge,
          ).animate().fadeIn().slideX(begin: -0.2, end: 0),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              crossAxisCount: isMobile
                  ? 1
                  : isTablet
                  ? 2
                  : isDesktop
                  ? 2
                  : 3,
              childAspectRatio: isMobile
                  ? 2.1
                  : isTablet
                  ? 1.3
                  : isDesktop
                  ? 2.4
                  : 2.6,
            ),
            itemBuilder: (context, index) => ProjectCard(
              project: projects[index],
              index: index,
              selectedColor: selectedColor,
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends ConsumerWidget {
  final Project project;
  final int index;
  final int selectedColor;
  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final textTheme = Theme.of(context).textTheme;
    return Card(
          elevation: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Color(selectedColor).withValues(alpha: 0.4),
              width: 2,
            ),
          ),
          color: Color(selectedColor).withValues(alpha: 0.2),
          child: InkWell(
            onTap: () {
              // Navigator.pushNamed(
              //   context,
              //   ProjectDetails.routeName,
              //   arguments: project,
              // );
            },
            borderRadius: BorderRadius.circular(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(selectedColor).withValues(alpha: 0.3),
                  ),
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SvgPicture.asset(
                      project.image ?? '',
                      fit: BoxFit.contain,
                      width: isMobile ? 100 : 120,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 8 : 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          project.title ?? '',
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: isMobile ? 6 : 8),
                        Text(
                          project.description ?? '',
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 16),
                        // Wrap(
                        //   spacing: isMobile ? 6 : 8,
                        //   runSpacing: isMobile ? 6 : 8,
                        //   children: project.tags.entries
                        //       .take(6)
                        //       .map(
                        //         (entry) => ProjectTag(
                        //           tag: entry.key,
                        //           color: entry.value,
                        //         ),
                        //       )
                        //       .toList(),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 100 * index))
        .slideY(begin: 0.2, end: 0, delay: Duration(milliseconds: 100 * index));
  }
}

class ProjectTag extends StatelessWidget {
  const ProjectTag({super.key, required this.tag, required this.color});
  final String tag;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
        color: color.withAlpha(16),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 4 : 6,
          vertical: isMobile ? 2 : 4,
        ),
        child: Text(
          tag,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontSize: isMobile ? 11 : 2),
        ),
      ),
    );
  }
}

final List<Project> projects = [
  Project(
    title: 'Project sadfadfsafdgdlkjhijhk ksjchgjyukhiljkhvj1',
    description: 'Description 1',
    image: '',

    technologies: ['Flutter', 'Dart'],
    images: [''],
  ),
];
