// To parse this JSON data, do
//
//     final salaryResponseModel = salaryResponseModelFromJson(jsonString);

import 'dart:convert';

List<SalaryResponseModel> salaryResponseModelFromJson(dynamic str) =>
    List<SalaryResponseModel>.from(
        (str as List<dynamic>).map((x) => SalaryResponseModel.fromJson(x)));

String salaryResponseModelToJson(List<SalaryResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SalaryResponseModel {
  SalaryResponseModel({
    this.id,
    this.employeeId,
    this.expenseId,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.time,
    this.name,
    this.position,
    this.salary,
    this.img,
    this.employee,
  });

  int id;
  int employeeId;
  int expenseId;
  int amount;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime time;
  String name;
  String position;
  int salary;
  dynamic img;
  Employee employee;

  factory SalaryResponseModel.fromJson(Map<String, dynamic> json) =>
      SalaryResponseModel(
        id: json["id"],
        employeeId: json["employee_id"],
        expenseId: json["expense_id"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        time: DateTime.parse(json["time"]),
        name: json["name"],
        position: json["position"],
        salary: json["salary"] == null ? null : json["salary"],
        img: json["img"],
        employee: Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "expense_id": expenseId,
        "amount": amount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "time": time.toIso8601String(),
        "name": name,
        "position": position,
        "salary": salary == null ? null : salary,
        "img": img,
        "employee": employee.toJson(),
      };
}

class Employee {
  Employee({
    this.id,
    this.userId,
    this.shopId,
    this.name,
    this.position,
    this.mobile,
    this.email,
    this.address,
    this.monthlySalary,
    this.employeeId,
    this.imageSrc,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  int shopId;
  String name;
  String position;
  String mobile;
  String email;
  String address;
  int monthlySalary;
  String employeeId;
  dynamic imageSrc;
  DateTime createdAt;
  DateTime updatedAt;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        userId: json["user_id"],
        shopId: json["shop_id"],
        name: json["name"],
        position: json["position"],
        mobile: json["mobile"],
        email: json["email"] == null ? null : json["email"],
        address: json["address"],
        monthlySalary:
            json["monthly_salary"] == null ? null : json["monthly_salary"],
        employeeId: json["employee_id"] == null ? null : json["employee_id"],
        imageSrc: json["image_src"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "shop_id": shopId,
        "name": name,
        "position": position,
        "mobile": mobile,
        "email": email == null ? null : email,
        "address": address,
        "monthly_salary": monthlySalary == null ? null : monthlySalary,
        "employee_id": employeeId == null ? null : employeeId,
        "image_src": imageSrc,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
