// To parse this JSON data, do
//
//     final addMessageResponse = addMessageResponseFromJson(jsonString);

import 'dart:convert';

import 'message_model.dart';

AddMessageResponseModel addMessageResponseModelFromJson(String str) =>
    AddMessageResponseModel.fromJson(json.decode(str));

AddMessageResponseModel addMessageResponseModelFromMap(dynamic json) =>
    AddMessageResponseModel.fromJson(json);

String addMessageResponseModelToJson(AddMessageResponseModel data) =>
    json.encode(data.toJson());

class AddMessageResponseModel {
  AddMessageResponseModel({
    this.code,
    this.message,
  });

  int code;
  Message message;

  AddMessageResponseModel copyWith({
    int code,
    Message message,
  }) =>
      AddMessageResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
      );

  factory AddMessageResponseModel.fromJson(Map<String, dynamic> json) =>
      AddMessageResponseModel(
        code: json["code"] == null ? null : json["code"],
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message.toJson(),
      };
}
