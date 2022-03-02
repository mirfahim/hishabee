// To parse this JSON data, do
//
//     final dueHistory = dueHistoryFromJson(jsonString);

import 'dart:convert';

DueHistoryModel dueHistoryFromJson(String str) => DueHistoryModel.fromJson(json.decode(str));
DueHistoryModel dueHistoryFromJsonDynamic(dynamic str) => DueHistoryModel.fromJson(str);
String dueHistoryToJson(DueHistoryModel data) => json.encode(data.toJson());

class DueHistoryModel {
  DueHistoryModel({
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

  factory DueHistoryModel.fromJson(Map<String, dynamic> json) => DueHistoryModel(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
    from: json["from"] == null ? null : json["from"],
    lastPage: json["last_page"] == null ? null : json["last_page"],
    lastPageUrl: json["last_page_url"] == null ? null : json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"] == null ? null : json["path"],
    perPage: json["per_page"] == null ? null : json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"] == null ? null : json["to"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage == null ? null : currentPage,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
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
  dynamic contactMobile;
  dynamic due;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    image: json["image"] == null ? null : json["image"],
    transactionType: json["transaction_type"] == null ? null : json["transaction_type"],
    note: json["note"],
    dueLeft: json["due_left"] == null ? null : json["due_left"],
    amount: json["amount"] == null ? null : json["amount"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    shopId: json["shop_id"] == null ? null : json["shop_id"],
    version: json["version"] == null ? null : json["version"],
    transactionUniqueId: json["transaction_unique_id"] == null ? null : json["transaction_unique_id"],
    dueUniqueId: json["due_unique_id"] == null ? null : json["due_unique_id"],
    type: json["type"],
    paymentStatus: json["payment_status"],
    uniqueId: json["unique_id"] == null ? null : json["unique_id"],
    purchaseUniqueId: json["purchase_unique_id"],
    contactType: json["contact_type"] == null ? null : json["contact_type"],
    contactName: json["contact_name"] == null ? null : json["contact_name"],
    contactMobile: json["contact_mobile"],
    due: json["due"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "image": image == null ? null : image,
    "transaction_type": transactionType == null ? null : transactionType,
    "note": note,
    "due_left": dueLeft == null ? null : dueLeft,
    "amount": amount == null ? null : amount,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "shop_id": shopId == null ? null : shopId,
    "version": version == null ? null : version,
    "transaction_unique_id": transactionUniqueId == null ? null : transactionUniqueId,
    "due_unique_id": dueUniqueId == null ? null : dueUniqueId,
    "type": type,
    "payment_status": paymentStatus,
    "unique_id": uniqueId == null ? null : uniqueId,
    "purchase_unique_id": purchaseUniqueId,
    "contact_type": contactType == null ? null : contactType,
    "contact_name": contactName == null ? null : contactName,
    "contact_mobile": contactMobile,
    "due": due,
  };
}
