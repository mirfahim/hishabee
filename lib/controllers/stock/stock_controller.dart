import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/models/stock/stock_history.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';
class StockController extends GetxController{

  ApiService _apiService = ApiService();
  RxList<dynamic> allStockHistory = <dynamic>[].obs;

  Future<dynamic> stockHistory(
      {int shopId, String startDate, String endDate}) async {
    String url = "/stock_history?shop_id=$shopId&start_date=$startDate&end_date=$endDate";
    return _apiService.makeApiRequiest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }
}