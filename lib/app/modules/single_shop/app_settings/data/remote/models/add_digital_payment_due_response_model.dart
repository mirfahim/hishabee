// To parse this JSON data, do
//
//     final updateDigitalPaymentDueResponseModel = updateDigitalPaymentDueResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';

UpdateDigitalPaymentDueResponseModel
    updateDigitalPaymentDueResponseModelFromJson(String str) =>
        UpdateDigitalPaymentDueResponseModel.fromJson(json.decode(str));
UpdateDigitalPaymentDueResponseModel
    updateDigitalPaymentDueResponseModelFromRawJson(dynamic json) =>
        UpdateDigitalPaymentDueResponseModel.fromJson(json);

String updateDigitalPaymentDueResponseModelToJson(
        UpdateDigitalPaymentDueResponseModel data) =>
    json.encode(data.toJson());

class UpdateDigitalPaymentDueResponseModel {
  UpdateDigitalPaymentDueResponseModel({
    this.code,
    this.message,
    this.due,
    this.url,
  });

  int code;
  String message;
  Due due;
  String url;

  UpdateDigitalPaymentDueResponseModel copyWith({
    int code,
    String message,
    Due due,
    String url,
  }) =>
      UpdateDigitalPaymentDueResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        due: due ?? this.due,
        url: url ?? this.url,
      );

  factory UpdateDigitalPaymentDueResponseModel.fromJson(
          Map<String, dynamic> json) =>
      UpdateDigitalPaymentDueResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        due: json["due"] == null ? null : Due.fromJson(json["due"]),
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "due": due == null ? null : due.toJson(),
        "url": url == null ? null : url,
      };
}
