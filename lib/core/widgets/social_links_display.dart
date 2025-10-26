import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:userportfolio/core/models/user_model.dart';
import 'package:userportfolio/core/theme/style.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinksDisplay extends StatelessWidget {
  final UserModel userData;
  final bool isHorizontal;
  final double iconSize;

  const SocialLinksDisplay({
    super.key,
    required this.userData,
    this.isHorizontal = true,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    final socialLinks = _getSocialLinks();

    if (socialLinks.isEmpty) {
      return SizedBox.shrink();
    }

    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: socialLinks.map((link) => _buildSocialIcon(link)).toList(),
    );
  }

  List<SocialLink> _getSocialLinks() {
    final links = <SocialLink>[];
    final socialLinks = userData.socialLinks;

    if (socialLinks?.githubUrl != null && socialLinks!.githubUrl!.isNotEmpty) {
      links.add(
        SocialLink(
          url: socialLinks.githubUrl!,
          icon: FontAwesomeIcons.github,
          label: 'GitHub',
          color: Colors.black,
        ),
      );
    }

    if (socialLinks?.linkedinUrl != null &&
        socialLinks!.linkedinUrl!.isNotEmpty) {
      links.add(
        SocialLink(
          url: socialLinks.linkedinUrl!,
          icon: FontAwesomeIcons.linkedin,
          label: 'LinkedIn',
          color: Color(0xFF0077B5),
        ),
      );
    }

    if (socialLinks?.websiteUrl != null &&
        socialLinks!.websiteUrl!.isNotEmpty) {
      links.add(
        SocialLink(
          url: socialLinks.websiteUrl!,
          icon: FontAwesomeIcons.globe,
          label: 'Website',
          color: primaryColor,
        ),
      );
    }

    if (socialLinks?.facebookUrl != null &&
        socialLinks!.facebookUrl!.isNotEmpty) {
      links.add(
        SocialLink(
          url: socialLinks.facebookUrl!,
          icon: FontAwesomeIcons.facebook,
          label: 'Facebook',
          color: Color(0xFF1877F2),
        ),
      );
    }

    if (socialLinks?.twitterUrl != null &&
        socialLinks!.twitterUrl!.isNotEmpty) {
      links.add(
        SocialLink(
          url: socialLinks.twitterUrl!,
          icon: FontAwesomeIcons.twitter,
          label: 'Twitter/X',
          color: Color(0xFF1DA1F2),
        ),
      );
    }

    if (socialLinks?.instagramUrl != null &&
        socialLinks!.instagramUrl!.isNotEmpty) {
      links.add(
        SocialLink(
          url: socialLinks.instagramUrl!,
          icon: FontAwesomeIcons.instagram,
          label: 'Instagram',
          color: Color(0xFFE4405F),
        ),
      );
    }

    if (socialLinks?.youtubeUrl != null &&
        socialLinks!.youtubeUrl!.isNotEmpty) {
      links.add(
        SocialLink(
          url: socialLinks.youtubeUrl!,
          icon: FontAwesomeIcons.youtube,
          label: 'YouTube',
          color: Color(0xFFFF0000),
        ),
      );
    }

    if (socialLinks?.behanceUrl != null &&
        socialLinks!.behanceUrl!.isNotEmpty) {
      links.add(
        SocialLink(
          url: socialLinks.behanceUrl!,
          icon: FontAwesomeIcons.behance,
          label: 'Behance',
          color: Color(0xFF1769FF),
        ),
      );
    }

    if (socialLinks?.dribbbleUrl != null &&
        socialLinks!.dribbbleUrl!.isNotEmpty) {
      links.add(
        SocialLink(
          url: socialLinks.dribbbleUrl!,
          icon: FontAwesomeIcons.dribbble,
          label: 'Dribbble',
          color: Color(0xFFEA4C89),
        ),
      );
    }

    return links;
  }

  Widget _buildSocialIcon(SocialLink link) {
    return InkWell(
      onTap: () => _launchUrl(link.url),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: link.color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: link.color.withValues(alpha: 0.8),
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(link.icon, size: iconSize, color: link.color),
            if (!isHorizontal) ...[
              SizedBox(width: 8),
              Text(
                link.label,
                style: TextStyle(
                  color: link.color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Could not launch $url: $e');
    }
  }
}

class SocialLink {
  final String url;
  final IconData icon;
  final String label;
  final Color color;

  SocialLink({
    required this.url,
    required this.icon,
    required this.label,
    required this.color,
  });
}
