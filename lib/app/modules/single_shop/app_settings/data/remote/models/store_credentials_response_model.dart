// To parse this JSON data, do
//
//     final storeCredentialsResponseModel = storeCredentialsResponseModelFromJson(jsonString);

import 'dart:convert';

StoreCredentialsResponseModel storeCredentialsResponseModelFromJson(
        String str) =>
    StoreCredentialsResponseModel.fromJson(json.decode(str));
StoreCredentialsResponseModel storeCredentialsResponseModelFromRawJson(
        dynamic json) =>
    StoreCredentialsResponseModel.fromJson(json);

String storeCredentialsResponseModelToJson(
        StoreCredentialsResponseModel data) =>
    json.encode(data.toJson());

class StoreCredentialsResponseModel {
  StoreCredentialsResponseModel({
    this.code,
    this.message,
    this.storeId,
    this.storePassword,
  });

  int code;
  String message;
  String storeId;
  String storePassword;

  StoreCredentialsResponseModel copyWith({
    int code,
    String message,
    String storeId,
    String storePassword,
  }) =>
      StoreCredentialsResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        storeId: storeId ?? this.storeId,
        storePassword: storePassword ?? this.storePassword,
      );

  factory StoreCredentialsResponseModel.fromJson(Map<String, dynamic> json) =>
      StoreCredentialsResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        storePassword:
            json["store_password"] == null ? null : json["store_password"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "store_id": storeId == null ? null : storeId,
        "store_password": storePassword == null ? null : storePassword,
      };
}
