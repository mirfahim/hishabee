// To parse this JSON data, do
//
//     final employeeModel = employeeModelFromJson(jsonString);

import 'dart:convert';

List<EmployeeModel> employeeModelFromJson(dynamic str) =>
    List<EmployeeModel>.from(str.map((x) => EmployeeModel.fromJson(x)));

String employeeModelToJson(List<EmployeeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeModel {
  EmployeeModel({
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
  String imageSrc;
  DateTime createdAt;
  DateTime updatedAt;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    id: json["id"],
    userId: json["user_id"],
    shopId: json["shop_id"],
    name: json["name"],
    position: json["position"],
    mobile: json["mobile"],
    email: json["email"] == null ? null : json["email"],
    address: json["address"] == null ? null : json["address"],
    monthlySalary: json["monthly_salary"] == null ? null : json["monthly_salary"],
    employeeId: json["employee_id"] == null ? null : json["employee_id"],
    imageSrc: json["image_src"] == null ? null : json["image_src"],
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
    "address": address == null ? null : address,
    "monthly_salary": monthlySalary == null ? null : monthlySalary,
    "employee_id": employeeId == null ? null : employeeId,
    "image_src": imageSrc == null ? null : imageSrc,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
