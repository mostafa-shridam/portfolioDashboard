class Project {
  String? id;
  String? title;
  String? description;
  String? image;
  List<String>? images;
  
  String? demoUrl;
  String? githubUrl;
  List<String>? technologies;
  String? category;
  DateTime? startDate;
  DateTime? endDate;
  bool? isFeatured;

  Project({
    this.id,
    this.title,
    this.description,
    this.image,
    this.images,
    this.demoUrl,
    this.githubUrl,
    this.technologies,
    this.category,
    this.startDate,
    this.endDate,
    this.isFeatured,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      demoUrl: json['demo_url'],
      githubUrl: json['github_url'],
      technologies: json['technologies'] != null
          ? List<String>.from(json['technologies'])
          : null,
      category: json['category'],
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      isFeatured: json['is_featured'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'images': images,
      'demo_url': demoUrl,
      'github_url': githubUrl,
      'technologies': technologies,
      'category': category,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'is_featured': isFeatured,
    };
  }
}