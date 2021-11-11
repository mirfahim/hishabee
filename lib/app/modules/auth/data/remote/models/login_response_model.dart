// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/user_model.dart';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));
LoginResponseModel loginResponseModelFromRawJson(dynamic json) =>
    LoginResponseModel.fromJson(json);

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.code,
    this.message,
    this.user,
    this.accessToken,
  });

  int code;
  String message;
  User user;
  String accessToken;

  LoginResponseModel copyWith({
    int code,
    String message,
    User user,
    String accessToken,
  }) =>
      LoginResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        user: user ?? this.user,
        accessToken: accessToken ?? this.accessToken,
      );

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        accessToken: json["access_token"] == null ? null : json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "user": user == null ? null : user.toJson(),
        "access_token": accessToken == null ? null : accessToken,
      };
}
