import 'package:userportfolio/core/models/user_model.dart';

import 'social_link.dart';
import 'project.dart';
import 'skill.dart';
import 'course.dart';
import 'experience.dart';
import 'education.dart';

class PortfolioModel {
  UserModel? user;
  String? jobTitle;

  String? location;
  String? resumeUrl;
  List<SocialLink>? socialLinks;
  List<Project>? projects;
  List<Skill>? skills;
  List<Course>? courses;
  List<Experience>? experience;
  List<Education>? education;
  List<String>? languages;

  PortfolioModel({
    this.user,
    this.jobTitle,
    this.location,
    this.resumeUrl,
    this.socialLinks,
    this.projects,
    this.skills,
    this.courses,
    this.experience,
    this.education,
    this.languages,
  });

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    return PortfolioModel(
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      jobTitle: json['job_title'],
      location: json['location'],
      resumeUrl: json['resume_url'],
      socialLinks: json['social_links'] != null
          ? (json['social_links'] as List)
                .map((e) => SocialLink.fromJson(e))
                .toList()
          : null,
      projects: json['projects'] != null
          ? (json['projects'] as List).map((e) => Project.fromJson(e)).toList()
          : null,
      skills: json['skills'] != null
          ? (json['skills'] as List).map((e) => Skill.fromJson(e)).toList()
          : null,
      courses: json['courses'] != null
          ? (json['courses'] as List).map((e) => Course.fromJson(e)).toList()
          : null,
      experience: json['experience'] != null
          ? (json['experience'] as List)
                .map((e) => Experience.fromJson(e))
                .toList()
          : null,
      education: json['education'] != null
          ? (json['education'] as List)
                .map((e) => Education.fromJson(e))
                .toList()
          : null,
      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'job_title': jobTitle,
      'location': location,
      'resume_url': resumeUrl,
      'social_links': socialLinks?.map((e) => e.toJson()).toList(),
      'projects': projects?.map((e) => e.toJson()).toList(),
      'skills': skills?.map((e) => e.toJson()).toList(),
      'courses': courses?.map((e) => e.toJson()).toList(),
      'experience': experience?.map((e) => e.toJson()).toList(),
      'education': education?.map((e) => e.toJson()).toList(),
      'languages': languages,
    };
  }
}
