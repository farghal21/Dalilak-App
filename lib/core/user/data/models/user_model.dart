class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? profileImageUrl;
  bool? isEmailVerified;
  bool? isActive;
  String? createdAt;
  String? lastLoginAt;
  String? fullName;

  UserModel(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.profileImageUrl,
        this.isEmailVerified,
        this.isActive,
        this.createdAt,
        this.lastLoginAt,
        this.fullName});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    profileImageUrl = json['profileImageUrl'];
    isEmailVerified = json['isEmailVerified'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    lastLoginAt = json['lastLoginAt'];
    fullName = json['fullName'];
  }

}
