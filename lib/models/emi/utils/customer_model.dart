// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

List<CustomerModel> customerModelFromJson(dynamic str) =>
    List<CustomerModel>.from(str.map((x) => CustomerModel.fromJson(x)));

class CustomerModel {
  CustomerModel({
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

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
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
      );
}
