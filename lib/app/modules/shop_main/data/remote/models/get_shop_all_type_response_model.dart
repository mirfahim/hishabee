// To parse this JSON data, do
//
//     final shopType = shopTypeFromJson(jsonString);

import 'dart:convert';

List<ShopType> shopTypeFromJson(String str) =>
    List<ShopType>.from(json.decode(str).map((x) => ShopType.fromJson(x)));
List<ShopType> shopTypeFromRawJson(dynamic json) => List<ShopType>.from(
    (json as List<dynamic>).map((x) => ShopType.fromJson(x)));

String shopTypeToJson(List<ShopType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShopType {
  ShopType({
    this.id,
    this.name,
    this.bnName,
    this.icon,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String bnName;
  String icon;
  dynamic createdAt;
  dynamic updatedAt;

  ShopType copyWith({
    int id,
    String name,
    String bnName,
    String icon,
    dynamic createdAt,
    dynamic updatedAt,
  }) =>
      ShopType(
        id: id ?? this.id,
        name: name ?? this.name,
        bnName: bnName ?? this.bnName,
        icon: icon ?? this.icon,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ShopType.fromJson(Map<String, dynamic> json) => ShopType(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        bnName: json["bn_name"] == null ? null : json["bn_name"],
        icon: json["icon"] == null ? null : json["icon"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "bn_name": bnName == null ? null : bnName,
        "icon": icon == null ? null : icon,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
