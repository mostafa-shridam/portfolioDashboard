import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../gen/assets.gen.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key, required this.selectedColor});
  final int selectedColor;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Container(
      color: Color(selectedColor).withValues(alpha: 0.2),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 16 : 32,
      ),
      child: Column(
        children: [
          Text('Skills', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'The skills, tools, and technologies I\'m really good at :',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            children: List.generate(Assets.images.values.length, (index) {
              final asset = Assets.images.values[index];
              final fileName = asset.toString().split('/').last;
              final label = fileName.replaceAll('.svg', '').toUpperCase();
              return _TechChip(
                label: label,
                image: asset,
                color: label == 'Supabase' ? true : false,
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;
  final String image;
  final bool color;

  const _TechChip({
    this.color = false,
    required this.label,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            width: 54,
            height: 54,
            colorFilter: color
                ? ColorFilter.mode(Colors.green, BlendMode.srcIn)
                : null,
          ),
          SizedBox(height: 16),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
