import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:userportfolio/core/theme/style.dart';

import '../../../../core/extensions/language.dart';
import '../../../../core/widgets/custom_progress.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });
  final String icon;
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final language = Language.fromString(context.locale.languageCode);
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.all(language == Language.arabic ? 2 : 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: primaryColor.withAlpha(60)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: isLoading
            ? Center(child: CustomProgress())
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(icon),
                    SizedBox(width: 16),
                    Text(text, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
      ),
    );
  }
}
