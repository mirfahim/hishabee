// To parse this JSON data, do
//
//     final qrCodeResponseModel = qrCodeResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/add_qr_code_response_model.dart';

List<Qrcode> getAllQrCodeResponseModelFromJson(dynamic json) =>
    List<Qrcode>.from((json as List<dynamic>).map((x) => Qrcode.fromJson(x)));

String qrCodeResponseModelToJson(List<Qrcode> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
