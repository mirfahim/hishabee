// To parse this JSON data, do
//
//     final createSmsModel = createSmsModelFromJson(jsonString);

import 'dart:convert';

CreateSmsModel createSmsModelFromJson(String str) =>
    CreateSmsModel.fromJson(json.decode(str));

String createSmsModelToJson(CreateSmsModel data) => json.encode(data.toJson());

class CreateSmsModel {
  CreateSmsModel({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory CreateSmsModel.fromJson(Map<String, dynamic> json) => CreateSmsModel(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
