// To parse this JSON data, do
//
//     final attributeResponseModel = attributeResponseModelFromJson(jsonString);

import 'dart:convert';

List<Attribute> attributeResponseModelFromJson(String str) =>
    List<Attribute>.from(json.decode(str).map((x) => Attribute.fromJson(x)));
List<Attribute> attributeResponseModelFromRawJson(dynamic json) =>
    List<Attribute>.from(
        (json as List<dynamic>).map((x) => Attribute.fromJson(x)));

String attributeResponseModelToJson(List<Attribute> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Attribute {
  Attribute({
    this.id,
    this.productId,
    this.shopProductId,
    this.name,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  dynamic productId;
  int shopProductId;
  String name;
  String value;
  DateTime createdAt;
  DateTime updatedAt;

  Attribute copyWith({
    int id,
    dynamic productId,
    int shopProductId,
    String name,
    String value,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      Attribute(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        shopProductId: shopProductId ?? this.shopProductId,
        name: name ?? this.name,
        value: value ?? this.value,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"] == null ? null : json["id"],
        productId: json["product_id"],
        shopProductId:
            json["shop_product_id"] == null ? null : json["shop_product_id"],
        name: json["name"] == null ? null : json["name"],
        value: json["value"] == null ? null : json["value"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "product_id": productId,
        "shop_product_id": shopProductId == null ? null : shopProductId,
        "name": name == null ? null : name,
        "value": value == null ? null : value,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
