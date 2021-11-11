// To parse this JSON data, do
//
//     final addDueResponseModel = addDueResponseModelFromJson(jsonString);

import 'dart:convert';

import 'get_all_due_response_model.dart';

AddDueResponseModel addDueResponseModelFromJson(String str) =>
    AddDueResponseModel.fromJson(json.decode(str));
AddDueResponseModel addDueResponseModelFromRawJson(dynamic json) =>
    AddDueResponseModel.fromJson(json);

String addDueResponseModelToJson(AddDueResponseModel data) =>
    json.encode(data.toJson());

class AddDueResponseModel {
  AddDueResponseModel({
    this.code,
    this.message,
    this.due,
  });

  int code;
  String message;
  Due due;

  AddDueResponseModel copyWith({
    int code,
    String message,
    Due due,
  }) =>
      AddDueResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        due: due ?? this.due,
      );

  factory AddDueResponseModel.fromJson(Map<String, dynamic> json) =>
      AddDueResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        due: json["due"] == null ? null : Due.fromJson(json["due"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "due": due == null ? null : due.toJson(),
      };
}
