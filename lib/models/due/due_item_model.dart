// To parse this JSON data, do
//
//     final getDueItem = getDueItemFromJson(jsonString);

import 'dart:convert';

import 'due_model.dart';

List<GetDueItem> getDueItemFromJson(String str) => List<GetDueItem>.from(json.decode(str).map((x) => GetDueItem.fromJson(x)));

List<GetDueItem> getDueItemResponseModelFromJson(dynamic json) =>
    List<GetDueItem>.from(json.map((x) => GetDueItem.fromJson(x)));

String getDueItemToJson(List<GetDueItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetDueItem {
  GetDueItem({
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
    this.paymentStatus,
    this.uniqueId,
    this.purchaseUniqueId,
    this.contactType,
    this.contactName,
    this.contactMobile,
    this.due,
  });

  int id;
  String image;
  String transactionType;
  dynamic note;
  int dueLeft;
  int amount;
  DateTime createdAt;
  DateTime updatedAt;
  int shopId;
  int version;
  String transactionUniqueId;
  String dueUniqueId;
  dynamic type;
  dynamic paymentStatus;
  String uniqueId;
  dynamic purchaseUniqueId;
  String contactType;
  String contactName;
  String contactMobile;
  Due due;

  factory GetDueItem.fromJson(Map<String, dynamic> json) => GetDueItem(
    id: json["id"],
    image: json["image"] == null ? null : json["image"],
    transactionType: json["transaction_type"] == null ? null : json["transaction_type"],
    note: json["note"],
    dueLeft: json["due_left"],
    amount: json["amount"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    shopId: json["shop_id"],
    version: json["version"],
    transactionUniqueId: json["transaction_unique_id"] == null ? null : json["transaction_unique_id"],
    dueUniqueId: json["due_unique_id"],
    type: json["type"],
    paymentStatus: json["payment_status"],
    uniqueId: json["unique_id"],
    purchaseUniqueId: json["purchase_unique_id"],
    contactType: json["contact_type"],
    contactName: json["contact_name"],
    contactMobile: json["contact_mobile"],
    due: Due.fromJson(json["due"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image == null ? null : image,
    "transaction_type": transactionType == null ? null : transactionType,
    "note": note,
    "due_left": dueLeft,
    "amount": amount,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "shop_id": shopId,
    "version": version,
    "transaction_unique_id": transactionUniqueId == null ? null : transactionUniqueId,
    "due_unique_id": dueUniqueId,
    "type": type,
    "payment_status": paymentStatus,
    "unique_id": uniqueId,
    "purchase_unique_id": purchaseUniqueId,
    "contact_type": contactType,
    "contact_name": contactName,
    "contact_mobile": contactMobile,
    "due": due.toJson(),
  };
}

// class Due {
//   Due({
//     this.id,
//     this.userId,
//     this.shopId,
//     this.dueAmount,
//     this.createdAt,
//     this.updatedAt,
//     this.dueAlert,
//     this.contactMobile,
//     this.contactName,
//     this.contactType,
//     this.version,
//     this.uniqueId,
//   });
//
//   int id;
//   int userId;
//   int shopId;
//   int dueAmount;
//   DateTime createdAt;
//   DateTime updatedAt;
//   dynamic dueAlert;
//   String contactMobile;
//   String contactName;
//   String contactType;
//   int version;
//   String uniqueId;
//
//   factory Due.fromJson(Map<String, dynamic> json) => Due(
//     id: json["id"],
//     userId: json["user_id"],
//     shopId: json["shop_id"],
//     dueAmount: json["due_amount"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     dueAlert: json["due_alert"],
//     contactMobile: json["contact_mobile"],
//     contactName: json["contact_name"],
//     contactType: json["contact_type"],
//     version: json["version"],
//     uniqueId: json["unique_id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "user_id": userId,
//     "shop_id": shopId,
//     "due_amount": dueAmount,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "due_alert": dueAlert,
//     "contact_mobile": contactMobile,
//     "contact_name": contactName,
//     "contact_type": contactType,
//     "version": version,
//     "unique_id": uniqueId,
//   };
// }
