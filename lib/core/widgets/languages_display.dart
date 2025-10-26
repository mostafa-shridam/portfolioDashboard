import 'package:flutter/material.dart';
import 'package:userportfolio/core/models/language_model.dart';

class LanguagesDisplay extends StatelessWidget {
  final List<String> languageCodes;
  final bool showNativeNames;
  final double spacing;
  final double runSpacing;
  final int selectedColor;

  const LanguagesDisplay({
    super.key,
    required this.languageCodes,
    this.showNativeNames = true,
    this.spacing = 8,
    this.runSpacing = 8,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    if (languageCodes.isEmpty) {
      return SizedBox.shrink();
    }

    final languages = languageCodes
        .map((code) => Languages.findByCode(code))
        .where((lang) => lang != null)
        .cast<LanguageModel>()
        .toList();

    if (languages.isEmpty) {
      return SizedBox.shrink();
    }

    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: languages
          .map((lang) => _buildLanguageChip(lang, context))
          .toList(),
    );
  }

  Widget _buildLanguageChip(LanguageModel language, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(selectedColor).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(selectedColor).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        showNativeNames ? language.nativeName : language.name,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Color(selectedColor)),
      ),
    );
  }
}
