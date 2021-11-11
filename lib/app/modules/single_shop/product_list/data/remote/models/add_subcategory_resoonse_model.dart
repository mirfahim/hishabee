// To parse this JSON data, do
//
//     final addSubCaregoryResponse = addSubCaregoryResponseFromJson(jsonString);

import 'dart:convert';

AddSubCategoryResponse addSubCategoryResponseFromJson(String str) =>
    AddSubCategoryResponse.fromJson(json.decode(str));

AddSubCategoryResponse addSubCategoryResponseFromRawJson(dynamic json) =>
    AddSubCategoryResponse.fromJson(json);

String addSubCategoryResponseToJson(AddSubCategoryResponse data) =>
    json.encode(data.toJson());

class AddSubCategoryResponse {
  AddSubCategoryResponse({
    this.code,
    this.message,
    this.subCategory,
  });

  int code;
  String message;
  SubCategory subCategory;

  AddSubCategoryResponse copyWith({
    int code,
    String message,
    SubCategory subCategory,
  }) =>
      AddSubCategoryResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        subCategory: subCategory ?? this.subCategory,
      );

  factory AddSubCategoryResponse.fromJson(Map<String, dynamic> json) =>
      AddSubCategoryResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        subCategory: json["sub_category"] == null
            ? null
            : SubCategory.fromJson(json["sub_category"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "sub_category": subCategory == null ? null : subCategory.toJson(),
      };
}

class SubCategory {
  SubCategory({
    this.userId,
    this.name,
    this.bnName,
    this.categoryId,
    this.icon,
    this.slug,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  int userId;
  String name;
  String bnName;
  String categoryId;
  String icon;
  String slug;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  SubCategory copyWith({
    int userId,
    String name,
    String bnName,
    String categoryId,
    String icon,
    String slug,
    DateTime updatedAt,
    DateTime createdAt,
    int id,
  }) =>
      SubCategory(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        bnName: bnName ?? this.bnName,
        categoryId: categoryId ?? this.categoryId,
        icon: icon ?? this.icon,
        slug: slug ?? this.slug,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        userId: json["user_id"] == null ? null : json["user_id"],
        name: json["name"] == null ? null : json["name"],
        bnName: json["bn_name"] == null ? null : json["bn_name"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        icon: json["icon"] == null ? null : json["icon"],
        slug: json["slug"] == null ? null : json["slug"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "name": name == null ? null : name,
        "bn_name": bnName == null ? null : bnName,
        "category_id": categoryId == null ? null : categoryId,
        "icon": icon == null ? null : icon,
        "slug": slug == null ? null : slug,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "id": id == null ? null : id,
      };
}
