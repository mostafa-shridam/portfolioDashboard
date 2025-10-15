class SocialLink {
  String? platform;
  String? url;
  String? icon;

  SocialLink({
    this.platform,
    this.url,
    this.icon,
  });

  factory SocialLink.fromJson(Map<String, dynamic> json) {
    return SocialLink(
      platform: json['platform'],
      url: json['url'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'platform': platform,
      'url': url,
      'icon': icon,
    };
  }
}
