// To parse this JSON data, do
//
//     final getAllSubscriptionResponse = getAllSubscriptionResponseFromJson(jsonString);

import 'dart:convert';

import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/add_new_subscription_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/subscription_model.dart';

List<Subscription> getAllSubscriptionResponseFromJson(String str) =>
    List<Subscription>.from(
        json.decode(str).map((x) => Subscription.fromJson(x)));

List<Subscription> getAllSubscriptionResponseFromRawJson(dynamic json) =>
    List<Subscription>.from(
        (json as List<dynamic>).map((x) => Subscription.fromJson(x)));

String getAllSubscriptionResponseToJson(List<Subscription> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
