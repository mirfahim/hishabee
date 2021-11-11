// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

import 'contact_model.dart';

List<Customer> customerFromJson(String str) =>
    List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));
List<Customer> customerFromRawJson(dynamic json) => List<Customer>.from(
    (json as List<dynamic>).map((x) => Customer.fromJson(x)));

String customerToJson(List<Customer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Customer extends Contact {
  Customer({
    int id,
    int userId,
    int shopId,
    String name,
    String mobile,
    String email,
    String address,
    String imageSrc,
    DateTime createdAt,
    DateTime updatedAt,
  }) : super(id, userId, shopId, name, mobile, email, address, imageSrc,
            createdAt, createdAt);

  Customer copyWith({
    int id,
    int userId,
    int shopId,
    String name,
    String mobile,
    String email,
    String address,
    String imageSrc,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      Customer(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        shopId: shopId ?? this.shopId,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        email: email ?? this.email,
        address: address ?? this.address,
        imageSrc: imageSrc ?? this.imageSrc,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        shopId: json["shop_id"] == null ? null : json["shop_id"],
        name: json["name"] == null ? null : json["name"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        email: json["email"] == null ? null : json["email"],
        address: json["address"] == null ? null : json["address"],
        imageSrc: json["image_src"] == null ? null : json["image_src"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "shop_id": shopId == null ? null : shopId,
        "name": name == null ? null : name,
        "mobile": mobile == null ? null : mobile,
        "email": email == null ? null : email,
        "address": address == null ? null : address,
        "image_src": imageSrc == null ? null : imageSrc,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
