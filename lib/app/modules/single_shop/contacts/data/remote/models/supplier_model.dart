// To parse this JSON data, do
//
//     final supplier = supplierFromJson(jsonString);

import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_model.dart';

import 'contact_model.dart';

List<Supplier> getSuplierContactFromModel(dynamic str) =>
    List<Supplier>.from(str.map((x) => Supplier.fromJson(x)));

List<Supplier> supplierFromJson(String str) =>
    List<Supplier>.from(json.decode(str).map((x) => Supplier.fromJson(x)));

String supplierToJson(List<Supplier> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Supplier extends Contact {
  Supplier({
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
    this.suppliedItems,
  }) : super(id, userId, shopId, name, mobile, email, address, imageSrc,
            createdAt, createdAt);

  final String suppliedItems;
  Supplier copyWith({
    int id,
    int userId,
    int shopId,
    String name,
    String mobile,
    dynamic email,
    String address,
    String suppliedItems,
    String imageSrc,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      Supplier(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        shopId: shopId ?? this.shopId,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        email: email ?? this.email,
        address: address ?? this.address,
        suppliedItems: suppliedItems ?? this.suppliedItems,
        imageSrc: imageSrc ?? this.imageSrc,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
        id: json["id"],
        userId: json["user_id"],
        shopId: json["shop_id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        address: json["address"],
        suppliedItems:
            json["supplied_items"] == null ? null : json["supplied_items"],
        imageSrc: json["image_src"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "shop_id": shopId,
        "name": name,
        "mobile": mobile,
        "email": email,
        "address": address,
        "supplied_items": suppliedItems == null ? null : suppliedItems,
        "image_src": imageSrc,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
