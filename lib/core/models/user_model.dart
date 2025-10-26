import 'social_links_model.dart';

class UserModel {
  String? id;
  String? profileImage;
  String? name;
  String? bio;
  String? email;
  String? phone;
  String? provider;
  String? authType;
  String? jobTitle;
  String? location;
  String? resumeUrl;
  int? selectedColor;
  List<String>? languages;
  SocialLinksModel? socialLinks;

  UserModel({
    this.id,
    this.profileImage,
    this.name,
    this.bio,
    this.email,
    this.phone,
    this.provider,
    this.authType,
    this.socialLinks,
    this.jobTitle,
    this.location,
    this.resumeUrl,
    this.languages,
    this.selectedColor,
  });
  factory UserModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return UserModel();
    }
    return UserModel(
      id: json['id'],
      profileImage: json['profileImage'],
      name: json['name'],
      bio: json['bio'],
      email: json['email'],
      phone: json['phone'],
      provider: json['provider'],
      authType: json['authType'],
      jobTitle: json['jobTitle'],
      location: json['location'],
      resumeUrl: json['resumeUrl'],
      selectedColor: json['selectedColor'],
      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : null,
      socialLinks: json['socialLinks'] != null
          ? SocialLinksModel.fromJson(json['socialLinks'])
          : SocialLinksModel.fromJson({
              'githubUrl': json['githubUrl'],
              'linkedinUrl': json['linkedinUrl'],
              'facebookUrl': json['facebookUrl'],
              'twitterUrl': json['twitterUrl'],
              'instagramUrl': json['instagramUrl'],
              'websiteUrl': json['websiteUrl'],
              'youtubeUrl': json['youtubeUrl'],
              'behanceUrl': json['behanceUrl'],
              'dribbbleUrl': json['dribbbleUrl'],
            }),
    );
  }

  Map<String, dynamic> toJson() {
    final socialLinksJson = socialLinks?.toJson() ?? {};
    return {
      'id': id,
      'profileImage': profileImage,
      'name': name,
      'bio': bio,
      'email': email,
      'phone': phone,
      'provider': provider,
      'authType': authType,
      'jobTitle': jobTitle,
      'location': location,
      'resumeUrl': resumeUrl,
      'languages': languages,
      'selectedColor': selectedColor,
      'socialLinks': socialLinksJson,
      // Keep backward compatibility
      ...socialLinksJson,
    };
  }
}
