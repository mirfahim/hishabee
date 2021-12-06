// To parse this JSON data, do
//
//     final expenseResponseModel = expenseResponseModelFromJson(jsonString);

import 'dart:convert';

List<ExpenseResponseModel> getExpenseFromModel(dynamic str) =>
    List<ExpenseResponseModel>.from(str.map((x) => ExpenseResponseModel.fromJson(x)));

List<ExpenseResponseModel> expenseResponseModelFromJson(String str) =>
    List<ExpenseResponseModel>.from(json.decode(str).map((x) => ExpenseResponseModel.fromJson(x)));

String expenseResponseModelToJson(List<ExpenseResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseResponseModel {
  ExpenseResponseModel({
    this.id,
    this.userId,
    this.shopId,
    this.type,
    this.purpose,
    this.details,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.contactMobile,
    this.contactName,
    this.contactType,
  });

  int id;
  int userId;
  int shopId;
  String type;
  String purpose;
  String details;
  int amount;
  DateTime createdAt;
  DateTime updatedAt;
  String image;
  String contactMobile;
  String contactName;
  String contactType;

  factory ExpenseResponseModel.fromJson(Map<String, dynamic> json) => ExpenseResponseModel(
    id: json["id"],
    userId: json["user_id"],
    shopId: json["shop_id"],
    type: json["type"],
    purpose: json["purpose"] == null ? null : json["purpose"],
    details: json["details"] == null ? null : json["details"],
    amount: json["amount"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    image: json["image"] == null ? null : json["image"],
    contactMobile: json["contact_mobile"] == null ? null : json["contact_mobile"],
    contactName: json["contact_name"] == null ? null : json["contact_name"],
    contactType: json["contact_type"] == null ? null : json["contact_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "shop_id": shopId,
    "type": type,
    "purpose": purpose == null ? null : purpose,
    "details": details == null ? null : details,
    "amount": amount,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "image": image == null ? null : image,
    "contact_mobile": contactMobile == null ? null : contactMobile,
    "contact_name": contactName == null ? null : contactName,
    "contact_type": contactType == null ? null : contactType,
  };
}
