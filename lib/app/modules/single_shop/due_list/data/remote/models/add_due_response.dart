

// To parse this JSON data, do
//
//     final addDueResponse = addDueResponseFromJson(jsonString);

import 'dart:convert';

import 'add_due_response_model.dart';
import 'get_all_due_response_model.dart';

AddDueResponse addDueResponseFromJson(String str) => AddDueResponse.fromJson(json.decode(str));

AddDueResponse addDueResponseFromRawJson(dynamic json) => AddDueResponse.fromJson(json);

String addDueResponseToJson(AddDueResponse data) => json.encode(data.toJson());

class AddDueResponse {
  AddDueResponse({
    this.code,
    this.message,
    this.due,
  });

  int code;
  String message;
  Due due;

  AddDueResponse copyWith({
    int code,
    String message,
    Due due,
  }) =>
      AddDueResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        due: due ?? this.due,
      );

  factory AddDueResponse.fromJson(Map<String, dynamic> json) => AddDueResponse(
    code: json["code"],
    message: json["message"],
    due: Due.fromJson(json["due"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "due": due.toJson(),
  };
}

/*class Due {
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
  int dueAmount;
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
    int dueAmount,
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
}*/
