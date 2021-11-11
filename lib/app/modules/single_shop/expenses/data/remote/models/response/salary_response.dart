// To parse this JSON data, do
//
//     final paySalaryResponse = paySalaryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_model.dart';

PaySalaryResponse paySalaryResponseFromJson(String str) =>
    PaySalaryResponse.fromJson(json.decode(str));

PaySalaryResponse paySalaryResponseFromRawJson(dynamic json) =>
    PaySalaryResponse.fromJson(json);

String paySalaryResponseToJson(PaySalaryResponse data) =>
    json.encode(data.toJson());

class PaySalaryResponse {
  PaySalaryResponse({
    this.code,
    this.message,
    this.salary,
  });

  int code;
  String message;
  Salary salary;

  PaySalaryResponse copyWith({
    int code,
    String message,
    Salary salary,
  }) =>
      PaySalaryResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        salary: salary ?? this.salary,
      );

  factory PaySalaryResponse.fromJson(Map<String, dynamic> json) =>
      PaySalaryResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        salary: json["salary"] == null ? null : Salary.fromJson(json["salary"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "salary": salary == null ? null : salary.toJson(),
      };
}

class Salary {
  Salary({
    this.employeeId,
    this.expenseId,
    this.amount,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.time,
    this.name,
    this.position,
    this.salary,
    this.img,
    this.employee,
  });

  int employeeId;
  int expenseId;
  String amount;
  DateTime updatedAt;
  DateTime createdAt;
  int id;
  DateTime time;
  String name;
  String position;
  int salary;
  dynamic img;
  Employee employee;

  Salary copyWith({
    int employeeId,
    int expenseId,
    String amount,
    DateTime updatedAt,
    DateTime createdAt,
    int id,
    DateTime time,
    String name,
    String position,
    int salary,
    dynamic img,
    Employee employee,
  }) =>
      Salary(
        employeeId: employeeId ?? this.employeeId,
        expenseId: expenseId ?? this.expenseId,
        amount: amount ?? this.amount,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        time: time ?? this.time,
        name: name ?? this.name,
        position: position ?? this.position,
        salary: salary ?? this.salary,
        img: img ?? this.img,
        employee: employee ?? this.employee,
      );

  factory Salary.fromJson(Map<String, dynamic> json) => Salary(
        employeeId: json["employee_id"] == null ? null : json["employee_id"],
        expenseId: json["expense_id"] == null ? null : json["expense_id"],
        amount: json["amount"] == null ? null : json["amount"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"] == null ? null : json["id"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        name: json["name"] == null ? null : json["name"],
        position: json["position"] == null ? null : json["position"],
        salary: json["salary"] == null ? null : json["salary"],
        img: json["img"],
        employee: json["employee"] == null
            ? null
            : Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId == null ? null : employeeId,
        "expense_id": expenseId == null ? null : expenseId,
        "amount": amount == null ? null : amount,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "id": id == null ? null : id,
        "time": time == null ? null : time.toIso8601String(),
        "name": name == null ? null : name,
        "position": position == null ? null : position,
        "salary": salary == null ? null : salary,
        "img": img,
        "employee": employee == null ? null : employee.toJson(),
      };
}
