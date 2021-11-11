// To parse this JSON data, do
//
//     final transactionItemResponseModel = transactionItemResponseModelFromJson(jsonString);

import 'dart:convert';

List<TransactionItem> transactionItemResponseModelFromJson(String str) =>
    List<TransactionItem>.from(
        json.decode(str).map((x) => TransactionItem.fromJson(x)));
List<TransactionItem> transactionItemResponseModelFromRawJson(dynamic json) =>
    List<TransactionItem>.from(
        (json as List<dynamic>).map((x) => TransactionItem.fromJson(x)));

String transactionItemResponseModelToJson(List<TransactionItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionItem {
  TransactionItem({
    this.id,
    this.transactionId,
    this.shopProductId,
    this.shopProductVarianceId,
    this.quantity,
    this.price,
    this.discount,
    this.createdAt,
    this.updatedAt,
    this.vat,
    this.status,
    this.localId,
    this.name,
    this.unitPrice,
    this.imageSrc,
    this.subCategory,
    this.sellingPrice,
  });

  int id;
  int transactionId;
  int shopProductId;
  int shopProductVarianceId;
  int quantity;
  num price;
  num discount;
  DateTime createdAt;
  DateTime updatedAt;
  num vat;
  String status;
  int localId;
  String name;
  num unitPrice;
  String imageSrc;
  int subCategory;
  num sellingPrice;

  TransactionItem copyWith({
    int id,
    int transactionId,
    int shopProductId,
    int shopProductVarianceId,
    int quantity,
    double price,
    int discount,
    DateTime createdAt,
    DateTime updatedAt,
    double vat,
    String status,
    int localId,
    String name,
    int unitPrice,
    String imageSrc,
    int subCategory,
    int sellingPrice,
  }) =>
      TransactionItem(
        id: id ?? this.id,
        transactionId: transactionId ?? this.transactionId,
        shopProductId: shopProductId ?? this.shopProductId,
        shopProductVarianceId:
            shopProductVarianceId ?? this.shopProductVarianceId,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        vat: vat ?? this.vat,
        status: status ?? this.status,
        localId: localId ?? this.localId,
        name: name ?? this.name,
        unitPrice: unitPrice ?? this.unitPrice,
        imageSrc: imageSrc ?? this.imageSrc,
        subCategory: subCategory ?? this.subCategory,
        sellingPrice: sellingPrice ?? this.sellingPrice,
      );

  factory TransactionItem.fromJson(Map<String, dynamic> json) =>
      TransactionItem(
        id: json["id"] == null ? null : json["id"],
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        shopProductId:
            json["shop_product_id"] == null ? null : json["shop_product_id"],
        shopProductVarianceId: json["shop_product_variance_id"] == null
            ? null
            : json["shop_product_variance_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        discount: json["discount"] == null ? null : json["discount"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        vat: json["vat"] == null ? null : json["vat"].toDouble(),
        status: json["status"] == null ? null : json["status"],
        localId: json["local_id"] == null ? null : json["local_id"],
        name: json["name"] == null ? null : json["name"],
        unitPrice: json["unit_price"] == null ? null : json["unit_price"],
        imageSrc: json["image_src"] == null ? null : json["image_src"],
        subCategory: json["sub_category"] == null ? null : json["sub_category"],
        sellingPrice:
            json["selling_price"] == null ? null : json["selling_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "transaction_id": transactionId == null ? null : transactionId,
        "shop_product_id": shopProductId == null ? null : shopProductId,
        "shop_product_variance_id":
            shopProductVarianceId == null ? null : shopProductVarianceId,
        "quantity": quantity == null ? null : quantity,
        "price": price == null ? null : price,
        "discount": discount == null ? null : discount,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "vat": vat == null ? null : vat,
        "status": status == null ? null : status,
        "local_id": localId == null ? null : localId,
        "name": name == null ? null : name,
        "unit_price": unitPrice == null ? null : unitPrice,
        "image_src": imageSrc == null ? null : imageSrc,
        "sub_category": subCategory == null ? null : subCategory,
        "selling_price": sellingPrice == null ? null : sellingPrice,
      };
}
