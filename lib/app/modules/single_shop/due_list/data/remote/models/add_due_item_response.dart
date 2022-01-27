
// To parse this JSON data, do
//
//     final addDueItemResponse = addDueItemResponseFromJson(jsonString);

import 'dart:convert';

AddDueItemResponse addDueItemResponseFromJson(String str) => AddDueItemResponse.fromJson(json.decode(str));
AddDueItemResponse addDueItemResponseFromRawJson(dynamic json) {
  print('$json');
  return AddDueItemResponse.fromJson(json);
}

String addDueItemResponseToJson(AddDueItemResponse data) => json.encode(data.toJson());

class AddDueItemResponse {
  AddDueItemResponse({
    this.code,
    this.message,
    this.dueItem,
  });

  int code;
  String message;
  DueItem dueItem;

  AddDueItemResponse copyWith({
    int code,
    String message,
    DueItem dueItem,
  }) =>
      AddDueItemResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        dueItem: dueItem ?? this.dueItem,
      );

  factory AddDueItemResponse.fromJson(Map<String, dynamic> json) => AddDueItemResponse(
    code: json["code"],
    message: json["message"],
    dueItem: DueItem.fromJson(json["due_item"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "due_item": dueItem.toJson(),
  };
}

class DueItem {
  DueItem({
    this.id,
    this.image,
    this.transactionType,
    this.note,
    this.dueLeft,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.shopId,
    this.version,
    this.transactionUniqueId,
    this.dueUniqueId,
    this.type,
    this.uniqueId,
  });

  int id;
  dynamic image;
  dynamic transactionType;
  dynamic note;
  int dueLeft;
  int amount;
  DateTime createdAt;
  DateTime updatedAt;
  int shopId;
  int version;
  dynamic transactionUniqueId;
  String dueUniqueId;
  dynamic type;
  String uniqueId;

  DueItem copyWith({
    int id,
    dynamic image,
    dynamic transactionType,
    dynamic note,
    int dueLeft,
    int amount,
    DateTime createdAt,
    DateTime updatedAt,
    int shopId,
    int version,
    dynamic transactionUniqueId,
    String dueUniqueId,
    dynamic type,
    String uniqueId,
  }) =>
      DueItem(
        id: id ?? this.id,
        image: image ?? this.image,
        transactionType: transactionType ?? this.transactionType,
        note: note ?? this.note,
        dueLeft: dueLeft ?? this.dueLeft,
        amount: amount ?? this.amount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        shopId: shopId ?? this.shopId,
        version: version ?? this.version,
        transactionUniqueId: transactionUniqueId ?? this.transactionUniqueId,
        dueUniqueId: dueUniqueId ?? this.dueUniqueId,
        type: type ?? this.type,
        uniqueId: uniqueId ?? this.uniqueId,
      );

  factory DueItem.fromJson(Map<String, dynamic> json) => DueItem(
    id: json["id"],
    image: json["image"],
    transactionType: json["transaction_type"],
    note: json["note"],
    dueLeft: json["due_left"],
    amount: json["amount"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    shopId: json["shop_id"],
    version: json["version"],
    transactionUniqueId: json["transaction_unique_id"],
    dueUniqueId: json["due_unique_id"],
    type: json["type"],
    uniqueId: json["unique_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "transaction_type": transactionType,
    "note": note,
    "due_left": dueLeft,
    "amount": amount,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "shop_id": shopId,
    "version": version,
    "transaction_unique_id": transactionUniqueId,
    "due_unique_id": dueUniqueId,
    "type": type,
    "unique_id": uniqueId,
  };
}
