class Experience {
  String? id;
  String? company;
  String? companyLogo;
  String? position;
  String? description;
  String? location;
  String? startDate;
  String? endDate;
  bool? isCurrent;
  List<String>? responsibilities;
  List<String>? technologies;

  Experience({
    this.id,
    this.company,
    this.companyLogo,
    this.position,
    this.description,
    this.location,
    this.startDate,
    this.endDate,
    this.isCurrent,
    this.responsibilities,
    this.technologies,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'],
      company: json['company'],
      companyLogo: json['company_logo'],
      position: json['position'],
      description: json['description'],
      location: json['location'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      isCurrent: json['is_current'],
      responsibilities: json['responsibilities'] != null
          ? List<String>.from(json['responsibilities'])
          : null,
      technologies: json['technologies'] != null
          ? List<String>.from(json['technologies'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'company_logo': companyLogo,
      'position': position,
      'description': description,
      'location': location,
      'start_date': startDate,
      'end_date': endDate,
      'is_current': isCurrent,
      'responsibilities': responsibilities,
      'technologies': technologies,
    };
  }
}
