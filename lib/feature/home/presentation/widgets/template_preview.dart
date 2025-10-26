import 'package:flutter/material.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/portfolio_templates/developer_professional/professional.dart';

class TemplatePreview extends StatelessWidget {
  final int templateIndex;
  final UserModel userData;

  const TemplatePreview({
    super.key,
    required this.templateIndex,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return ProfessionalDev(userData: userData);
  }
}
