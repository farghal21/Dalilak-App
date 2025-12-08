import '../../../../core/user/data/models/user_model.dart';

class LoginResponseModel {
  bool? success;
  Message? message;
  Data? data;
  SaudiContext? saudiContext;
  String? timestamp;

  LoginResponseModel(
      {this.success,
      this.message,
      this.data,
      this.saudiContext,
      this.timestamp});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    saudiContext = json['saudiContext'] != null
        ? SaudiContext.fromJson(json['saudiContext'])
        : null;
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
  UserModel? user;
  String? accessToken;
  String? refreshToken;
  String? timezone;
  String? currency;

  Data(
      {this.user,
      this.accessToken,
      this.refreshToken,
      this.timezone,
      this.currency});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    timezone = json['timezone'];
    currency = json['currency'];
  }
}

class SaudiContext {
  String? timezone;
  String? currency;
  String? country;
  String? countryCode;
  String? phonePrefix;
  String? currentTime;

  SaudiContext(
      {this.timezone,
      this.currency,
      this.country,
      this.countryCode,
      this.phonePrefix,
      this.currentTime});

  SaudiContext.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'];
    currency = json['currency'];
    country = json['country'];
    countryCode = json['countryCode'];
    phonePrefix = json['phonePrefix'];
    currentTime = json['currentTime'];
  }
}
