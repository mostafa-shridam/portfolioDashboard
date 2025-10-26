class SocialLinksModel {
  String? githubUrl;
  String? linkedinUrl;
  String? facebookUrl;
  String? twitterUrl;
  String? instagramUrl;
  String? websiteUrl;
  String? youtubeUrl;
  String? behanceUrl;
  String? dribbbleUrl;

  SocialLinksModel({
    this.githubUrl,
    this.linkedinUrl,
    this.facebookUrl,
    this.twitterUrl,
    this.instagramUrl,
    this.websiteUrl,
    this.youtubeUrl,
    this.behanceUrl,
    this.dribbbleUrl,
  });

  factory SocialLinksModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SocialLinksModel();
    }
    return SocialLinksModel(
      githubUrl: json['githubUrl'],
      linkedinUrl: json['linkedinUrl'],
      facebookUrl: json['facebookUrl'],
      twitterUrl: json['twitterUrl'],
      instagramUrl: json['instagramUrl'],
      websiteUrl: json['websiteUrl'],
      youtubeUrl: json['youtubeUrl'],
      behanceUrl: json['behanceUrl'],
      dribbbleUrl: json['dribbbleUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'githubUrl': githubUrl,
      'linkedinUrl': linkedinUrl,
      'facebookUrl': facebookUrl,
      'twitterUrl': twitterUrl,
      'instagramUrl': instagramUrl,
      'websiteUrl': websiteUrl,
      'youtubeUrl': youtubeUrl,
      'behanceUrl': behanceUrl,
      'dribbbleUrl': dribbbleUrl,
    };
  }

  // Helper method to check if any social link exists
  bool hasAnyLink() {
    return githubUrl?.isNotEmpty == true ||
        linkedinUrl?.isNotEmpty == true ||
        facebookUrl?.isNotEmpty == true ||
        twitterUrl?.isNotEmpty == true ||
        instagramUrl?.isNotEmpty == true ||
        websiteUrl?.isNotEmpty == true ||
        youtubeUrl?.isNotEmpty == true ||
        behanceUrl?.isNotEmpty == true ||
        dribbbleUrl?.isNotEmpty == true;
  }

  // Copy with method for easy updates
  SocialLinksModel copyWith({
    String? githubUrl,
    String? linkedinUrl,
    String? facebookUrl,
    String? twitterUrl,
    String? instagramUrl,
    String? websiteUrl,
    String? youtubeUrl,
    String? behanceUrl,
    String? dribbbleUrl,
  }) {
    return SocialLinksModel(
      githubUrl: githubUrl ?? this.githubUrl,
      linkedinUrl: linkedinUrl ?? this.linkedinUrl,
      facebookUrl: facebookUrl ?? this.facebookUrl,
      twitterUrl: twitterUrl ?? this.twitterUrl,
      instagramUrl: instagramUrl ?? this.instagramUrl,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      behanceUrl: behanceUrl ?? this.behanceUrl,
      dribbbleUrl: dribbbleUrl ?? this.dribbbleUrl,
    );
  }
}
