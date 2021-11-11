// To parse this JSON data, do
//
//     final paySalaryRequest = paySalaryRequestFromJson(jsonString);

import 'dart:convert';

PaySalaryRequest paySalaryRequestFromJson(String str) =>
    PaySalaryRequest.fromJson(json.decode(str));

PaySalaryRequest paySalaryRequestFromRawJson(dynamic json) =>
    PaySalaryRequest.fromJson(json);

String paySalaryRequestToJson(PaySalaryRequest data) =>
    json.encode(data.toJson());

class PaySalaryRequest {
  PaySalaryRequest({
    this.shopId,
    this.type,
    this.purpose,
    this.details,
    this.amount,
    this.time,
    this.employeeId,
    this.expenseTime,
  });

  int shopId;
  String type;
  String purpose;
  String details;
  int amount;
  DateTime time;
  int employeeId;
  DateTime expenseTime;

  PaySalaryRequest copyWith({
    int shopId,
    String type,
    String purpose,
    String details,
    int amount,
    DateTime time,
    int employeeId,
    DateTime expenseTime,
  }) =>
      PaySalaryRequest(
        shopId: shopId ?? this.shopId,
        type: type ?? this.type,
        purpose: purpose ?? this.purpose,
        details: details ?? this.details,
        amount: amount ?? this.amount,
        time: time ?? this.time,
        employeeId: employeeId ?? this.employeeId,
        expenseTime: expenseTime ?? this.expenseTime,
      );

  factory PaySalaryRequest.fromJson(Map<String, dynamic> json) =>
      PaySalaryRequest(
        shopId: json["shop_id"] == null ? null : json["shop_id"],
        type: json["type"] == null ? null : json["type"],
        purpose: json["purpose"] == null ? null : json["purpose"],
        details: json["details"] == null ? null : json["details"],
        amount: json["amount"] == null ? null : json["amount"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        employeeId: json["employee_id"] == null ? null : json["employee_id"],
        expenseTime: json["expense_time"] == null
            ? null
            : DateTime.parse(json["expense_time"]),
      );

  Map<String, dynamic> toJson() => {
        "shop_id": shopId == null ? null : shopId,
        "type": type == null ? null : type,
        "purpose": purpose == null ? null : purpose,
        "details": details == null ? null : details,
        "amount": amount == null ? null : amount,
        "time": time == null ? null : time.toIso8601String(),
        "employee_id": employeeId == null ? null : employeeId,
        "expense_time":
            expenseTime == null ? null : expenseTime.toIso8601String(),
      };
}
