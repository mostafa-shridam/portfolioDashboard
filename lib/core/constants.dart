import 'package:flutter/material.dart';

import 'models/templete_card.dart';
import 'theme/style.dart';

void unfocusCurrent() => FocusManager.instance.primaryFocus?.unfocus();

const supportedLocales = [Locale('en'), Locale('ar')];
const translationsPath = 'assets/translations';
List<TempleteCard> getTemplateData() {
  return [
    TempleteCard(
      title: 'Modern Minimalist',
      description: 'Clean and simple design with focus on content',
      icon: Icons.web,
      color: warningYellow.toARGB32(),
      badge: 'Popular',
      features: ['Responsive', 'Fast', 'SEO'],
    ),
    TempleteCard(
      title: 'Creative Portfolio',
      description: 'Bold and colorful design for creative professionals',
      icon: Icons.palette,
      color: const Color(0xFF7F1E9D).toARGB32(),
      badge: 'Trending',
      features: ['Animated', 'Gallery', 'Custom'],
    ),
    TempleteCard(
      title: 'Professional',
      description: 'Corporate style with professional layout',
      icon: Icons.business_center,
      color: infoColor.toARGB32(),
      badge: 'New',
      features: ['Clean', 'Modern', 'Business'],
    ),
    TempleteCard(
      title: 'Developer Focus',
      description: 'Code-focused design for developers',
      icon: Icons.code,
      color: dangerRed.toARGB32(),
      badge: 'Best',
      features: ['Code', 'GitHub', 'Projects'],
    ),
    TempleteCard(
      title: 'Photography',
      description: 'Image-heavy layout for photographers',
      icon: Icons.photo_camera,
      color: 0xFF24884E,
      badge: 'Premium',
      features: ['Gallery', 'Lightbox', 'Portfolio'],
    ),
    TempleteCard(
      title: 'Interactive',
      description: 'Dynamic animations and transitions',
      icon: Icons.touch_app,
      color: accentColor.toARGB32(),
      badge: 'Hot',
      features: ['3D', 'Animated', 'Modern'],
    ),
  ];
}

const supabaseUrl = 'https://zhukfsnlbtcbklkoxwgb.supabase.co';
const supabaseAPIKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpodWtmc25sYnRjYmtsa294d2diIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2MDgyMTIyNywiZXhwIjoyMDc2Mzk3MjI3fQ.lLKToXtl5KO3jbdsA3kuyRBSrkiotzwTMG9m5sYxTFs';
