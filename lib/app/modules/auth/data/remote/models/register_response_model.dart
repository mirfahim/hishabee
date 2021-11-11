// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/user_model.dart';

RegisterResponseModel registerResponseModelFromJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

RegisterResponseModel registerResponseModelFromRawJson(dynamic json) {
  print("RR: $json");
  return RegisterResponseModel.fromJson(json);
}

String registerResponseToJson(RegisterResponseModel data) =>
    json.encode(data.toJson());

class RegisterResponseModel {
  RegisterResponseModel({
    this.code,
    this.message,
    this.user,
    this.accessToken,
  });

  int code;
  String message;
  User user;
  String accessToken;

  RegisterResponseModel copyWith({
    int code,
    String message,
    User user,
    String accessToken,
  }) =>
      RegisterResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        user: user ?? this.user,
        accessToken: accessToken ?? this.accessToken,
      );

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
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
