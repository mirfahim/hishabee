// To parse this JSON data, do
//
//     final getAllDueResponseModel = getAllDueResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';

GetAllDueResponseModel getAllDueResponseModelFromJson(String str) =>
    GetAllDueResponseModel.fromJson(json.decode(str));
GetAllDueResponseModel getAllDueResponseModelFromRawJson(dynamic json) =>
    GetAllDueResponseModel.fromJson(json);

String getAllDueResponseModelToJson(GetAllDueResponseModel data) =>
    json.encode(data.toJson());

class GetAllDueResponseModel {
  GetAllDueResponseModel({
    this.code,
    this.message,
    this.due,
    this.dueItems,
  });

  int code;
  String message;
  List<Due> due;
  List<DueItem> dueItems;

  GetAllDueResponseModel copyWith({
    int code,
    String message,
    List<Due> due,
    List<DueItem> dueItems,
  }) =>
      GetAllDueResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        due: due ?? this.due,
        dueItems: dueItems ?? this.dueItems,
      );

  factory GetAllDueResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllDueResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        due: json["due"] == null
            ? null
            : List<Due>.from(json["due"].map((x) => Due.fromJson(x))),
        dueItems: json["due_items"] == null
            ? null
            : List<DueItem>.from(
                json["due_items"].map((x) => DueItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "due":
            due == null ? null : List<dynamic>.from(due.map((x) => x.toJson())),
        "due_items": dueItems == null
            ? null
            : List<dynamic>.from(dueItems.map((x) => x.toJson())),
      };
}

class Due {
  Due({
    this.id,
    this.userId,
    this.shopId,
    this.customerId,
    this.dueAmount,
    this.createdAt,
    this.updatedAt,
    this.customerAddress,
    this.customerMobile,
    this.customerName,
    this.lastUpdate,
    this.customer,
    this.dueListItems,
  });

  int id;
  int userId;
  int shopId;
  int customerId;
  int dueAmount;
  DateTime createdAt;
  DateTime updatedAt;
  String customerAddress;
  String customerMobile;
  String customerName;
  DateTime lastUpdate;
  Customer customer;
  List<DueItem> dueListItems;

  Due copyWith({
    int id,
    int userId,
    int shopId,
    int customerId,
    int dueAmount,
    DateTime createdAt,
    DateTime updatedAt,
    String customerAddress,
    String customerMobile,
    String customerName,
    DateTime lastUpdate,
    Customer customer,
    List<DueItem> dueListItems,
  }) =>
      Due(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        shopId: shopId ?? this.shopId,
        customerId: customerId ?? this.customerId,
        dueAmount: dueAmount ?? this.dueAmount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        customerAddress: customerAddress ?? this.customerAddress,
        customerMobile: customerMobile ?? this.customerMobile,
        customerName: customerName ?? this.customerName,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        customer: customer ?? this.customer,
        dueListItems: dueListItems ?? this.dueListItems,
      );

  factory Due.fromJson(Map<String, dynamic> json) => Due(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        shopId: json["shop_id"] == null ? null : json["shop_id"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        dueAmount: json["due_amount"] == null ? null : json["due_amount"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        customerAddress:
            json["customer_address"] == null ? null : json["customer_address"],
        customerMobile:
            json["customer_mobile"] == null ? null : json["customer_mobile"],
        customerName:
            json["customer_name"] == null ? null : json["customer_name"],
        lastUpdate: json["last_update"] == null
            ? null
            : DateTime.parse(json["last_update"]),
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        dueListItems: json["due_list_items"] == null
            ? null
            : List<DueItem>.from(
                json["due_list_items"].map((x) => DueItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "shop_id": shopId == null ? null : shopId,
        "customer_id": customerId == null ? null : customerId,
        "due_amount": dueAmount == null ? null : dueAmount,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "customer_address": customerAddress == null ? null : customerAddress,
        "customer_mobile": customerMobile == null ? null : customerMobile,
        "customer_name": customerName == null ? null : customerName,
        "last_update": lastUpdate == null ? null : lastUpdate.toIso8601String(),
        "customer": customer == null ? null : customer.toJson(),
        "due_list_items": dueListItems == null
            ? null
            : List<dynamic>.from(dueListItems.map((x) => x.toJson())),
      };
  @override
  String toString() {
    return json.encode(this);
  }
}

class DueItem {
  DueItem({
    this.id,
    this.dueId,
    this.transactionId,
    this.type,
    this.note,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.mobileNumber,
    this.time,
  });

  int id;
  int dueId;
  dynamic transactionId;
  String type;
  String note;
  int amount;
  DateTime createdAt;
  DateTime updatedAt;
  String mobileNumber;
  DateTime time;

  DueItem copyWith({
    int id,
    int dueId,
    dynamic transactionId,
    String type,
    String note,
    int amount,
    DateTime createdAt,
    DateTime updatedAt,
    String mobileNumber,
    DateTime time,
  }) =>
      DueItem(
        id: id ?? this.id,
        dueId: dueId ?? this.dueId,
        transactionId: transactionId ?? this.transactionId,
        type: type ?? this.type,
        note: note ?? this.note,
        amount: amount ?? this.amount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        time: time ?? this.time,
      );

  factory DueItem.fromJson(Map<String, dynamic> json) => DueItem(
        id: json["id"] == null ? null : json["id"],
        dueId: json["due_id"] == null ? null : json["due_id"],
        transactionId: json["transaction_id"],
        type: json["type"] == null ? null : json["type"],
        note: json["note"] == null ? null : json["note"],
        amount: json["amount"] == null ? null : json["amount"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        mobileNumber:
            json["mobile_number"] == null ? null : json["mobile_number"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "due_id": dueId == null ? null : dueId,
        "transaction_id": transactionId,
        "type": type == null ? null : type,
        "note": note == null ? null : note,
        "amount": amount == null ? null : amount,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "mobile_number": mobileNumber == null ? null : mobileNumber,
        "time": time == null ? null : time.toIso8601String(),
      };
}
