import 'package:flutter/cupertino.dart';

class TempleteCard {
  final String title;
  final String description;
  final IconData icon;
  final int color;
  final String badge;
  final List<String> features;

  TempleteCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.badge,
    required this.features,
  });
  factory TempleteCard.fromJson(Map<String, dynamic> json) {
    return TempleteCard(
      title: json['title'],
      description: json['description'],
      icon: json['icon'],
      color: json['color'],
      badge: json['badge'],
      features: json['features'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'icon': icon,
      'color': color,
      'badge': badge,
      'features': features,
    };
  }
}
