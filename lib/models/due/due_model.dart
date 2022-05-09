// To parse this JSON data, do
//
//     final getAllDueResponse = getAllDueResponseFromJson(jsonString);

import 'dart:convert';

GetAllDueResponse getAllDueResponseFromJson(String str) => GetAllDueResponse.fromJson(json.decode(str));

List<Due> getAllDueResponseModelFromJson(dynamic json) =>
    List<Due>.from(json.map((x) => Due.fromJson(x)));

String getAllDueResponseToJson(GetAllDueResponse data) => json.encode(data.toJson());

class GetAllDueResponse {
  GetAllDueResponse({
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
  List<Due> data;
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

  factory GetAllDueResponse.fromJson(Map<String, dynamic> json) => GetAllDueResponse(
    currentPage: json["current_page"],
    data: List<Due>.from(json["data"].map((x) => Due.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Due {
  Due({
    this.id,
    this.userId,
    this.shopId,
    this.dueAmount,
    this.createdAt,
    this.updatedAt,
    this.dueAlert,
    this.contactMobile,
    this.contactName,
    this.contactType,
    this.version,
    this.uniqueId,
  });

  int id;
  int userId;
  int shopId;
  var dueAmount;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic dueAlert;
  String contactMobile;
  String contactName;
  String contactType;
  int version;
  String uniqueId;

  factory Due.fromJson(Map<String, dynamic> json) => Due(
    id: json["id"],
    userId: json["user_id"],
    shopId: json["shop_id"],
    dueAmount: json["due_amount"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    dueAlert: json["due_alert"],
    contactMobile: json["contact_mobile"],
    contactName: json["contact_name"],
    contactType: json["contact_type"],
    version: json["version"],
    uniqueId: json["unique_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "shop_id": shopId,
    "due_amount": dueAmount,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "due_alert": dueAlert,
    "contact_mobile": contactMobile,
    "contact_name": contactName,
    "contact_type": contactType,
    "version": version,
    "unique_id": uniqueId,
  };
}

enum ContactType { CUSTOMER, EMPLOYEE, SUPPLIER }

final contactTypeValues = EnumValues({
  "CUSTOMER": ContactType.CUSTOMER,
  "EMPLOYEE": ContactType.EMPLOYEE,
  "SUPPLIER": ContactType.SUPPLIER
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