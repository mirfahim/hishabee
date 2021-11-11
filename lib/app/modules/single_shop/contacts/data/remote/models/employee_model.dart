// To parse this JSON data, do
//
//     final employee = employeeFromJson(jsonString);

import 'dart:convert';

import 'contact_model.dart';

List<Employee> employeeFromJson(dynamic str) => List<Employee>.from(
    (str as List<dynamic>).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee extends Contact {
  Employee({
    int id,
    int userId,
    int shopId,
    String name,
    String mobile,
    String email,
    String address,
    String imageSrc,
    DateTime createdAt,
    DateTime updatedAt,
    this.position,
    this.monthlySalary,
    this.employeeId,
  }) : super(id, userId, shopId, name, mobile, email, address, imageSrc,
            createdAt, createdAt);

  final String position;
  final dynamic monthlySalary;
  final String employeeId;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        userId: json["user_id"],
        shopId: json["shop_id"],
        name: json["name"],
        position: json["position"],
        mobile: json["mobile"],
        email: json["email"] == null ? null : json["email"],
        address: json["address"] == null ? null : json["address"],
        monthlySalary:
            json["monthly_salary"] == null ? null : json["monthly_salary"],
        employeeId: json["employee_id"] == null ? null : json["employee_id"],
        imageSrc: json["image_src"] == null ? null : json["image_src"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Employee copyWith({
    int id,
    int userId,
    int shopId,
    String name,
    String position,
    String mobile,
    dynamic email,
    String address,
    String monthlySalary,
    String employeeId,
    dynamic imageSrc,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      Employee(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        shopId: shopId ?? this.shopId,
        name: name ?? this.name,
        position: position ?? this.position,
        mobile: mobile ?? this.mobile,
        email: email ?? this.email,
        address: address ?? this.address,
        monthlySalary: monthlySalary ?? this.monthlySalary,
        employeeId: employeeId ?? this.employeeId,
        imageSrc: imageSrc ?? this.imageSrc,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
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
