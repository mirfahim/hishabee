// To parse this JSON data, do
//
//     final genericResponse = genericResponseFromJson(jsonString);

import 'dart:convert';

GenericResponseModel genericResponseModelFromJson(String str) =>
    GenericResponseModel.fromJson(json.decode(str));

GenericResponseModel genericResponseModelFromRawJson(dynamic json) =>
    GenericResponseModel.fromJson(json);

String genericResponseModelToJson(GenericResponseModel data) =>
    json.encode(data.toJson());

class GenericResponseModel {
  GenericResponseModel({
    this.code,
    this.message,
  });

  int code;
  String message;

  GenericResponseModel copyWith({
    int code,
    String message,
  }) =>
      GenericResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
      );

  factory GenericResponseModel.fromJson(Map<String, dynamic> json) =>
      GenericResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
      };
}
