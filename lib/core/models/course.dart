class Course {
  String? id;
  String? title;
  String? description;
  String? image;
  String? instructor;
  String? platform;
  String? certificateUrl;
  DateTime? completedDate;
  List<String>? skills;
  double? rating;

  Course({
    this.id,
    this.title,
    this.description,
    this.image,
    this.instructor,
    this.platform,
    this.certificateUrl,
    this.completedDate,
    this.skills,
    this.rating,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      instructor: json['instructor'],
      platform: json['platform'],
      certificateUrl: json['certificate_url'],
      completedDate: json['completed_date'] != null
          ? DateTime.parse(json['completed_date'])
          : null,
      skills: json['skills'] != null ? List<String>.from(json['skills']) : null,
      rating: json['rating']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'instructor': instructor,
      'platform': platform,
      'certificate_url': certificateUrl,
      'completed_date': completedDate?.toIso8601String(),
      'skills': skills,
      'rating': rating,
    };
  }
}
