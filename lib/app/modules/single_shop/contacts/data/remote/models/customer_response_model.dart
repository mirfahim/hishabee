// To parse this JSON data, do
//
//     final customerResponseModel = customerResponseModelFromJson(jsonString);

import 'dart:convert';

import 'customer_model.dart';

CustomerResponseModel customerResponseModelFromJson(String str) =>
    CustomerResponseModel.fromJson(json.decode(str));

String customerResponseModelToJson(CustomerResponseModel data) =>
    json.encode(data.toJson());

class CustomerResponseModel {
  CustomerResponseModel({
    this.code,
    this.message,
    this.customer,
  });

  int code;
  String message;
  Customer customer;

  CustomerResponseModel copyWith({
    int code,
    String message,
    Customer customer,
  }) =>
      CustomerResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        customer: customer ?? this.customer,
      );

  factory CustomerResponseModel.fromJson(Map<String, dynamic> json) =>
      CustomerResponseModel(
        code: json["code"],
        message: json["message"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "customer": customer.toJson(),
      };
}
