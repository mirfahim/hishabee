// To parse this JSON data, do
//
//     final getAllDueItemByUid = getAllDueItemByUidFromJson(jsonString);

import 'dart:convert';

List<GetAllDueItemByUid> getAllDueItemByUidFromJson(String str) => List<GetAllDueItemByUid>.from(json.decode(str).map((x) => GetAllDueItemByUid.fromJson(x)));
List<GetAllDueItemByUid> getAllDueItemByUidFromRawJson(dynamic json) =>
    List<GetAllDueItemByUid>.from((json as List<dynamic>).map((x) => GetAllDueItemByUid.fromJson(x)));

String getAllDueItemByUidToJson(List<GetAllDueItemByUid> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllDueItemByUid {
  GetAllDueItemByUid({
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
  DueUniqueId dueUniqueId;
  dynamic type;
  String uniqueId;

  GetAllDueItemByUid copyWith({
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
    DueUniqueId dueUniqueId,
    dynamic type,
    String uniqueId,
  }) =>
      GetAllDueItemByUid(
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

  factory GetAllDueItemByUid.fromJson(Map<String, dynamic> json) => GetAllDueItemByUid(
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
    dueUniqueId: dueUniqueIdValues.map[json["due_unique_id"]],
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
    "due_unique_id": dueUniqueIdValues.reverse[dueUniqueId],
    "type": type,
    "unique_id": uniqueId,
  };
}

enum DueUniqueId { ABC }

final dueUniqueIdValues = EnumValues({
  "abc": DueUniqueId.ABC
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
