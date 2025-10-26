import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../mixins/url_launcher.dart';
import '../../../models/course.dart';

class CoursesSection extends ConsumerWidget with UrlLauncherMixin {
  const CoursesSection({super.key, required this.selectedColor});
  final int selectedColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Text(
            'Courses & Certifications',
            style: textTheme.titleLarge,
          ).animate().fadeIn().slideX(),
          const SizedBox(height: 30),
          ResponsiveGridView.builder(
            gridDelegate: ResponsiveGridDelegate(
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              minCrossAxisExtent: isMobile
                  ? 200
                  : isTablet
                  ? 240
                  : 280,
              maxCrossAxisExtent: isMobile
                  ? 250
                  : isTablet
                  ? 300
                  : 350,
              childAspectRatio: isMobile
                  ? 1.36
                  : isTablet
                  ? 1.5
                  : isDesktop
                  ? 1.78
                  : 1.86,
            ),
            itemCount: courses.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CourseCard(
                course: courses[index],
                selectedColor: selectedColor,
              );
            },
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget with UrlLauncherMixin {
  final Course course;

  const CourseCard({
    super.key,
    required this.course,
    required this.selectedColor,
  });
  final int selectedColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: Color(selectedColor).withValues(alpha: 0.1),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Color(selectedColor).withValues(alpha: 0.4),
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () => myLaunchUrl(course.certificateUrl ?? ''),
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    FontAwesomeIcons.code,
                    color: Color(selectedColor),
                    size: 24,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      course.title ?? '',
                      style: textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '${course.platform} - ${course.instructor}',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Color(selectedColor)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    course.completedDate ?? '',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Color(selectedColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Course> courses = [
  Course(
    title: 'The Complete 2022 Flutter & Dart Development Course [Arabic]',
    platform: 'Udemy',
    completedDate: '2023-01-01',
    certificateUrl:
        'https://www.udemy.com/course/complete-flutter-arabic/?couponCode=UPGRADE02223',
    instructor: 'Abdullah Mansour',
  ),
  Course(
    title: 'Complete Flutter & Dart Development Course [Arabic]',
    platform: 'Udemy',
    completedDate: '2024-01-01',
    certificateUrl:
        'https://www.udemy.com/course/best-and-complete-flutter-course-for-beginners/?couponCode=UPGRADE02223',
    instructor: 'Tharwat Samy',
  ),
  Course(
    title:
        'Dart Programming Language And OOP For Beginner [In Arabic] Flutter & Dart - The Complete Guide',
    platform: 'Udemy',
    completedDate: '2024-01-01',
    certificateUrl:
        'https://www.udemy.com/course/dart-programming-language-and-oop-for-beginner-in-arabic/?couponCode=UPGRADE02223',
    instructor: 'Usama Elgendy',
  ),
  Course(
    title: 'Flutter REST Movie App: Master Flutter REST API Development',
    platform: 'Udemy',
    completedDate: '2025-01-01',
    certificateUrl:
        'https://www.udemy.com/course/flutter-rest-api-development-course-build-a-movie-app/?couponCode=UPGRADE02223',
    instructor: 'Hussain Mustafa',
  ),
];
