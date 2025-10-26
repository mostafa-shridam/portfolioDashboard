import 'package:flutter/material.dart';

class Course {
  final String title;
  final String platform;
  final String date;
  final IconData icon;
  final String url;
  final String costractor;

  const Course({
    required this.title,
    required this.platform,
    required this.date,
    required this.icon,
    required this.url,
    required this.costractor,
  });
}
