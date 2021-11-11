// To parse this JSON data, do
//
//     final categoryResponseModel = categoryResponseModelFromJson(jsonString);

import 'dart:convert';

List<Category> categoryResponseModelFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

List<Category> categoryResponseModelFromRawJson(dynamic json) =>
    List<Category>.from(
        (json as List<dynamic>).map((x) => Category.fromJson(x)));

String categoryResponseModelToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.id,
    this.name,
    this.bnName,
    this.shopTypes,
    this.createdAt,
    this.updatedAt,
    this.commisionRate,
    this.banner,
    this.icon,
    this.featured,
    this.top,
    this.digital,
    this.slug,
    this.metaTitle,
    this.metaDescription,
    this.subCategory,
  });

  int id;
  String name;
  String bnName;
  String shopTypes;
  dynamic createdAt;
  dynamic updatedAt;
  int commisionRate;
  String banner;
  String icon;
  int featured;
  int top;
  int digital;
  String slug;
  String metaTitle;
  String metaDescription;
  List<SubCategory> subCategory;

  Category copyWith({
    int id,
    String name,
    String bnName,
    String shopTypes,
    dynamic createdAt,
    dynamic updatedAt,
    int commisionRate,
    String banner,
    String icon,
    int featured,
    int top,
    int digital,
    String slug,
    String metaTitle,
    String metaDescription,
    List<SubCategory> subCategory,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        bnName: bnName ?? this.bnName,
        shopTypes: shopTypes ?? this.shopTypes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        commisionRate: commisionRate ?? this.commisionRate,
        banner: banner ?? this.banner,
        icon: icon ?? this.icon,
        featured: featured ?? this.featured,
        top: top ?? this.top,
        digital: digital ?? this.digital,
        slug: slug ?? this.slug,
        metaTitle: metaTitle ?? this.metaTitle,
        metaDescription: metaDescription ?? this.metaDescription,
        subCategory: subCategory ?? this.subCategory,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        bnName: json["bn_name"] == null ? null : json["bn_name"],
        shopTypes: json["shop_types"] == null ? null : json["shop_types"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        commisionRate:
            json["commision_rate"] == null ? null : json["commision_rate"],
        banner: json["banner"] == null ? null : json["banner"],
        icon: json["icon"] == null ? null : json["icon"],
        featured: json["featured"] == null ? null : json["featured"],
        top: json["top"] == null ? null : json["top"],
        digital: json["digital"] == null ? null : json["digital"],
        slug: json["slug"] == null ? null : json["slug"],
        metaTitle: json["meta_title"] == null ? null : json["meta_title"],
        metaDescription:
            json["meta_description"] == null ? null : json["meta_description"],
        subCategory: json["sub_category"] == null
            ? null
            : List<SubCategory>.from(
                json["sub_category"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "bn_name": bnName == null ? null : bnName,
        "shop_types": shopTypes == null ? null : shopTypes,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "commision_rate": commisionRate == null ? null : commisionRate,
        "banner": banner == null ? null : banner,
        "icon": icon == null ? null : icon,
        "featured": featured == null ? null : featured,
        "top": top == null ? null : top,
        "digital": digital == null ? null : digital,
        "slug": slug == null ? null : slug,
        "meta_title": metaTitle == null ? null : metaTitle,
        "meta_description": metaDescription == null ? null : metaDescription,
        "sub_category": subCategory == null
            ? null
            : List<dynamic>.from(subCategory.map((x) => x.toJson())),
      };
}

class SubCategory {
  SubCategory({
    this.id,
    this.name,
    this.bnName,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.icon,
    this.userId,
  });

  int id;
  String name;
  String bnName;
  int categoryId;
  dynamic createdAt;
  DateTime updatedAt;
  String slug;
  String icon;
  int userId;

  SubCategory copyWith({
    int id,
    String name,
    String bnName,
    int categoryId,
    dynamic createdAt,
    DateTime updatedAt,
    String slug,
    String icon,
    int userId,
  }) =>
      SubCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        bnName: bnName ?? this.bnName,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        slug: slug ?? this.slug,
        icon: icon ?? this.icon,
        userId: userId ?? this.userId,
      );

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        bnName: json["bn_name"] == null ? null : json["bn_name"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        slug: json["slug"] == null ? null : json["slug"],
        icon: json["icon"] == null ? null : json["icon"],
        userId: json["user_id"] == null ? null : json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "bn_name": bnName == null ? null : bnName,
        "category_id": categoryId == null ? null : categoryId,
        "created_at": createdAt,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "slug": slug == null ? null : slug,
        "icon": icon == null ? null : icon,
        "user_id": userId == null ? null : userId,
      };
}
