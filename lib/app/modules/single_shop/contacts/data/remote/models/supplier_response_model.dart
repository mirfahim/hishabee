// To parse this JSON data, do
//
//     final supplierResponseModel = supplierResponseModelFromJson(jsonString);

import 'dart:convert';

import 'supplier_model.dart';

SupplierResponseModel supplierResponseModelFromJson(String str) =>
    SupplierResponseModel.fromJson(json.decode(str));

String supplierResponseModelToJson(SupplierResponseModel data) =>
    json.encode(data.toJson());

class SupplierResponseModel {
  SupplierResponseModel({
    this.code,
    this.message,
    this.supplier,
  });

  int code;
  String message;
  Supplier supplier;

  SupplierResponseModel copyWith({
    int code,
    String message,
    Supplier supplier,
  }) =>
      SupplierResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        supplier: supplier ?? this.supplier,
      );

  factory SupplierResponseModel.fromJson(Map<String, dynamic> json) =>
      SupplierResponseModel(
        code: json["code"],
        message: json["message"],
        supplier: Supplier.fromJson(json["supplier"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "supplier": supplier.toJson(),
      };
}
