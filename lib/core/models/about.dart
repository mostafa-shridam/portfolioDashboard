import 'education.dart';
import 'experience.dart';

class AboutModel {
  String? userId;
  String? bio;
  String? jobTitle;
  String? location;
  bool? isAvailableForWork;
  AboutModel({
    this.userId,
    this.bio,
    this.jobTitle,
    this.location,
    this.isAvailableForWork,
  });
  factory AboutModel.fromJson(Map<String, dynamic> json) {
    return AboutModel(
      userId: json['userId'],
      bio: json['bio'],
      jobTitle: json['jobTitle'],
      location: json['location'],
      isAvailableForWork: json['isAvailableForWork'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'bio': bio,
      'jobTitle': jobTitle,
      'location': location,
      'isAvailableForWork': isAvailableForWork,
    };
  }

  AboutModel copyWith({
    String? userId,
    String? bio,
    String? jobTitle,
    String? location,
    List<String>? languages,
    List<Experience>? workExperience,
    List<Education>? education,
    bool? isAvailableForWork,
  }) {
    return AboutModel(
      userId: userId ?? this.userId,
      bio: bio ?? this.bio,
      jobTitle: jobTitle ?? this.jobTitle,
      location: location ?? this.location,
      isAvailableForWork: isAvailableForWork ?? this.isAvailableForWork,
    );
  }
}
