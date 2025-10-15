class Skill {
  String? name;
  String? icon;
  String? image;
  int? proficiency;
  String? category;

  Skill({
    this.name,
    this.icon,
    this.image,
    this.proficiency,
    this.category,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'],
      icon: json['icon'],
      image: json['image'],
      proficiency: json['proficiency'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon,
      'image': image,
      'proficiency': proficiency,
      'category': category,
    };
  }
}
