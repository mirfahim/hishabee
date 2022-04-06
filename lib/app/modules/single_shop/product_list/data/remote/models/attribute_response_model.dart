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
enum DiscountType { PERCENT, AMOUNT, EMPTY, DISCOUNT_TYPE_PERCENT }

final discountTypeValues = EnumValues({
  "AMOUNT": DiscountType.AMOUNT,
  "percent": DiscountType.DISCOUNT_TYPE_PERCENT,
  "%": DiscountType.EMPTY,
  "PERCENT": DiscountType.PERCENT
});

enum LocationId { EMPTY }

final locationIdValues = EnumValues({
  "[]": LocationId.EMPTY
});

enum ProductType { SIMPLE, VARIABLE, PRODUCT_TYPE_SIMPLE }

final productTypeValues = EnumValues({
  "'Simple'": ProductType.PRODUCT_TYPE_SIMPLE,
  "SIMPLE": ProductType.SIMPLE,
  "VARIABLE": ProductType.VARIABLE
});

enum ShippingType { FLAT_RATE }

final shippingTypeValues = EnumValues({
  "flat_rate": ShippingType.FLAT_RATE
});

enum SubUnit { SUB_UNIT_PRICE, SUB_UNIT_2_PRICE_20, SUB_UNIT_PRICE_NULL, SUB_UNIT_10_PRICE_1000, SUB_UNIT_29_PRICE_67, SUB_UNIT_PRICE_50, SUB_UNIT_NULL_PRICE_NULL, EMPTY }

final subUnitValues = EnumValues({
  "": SubUnit.EMPTY,
  "{\"sub_unit\":\"10\",\"price\":\"1000\"}": SubUnit.SUB_UNIT_10_PRICE_1000,
  "{\"sub_unit\":\"29\",\"price\":\"67\"}": SubUnit.SUB_UNIT_29_PRICE_67,
  "[ {\"sub_unit\": 2,\"price\":  20} ]": SubUnit.SUB_UNIT_2_PRICE_20,
  "[{\"sub_unit\":null,\"price\":null}]": SubUnit.SUB_UNIT_NULL_PRICE_NULL,
  "{\"sub_unit\":\"\",\"price\":\"\"}": SubUnit.SUB_UNIT_PRICE,
  "[{\"sub_unit\":\"\",\"price\":\"50\"}]": SubUnit.SUB_UNIT_PRICE_50,
  "[{\"sub_unit\":\"\",\"price\":null}]": SubUnit.SUB_UNIT_PRICE_NULL
});

enum WarrantyType { MONTH, DAY, WARRANTY_TYPE_MONTH, WEEK, YEAR, WARRANTY_TYPE_YEAR, WARRANTY_TYPE_WEEK, EMPTY, WARRANTY_TYPE, PURPLE_YEAR, WARRANTY_TYPE_DAY, PURPLE }

final warrantyTypeValues = EnumValues({
  "DAY": WarrantyType.DAY,
  "বছর": WarrantyType.EMPTY,
  "month": WarrantyType.MONTH,
  "": WarrantyType.PURPLE,
  "Year": WarrantyType.PURPLE_YEAR,
  "সপ্তাহ": WarrantyType.WARRANTY_TYPE,
  "Day": WarrantyType.WARRANTY_TYPE_DAY,
  "MONTH": WarrantyType.WARRANTY_TYPE_MONTH,
  "week": WarrantyType.WARRANTY_TYPE_WEEK,
  "year": WarrantyType.WARRANTY_TYPE_YEAR,
  "WEEK": WarrantyType.WEEK,
  "YEAR": WarrantyType.YEAR
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
