import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class DueController extends GetxController {
  final dueList = [].obs;
  final filterList = [].obs;
  final customerCount = 0.obs;
  final employeeCount = 0.obs;
  final supplierCount = 0.obs;

  ApiService _apiService = ApiService();
  Future<dynamic> getAllDue({shopId}) {
    String url = '/due/all?shop_id=$shopId';
    return _apiService.makeApiRequest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null);
  }
}
