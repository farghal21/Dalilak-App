import 'package:dalilak_app/core/user/data/models/user_model.dart';

class LoginResponseModel {
  bool? success;
  String? message;
  Data? data;
  String? errors;

  LoginResponseModel({this.success, this.message, this.data, this.errors});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    errors = json['errors'];
  }
}

class Data {
  String? accessToken;
  String? refreshToken;
  String? expiresAt;
  UserModel? user;
  String? message;

  Data(
      {this.accessToken,
      this.refreshToken,
      this.expiresAt,
      this.user,
      this.message});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    expiresAt = json['expiresAt'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    message = json['message'];
  }
}
