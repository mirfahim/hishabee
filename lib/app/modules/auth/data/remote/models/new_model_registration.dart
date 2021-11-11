// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) =>
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
  dynamic user;
  String accessToken;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        code: json["code"],
        message: json["message"],
        user: json["user"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "user": user,
        "access_token": accessToken,
      };
}
