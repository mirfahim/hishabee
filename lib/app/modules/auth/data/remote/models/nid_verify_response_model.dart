// To parse this JSON data, do
//
//     final nidVerifyResponseModel = nidVerifyResponseModelFromJson(jsonString);

import 'dart:convert';

import 'user_model.dart';

NidVerifyResponseModel nidVerifyResponseModelFromJson(String str) =>
    NidVerifyResponseModel.fromJson(json.decode(str));
NidVerifyResponseModel nidVerifyResponseModelFromRawJson(dynamic json) {
  print("RE : $json");
  return NidVerifyResponseModel.fromJson(json);
}

String nidVerifyResponseModelToJson(NidVerifyResponseModel data) =>
    json.encode(data.toJson());

class NidVerifyResponseModel {
  NidVerifyResponseModel({
    this.code,
    this.message,
    this.user,
  });

  int code;
  String message;
  User user;

  NidVerifyResponseModel copyWith({
    int code,
    String message,
    User user,
  }) =>
      NidVerifyResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        user: user ?? this.user,
      );

  factory NidVerifyResponseModel.fromJson(Map<String, dynamic> json) {
    print("Json $json}");

    return NidVerifyResponseModel(
      code: json["code"] == null ? null : json["code"],
      message: json["message"] == null ? null : json["message"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "user": user == null ? null : user.toJson(),
      };
}
