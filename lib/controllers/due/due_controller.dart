import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class DueController extends GetxController {
  final dueList = [].obs;
  final filterList = [].obs;
  final dueHistoryList = [].obs;
  final dueItemList = [].obs;
  final customerCount = 0.obs;
  final employeeCount = 0.obs;
  final supplierCount = 0.obs;

  ApiService _apiService = ApiService();

  Future<dynamic> getAllDue({shopId, startDate, endDate}) {
    String url = '/due/all?shop_id=$shopId'
        '${startDate == null ? '' : '&start_date=$startDate'}'
        '${endDate == null ? '' : '&end_date=$endDate'}';
    return _apiService.makeApiRequest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  Future<dynamic> getAllItemWithUniqueID({uniqueId}) {
    String url = '/due/items?unique_id=$uniqueId';
    return _apiService.makeApiRequest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  Future<dynamic> getAllDueHistory({shopId, startDate, endDate}) {
    String url = '/due/history?shop_id=$shopId'
        '${startDate == null ? '' : '&start_date=$startDate'}'
        '${endDate == null ? '' : '&end_date=$endDate'}';
    return _apiService.makeApiRequest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  Future<dynamic> deleteDue(
      {shopId,
        amount,
      uniqueId,
        dueUniqueId,
        dueLeft,
      updatedAt,
      createdAt}) async {
    String url = '/due_item/add?amount=$amount&shop_id=$shopId'
        '&unique_id=$uniqueId&due_unique_id=$dueUniqueId&due_left=$dueLeft&'
        'version=-1&updated_at=$updatedAt&created_at=$createdAt';
    return _apiService.makeApiRequest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }
  buyerContact(){

  }
}
