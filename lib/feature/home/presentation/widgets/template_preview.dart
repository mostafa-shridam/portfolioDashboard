import 'package:flutter/material.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/portfolio_templates/creative_portfolio_template.dart';
import '../../../../core/portfolio_templates/developer_focus_template.dart';
import '../../../../core/portfolio_templates/empty_template.dart';
import '../../../../core/portfolio_templates/interactive_template.dart';
import '../../../../core/portfolio_templates/modern_minimalist_template.dart';
import '../../../../core/portfolio_templates/photography_template.dart';
import '../../../../core/portfolio_templates/professional_template.dart';

class TemplatePreview extends StatelessWidget {
  final int templateIndex;
  final UserModel userData;
  final bool isEditable;

  const TemplatePreview({
    super.key,
    required this.templateIndex,
    required this.userData,
    this.isEditable = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isEditable) {
      return Stack(
        children: [
          _buildTemplate(),
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit, color: Colors.white, size: 16),
                  SizedBox(width: 4),
                  Text(
                    'Edit Mode',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return _buildTemplate();
  }

  Widget _buildTemplate() {
    switch (templateIndex) {
      case 0:
        return ModernMinimalistTemplate(
          userData: userData,
          isEditable: isEditable,
        );
      case 1:
        return CreativePortfolioTemplate(userData: userData);
      case 2:
        return ProfessionalTemplate(userData: userData);
      case 3:
        return DeveloperFocusTemplate(userData: userData);
      case 4:
        return PhotographyTemplate(userData: userData);
      case 5:
        return InteractiveTemplate(userData: userData);
      default:
        return EmptyTemplate();
    }
  }
}
