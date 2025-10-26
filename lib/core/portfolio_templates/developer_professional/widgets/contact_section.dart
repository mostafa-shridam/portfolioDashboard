import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../mixins/copy.dart';
import '../../../mixins/scaffold_messeneger.dart';
import '../../../mixins/url_launcher.dart';
import '../../../models/user_model.dart';

class ContactSection extends StatelessWidget
    with CopyMixin, ScaffoldMessengerMixin {
  const ContactSection({
    super.key,
    required this.userData,
    required this.selectedColor,
  });
  final UserModel userData;
  final int selectedColor;
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      color: Color(selectedColor).withValues(alpha: 0.1),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 16 : 32,
      ),
      margin: EdgeInsets.only(top: isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Contact Me',
            style: Theme.of(context).textTheme.titleLarge,
          ).animate().fadeIn().slideX(begin: -0.2, end: 0),
          const SizedBox(height: 8),
          Text(
            'I\'m always open to new opportunities and collaborations. Feel free to reach out to me.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'My phone number: ${userData.phone ?? ''}',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              IconButton(
                onPressed: () {
                  copyToClipboard(userData.phone ?? '');
                  showSnackBar(
                    context: context,
                    message: 'Phone number copied to clipboard',
                    color: selectedColor,
                  );
                },
                icon: Icon(Icons.copy, size: 16, color: Color(selectedColor)),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 24 : 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: isMobile ? 8 : 16,
            children: [
              ContactButton(
                label: 'Email',
                icon: Icons.email,
                url: 'mailto:${userData.email ?? ''}',
                selectedColor: selectedColor,
              ),
              ContactButton(
                label: 'LinkedIn',
                icon: FontAwesomeIcons.linkedin,
                url: userData.profileImage ?? '',
                selectedColor: selectedColor,
              ),
              ContactButton(
                label: 'WhatsApp',
                icon: FontAwesomeIcons.whatsapp,
                url: 'https://wa.me/${userData.phone ?? ''}',
                selectedColor: selectedColor,
              ),
              ContactButton(
                label: 'Facebook',
                icon: FontAwesomeIcons.facebook,
                url: '',
                selectedColor: selectedColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ContactButton extends StatelessWidget with UrlLauncherMixin {
  final String label;
  final IconData icon;
  final String url;
  final int selectedColor;
  const ContactButton({
    super.key,
    required this.label,
    required this.icon,
    required this.url,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return GestureDetector(
      onTap: () => myLaunchUrl(url),
      child: Container(
        decoration: BoxDecoration(
          color: Color(selectedColor).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 12,
          vertical: isMobile ? 6 : 8,
        ),
        child: Center(
          child: Row(
            children: [
              Icon(icon, size: isMobile ? 18 : 20, color: Color(selectedColor)),
              SizedBox(width: isMobile ? 6 : 8),
              Text(label, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 400.ms);
  }
}
