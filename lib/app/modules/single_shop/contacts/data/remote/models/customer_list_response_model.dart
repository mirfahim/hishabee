// To parse this JSON data, do
//
//     final getAllCustomerResponseModel = getAllCustomerResponseModelFromJson(jsonString);

import 'dart:convert';

import 'customer_model.dart';

List<Customer> getAllCustomerResponseModelFromJson(String str) =>
    List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));

String getAllCustomerResponseModelToJson(List<Customer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
