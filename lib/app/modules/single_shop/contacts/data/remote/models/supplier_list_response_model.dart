// To parse this JSON data, do
//
//     final getAllCustomerResponseModel = getAllCustomerResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/supplier_model.dart';

List<Supplier> getAllSupplierResponseModelFromJson(String str) =>
    List<Supplier>.from(json.decode(str).map((x) => Supplier.fromJson(x)));

String getAllSupplierResponseModelToJson(List<Supplier> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
