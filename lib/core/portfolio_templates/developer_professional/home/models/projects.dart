import 'package:flutter/material.dart';

class Project {
  final String title;
  final String description;
  final String image;
  final List<String> images;
  final Map<String, Color> tags;

  const Project({
    required this.title,
    required this.description,
    required this.image,
    required this.tags,
    required this.images,
  });
}
