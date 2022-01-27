// To parse this JSON data, do
//
//     final getAllDueResponseModel = getAllDueResponseModelFromJson(jsonString);

import 'dart:convert';

GetAllDueResponseModel getAllDueResponseModelFromJson(String str) =>
    GetAllDueResponseModel.fromJson(json.decode(str));
GetAllDueResponseModel getAllDueResponseModelFromRawJson(dynamic json) =>
    GetAllDueResponseModel.fromJson(json);

String getAllDueResponseModelToJson(GetAllDueResponseModel data) =>
    json.encode(data.toJson());

class GetAllDueResponseModel {
  GetAllDueResponseModel({
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

  GetAllDueResponseModel copyWith({
    int currentPage,
    List<Due> data,
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
      GetAllDueResponseModel(
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

  factory GetAllDueResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllDueResponseModel(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<Due>.from(json["data"].map((x) => Due.fromJson(x))),
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
  double dueAmount;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic dueAlert;
  String contactMobile;
  String contactName;
  String contactType;
  int version;
  String uniqueId;

  Due copyWith({
    int id,
    int userId,
    int shopId,
    double dueAmount,
    DateTime createdAt,
    DateTime updatedAt,
    dynamic dueAlert,
    String contactMobile,
    String contactName,
    String contactType,
    int version,
    String uniqueId,
  }) =>
      Due(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        shopId: shopId ?? this.shopId,
        dueAmount: dueAmount ?? this.dueAmount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        dueAlert: dueAlert ?? this.dueAlert,
        contactMobile: contactMobile ?? this.contactMobile,
        contactName: contactName ?? this.contactName,
        contactType: contactType ?? this.contactType,
        version: version ?? this.version,
        uniqueId: uniqueId ?? this.uniqueId,
      );

  factory Due.fromJson(Map<String, dynamic> json) => Due(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    shopId: json["shop_id"] == null ? null : json["shop_id"],
    dueAmount:
    json["due_amount"] == null ? null : json["due_amount"].toDouble(),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    dueAlert: json["due_alert"],
    contactMobile:
    json["contact_mobile"] == null ? null : json["contact_mobile"],
    contactName: json["contact_name"] == null ? null : json["contact_name"],
    contactType: json["contact_type"] == null ? null : json["contact_type"],
    version: json["version"] == null ? null : json["version"],
    uniqueId: json["unique_id"] == null ? null : json["unique_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "shop_id": shopId == null ? null : shopId,
    "due_amount": dueAmount == null ? null : dueAmount,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "due_alert": dueAlert,
    "contact_mobile": contactMobile == null ? null : contactMobile,
    "contact_name": contactName == null ? null : contactName,
    "contact_type": contactType == null ? null : contactType,
    "version": version == null ? null : version,
    "unique_id": uniqueId == null ? null : uniqueId,
  };

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
