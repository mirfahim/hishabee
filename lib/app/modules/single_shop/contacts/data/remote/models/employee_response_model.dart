// To parse this JSON data, do
//
//     final employeeResponseModel = employeeResponseModelFromJson(jsonString);

import 'dart:convert';

import 'employee_model.dart';

EmployeeResponseModel employeeResponseModelFromJson(String str) =>
    EmployeeResponseModel.fromJson(json.decode(str));

String employeeResponseModelToJson(EmployeeResponseModel data) =>
    json.encode(data.toJson());

class EmployeeResponseModel {
  EmployeeResponseModel({
    this.code,
    this.message,
    this.employee,
  });

  int code;
  String message;
  Employee employee;

  EmployeeResponseModel copyWith({
    int code,
    String message,
    Employee employee,
  }) =>
      EmployeeResponseModel(
        code: code ?? this.code,
        message: message ?? this.message,
        employee: employee ?? this.employee,
      );

  factory EmployeeResponseModel.fromJson(Map<String, dynamic> json) =>
      EmployeeResponseModel(
        code: json["code"],
        message: json["message"],
        employee: Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "employee": employee.toJson(),
      };
}
