import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/new_pages/updated_UI/model/due_history.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';
class DueControllerNew extends GetxController{
  var dueHistory = Rxn<DueHistoryModel>();
ApiService _apiService = ApiService();

  Future<dynamic> getAllDueHistory(
      {String shopId, String startDate, String endDate}){
      String url = '/due/history?shop_id=$shopId&start_date=$startDate&end_date=$endDate';
      return _apiService.makeApiRequest(
          method: apiMethods.get,
          url: url,
          body: null,
          headers: null);
  }
}