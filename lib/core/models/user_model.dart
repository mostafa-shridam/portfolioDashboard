class UserModel {
  String? id;
  String? profileImage;
  String? name;
  String? bio;
  String? email;
  String? phone;
  String? provider;
  String? authType;

  UserModel({
    this.id,
    this.profileImage,
    this.name,
    this.bio,
    this.email,
    this.phone,
    this.provider,
    this.authType,
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
      'provider': provider,
      'authType': authType,
    };
  }
}
