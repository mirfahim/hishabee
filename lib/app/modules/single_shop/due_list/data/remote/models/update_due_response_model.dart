// To parse this JSON data, do
//
//     final updateDueResponseModel = updateDueResponseModelFromJson(jsonString);

import 'dart:convert';

import 'get_all_due_response_model.dart';

UpdateDueResponseModel updateDueResponseModelFromJson(String str) =>
    UpdateDueResponseModel.fromJson(json.decode(str));
UpdateDueResponseModel updateDueResponseModelFromRawJson(dynamic json) =>
    UpdateDueResponseModel.fromJson(json);

String updateDueResponseModelToJson(UpdateDueResponseModel data) =>
    json.encode(data.toJson());

class UpdateDueResponseModel {
  UpdateDueResponseModel({
    this.code,
    this.message,
    this.due,
  });

  int code;
  String message;
  Due due;

  UpdateDueResponseModel copyWith({
    int code,
    String message,
    Due due,
  }) =>
      UpdateDueResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        due: due ?? this.due,
      );

  factory UpdateDueResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateDueResponseModel(
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
