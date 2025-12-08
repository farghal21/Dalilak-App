class UserModel {
  String? id;
  String? name;
  String? email;
  String? role;
  bool? isAccountVerified;
  String? phone;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.role,
      this.isAccountVerified,
      this.phone});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    isAccountVerified = json['isAccountVerified'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    data['isAccountVerified'] = isAccountVerified;
    data['phone'] = phone;
    return data;
  }
}
