import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants.dart';
import '../../../../core/theme/style.dart';
import '../../data/providers/home_provider.dart';
import 'teplete_card.dart';

class DesignWidget extends ConsumerWidget {
  const DesignWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final selectedTemplateIndex = ref
        .watch(homeProviderProvider)
        .selectedTemplateIndex;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(70)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.dashboard_customize,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Portfolio Templates',
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Choose a template for your portfolio website',
                      style: textTheme.bodyMedium?.copyWith(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: GridView.builder(
              padding: EdgeInsets.all(4),
              itemCount: getTemplateData().length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final template = getTemplateData()[index];
                return TemplateCard(
                  index: index,
                  title: template.title,
                  description: template.description,
                  icon: template.icon,
                  color: Color(template.color),
                  badge: template.badge,
                  features: template.features,
                  isDark: isDark,
                  screenWidth: screenWidth,
                  isSelected: selectedTemplateIndex == index,
                  onTap: () {
                    ref
                        .read(homeProviderProvider.notifier)
                        .selectTemplate(index, Color(template.color));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
