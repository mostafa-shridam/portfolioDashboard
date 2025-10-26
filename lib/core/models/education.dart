class Education {
  String? id;
  String? institution;
  String? institutionLogo;
  String? degree;
  String? field;
  String? location;
  String? startDate;
  String? endDate;
  double? gpa;
  String? description;
  List<String>? achievements;

  Education({
    this.id,
    this.institution,
    this.institutionLogo,
    this.degree,
    this.field,
    this.location,
    this.startDate,
    this.endDate,
    this.gpa,
    this.description,
    this.achievements,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'],
      institution: json['institution'],
      institutionLogo: json['institution_logo'],
      degree: json['degree'],
      field: json['field'],
      location: json['location'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      gpa: json['gpa']?.toDouble(),
      description: json['description'],
      achievements: json['achievements'] != null
          ? List<String>.from(json['achievements'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'institution': institution,
      'institution_logo': institutionLogo,
      'degree': degree,
      'field': field,
      'location': location,
      'start_date': startDate,
      'end_date': endDate,
      'gpa': gpa,
      'description': description,
      'achievements': achievements,
    };
  }
}
