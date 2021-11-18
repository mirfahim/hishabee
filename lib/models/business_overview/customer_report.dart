// To parse this JSON data, do
//
//     final customerReportModel = customerReportModelFromJson(jsonString);

import 'dart:convert';

List<CustomerReportModel> customerReportModelFromJson(String str) =>
    List<CustomerReportModel>.from(
        json.decode(str).map((x) => CustomerReportModel.fromJson(x)));

class CustomerReportModel {
  CustomerReportModel({
    this.id,
    this.userId,
    this.shopId,
    this.name,
    this.mobile,
    this.email,
    this.address,
    this.imageSrc,
    this.createdAt,
    this.updatedAt,
    this.transactionCount,
    this.transactionAmount,
    this.dueAmount,
  });

  int id;
  int userId;
  int shopId;
  String name;
  String mobile;
  dynamic email;
  String address;
  dynamic imageSrc;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic transactionCount;
  dynamic transactionAmount;
  dynamic dueAmount;

  factory CustomerReportModel.fromJson(Map<String, dynamic> json) =>
      CustomerReportModel(
        id: json["id"],
        userId: json["user_id"],
        shopId: json["shop_id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        address: json["address"],
        imageSrc: json["image_src"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        transactionCount: json["transaction_count"],
        transactionAmount: json["transaction_amount"],
        dueAmount: json["due_amount"],
      );
}
