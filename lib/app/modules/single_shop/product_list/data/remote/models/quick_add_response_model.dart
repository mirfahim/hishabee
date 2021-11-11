// To parse this JSON data, do
//
//     final quickAddResponseModel = quickAddResponseModelFromJson(jsonString);

import 'dart:convert';

QuickAddResponseModel quickAddResponseModelFromJson(String str) =>
    QuickAddResponseModel.fromJson(json.decode(str));
QuickAddResponseModel quickAddResponseModelFromRawJson(dynamic json) =>
    QuickAddResponseModel.fromJson(json);

String quickAddResponseModelToJson(QuickAddResponseModel data) =>
    json.encode(data.toJson());

class QuickAddResponseModel {
  QuickAddResponseModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  QuickAddResponseModel copyWith({
    int currentPage,
    List<Datum> data,
    String firstPageUrl,
    int from,
    int lastPage,
    String lastPageUrl,
    dynamic nextPageUrl,
    String path,
    int perPage,
    dynamic prevPageUrl,
    int to,
    int total,
  }) =>
      QuickAddResponseModel(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory QuickAddResponseModel.fromJson(Map<String, dynamic> json) =>
      QuickAddResponseModel(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.subCategory,
    this.sellingPrice,
    this.costPrice,
    this.stock,
    this.description,
    this.vatApplicable,
    this.barcode,
    this.imageUrl,
    this.productType,
    this.createdAt,
    this.updatedAt,
    this.vatPercent,
  });

  int id;
  String name;
  int subCategory;
  int sellingPrice;
  int costPrice;
  int stock;
  String description;
  int vatApplicable;
  dynamic barcode;
  String imageUrl;
  String productType;
  DateTime createdAt;
  DateTime updatedAt;
  int vatPercent;

  Datum copyWith({
    int id,
    String name,
    int subCategory,
    int sellingPrice,
    int costPrice,
    int stock,
    String description,
    int vatApplicable,
    dynamic barcode,
    String imageUrl,
    String productType,
    DateTime createdAt,
    DateTime updatedAt,
    int vatPercent,
  }) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
        subCategory: subCategory ?? this.subCategory,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        costPrice: costPrice ?? this.costPrice,
        stock: stock ?? this.stock,
        description: description ?? this.description,
        vatApplicable: vatApplicable ?? this.vatApplicable,
        barcode: barcode ?? this.barcode,
        imageUrl: imageUrl ?? this.imageUrl,
        productType: productType ?? this.productType,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        vatPercent: vatPercent ?? this.vatPercent,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        subCategory: json["sub_category"] == null ? null : json["sub_category"],
        sellingPrice:
            json["selling_price"] == null ? null : json["selling_price"],
        costPrice: json["cost_price"] == null ? null : json["cost_price"],
        stock: json["stock"] == null ? null : json["stock"],
        description: json["description"] == null ? null : json["description"],
        vatApplicable:
            json["vat_applicable"] == null ? null : json["vat_applicable"],
        barcode: json["barcode"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        productType: json["product_type"] == null ? null : json["product_type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        vatPercent: json["vat_percent"] == null ? null : json["vat_percent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "sub_category": subCategory == null ? null : subCategory,
        "selling_price": sellingPrice == null ? null : sellingPrice,
        "cost_price": costPrice == null ? null : costPrice,
        "stock": stock == null ? null : stock,
        "description": description == null ? null : description,
        "vat_applicable": vatApplicable == null ? null : vatApplicable,
        "barcode": barcode,
        "image_url": imageUrl == null ? null : imageUrl,
        "product_type": productType == null ? null : productType,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "vat_percent": vatPercent == null ? null : vatPercent,
      };
}
