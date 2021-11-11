// To parse this JSON data, do
//
//     final getAllCustomerResponseModel = getAllCustomerResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_model.dart';

List<Employee> getAllEmployeeResponseModelFromJson(String str) =>
    List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String getAllEmployeeResponseModelToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
