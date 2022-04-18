import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class DueController extends GetxController {
  final dueList = [].obs;
  final filterList = [].obs;
  final dueItemList = [].obs;
  final customerCount = 0.obs;
  final employeeCount = 0.obs;
  final supplierCount = 0.obs;

  ApiService _apiService = ApiService();
  Future<dynamic> getAllDue({shopId, startDate, endDate}) {
    String url = '/due/all?shop_id=$shopId'
        '${startDate == null ? '':'&start_date=$startDate'}'
        '${endDate == null ? '':'&end_date=$endDate'}';
    return _apiService.makeApiRequest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null);
  }
  Future<dynamic> getAllItemWithUniqueID({uniqueId}){
    String url = '/due/items?unique_id=$uniqueId';
    return _apiService.makeApiRequest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null);
  }
  Future<dynamic> getAllDueHistory({shopId,startDate, endDate}){
    String url = '/due/history?shop_id=$shopId'
        '${startDate == null ? '':'&start_date=$startDate'}'
        '${endDate == null ? '':'&end_date=$endDate'}';
    return _apiService.makeApiRequest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null);
  }
}
