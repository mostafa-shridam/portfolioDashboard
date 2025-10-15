class UserModel {
  String? id;
  String? profileImage;
  String? name;
  String? bio;
  String? email;
  String? phone;

  UserModel({
    this.id,
    this.profileImage,
    this.name,
    this.bio,
    this.email,
    this.phone,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profileImage': profileImage,
      'name': name,
      'bio': bio,
      'email': email,
      'phone': phone,
    };
  }
}
