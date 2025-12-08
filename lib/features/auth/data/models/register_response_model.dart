class RegisterResponseModel {
  bool? success;
  Message? message;
  Data? data;
  String? timestamp;

  RegisterResponseModel({
    this.success,
    this.message,
    this.data,
    this.timestamp,
  });

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

    timestamp = json['timestamp'];
  }
}

class Message {
  String? en;
  String? ar;

  Message({this.en, this.ar});

  Message.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }
}

class Data {
  String? userId;
  String? email;
  String? name;
  String? timezone;
  String? country;

  Data({this.userId, this.email, this.name, this.timezone, this.country});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    name = json['name'];
    timezone = json['timezone'];
    country = json['country'];
  }
}
