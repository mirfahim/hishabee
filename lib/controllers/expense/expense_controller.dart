import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_model.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class ExpenseController extends GetxController {
  RxInt totalExpense = 0.obs;
  RxList allExpenseList = [].obs;
  RxList allExpenseCategory = [].obs;
  ApiService _apiService = ApiService();

  Future<dynamic> getAllExpense({String shopId, String userId}) async {
    String url = "/expense/all?user_id=$userId&shop_id=$shopId";
    return _apiService.makeApiRequiest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }
  Future<dynamic> getAllExpenseCategory({String shopId}) async {
    String url = "/expense_category?shop_id=$shopId";
    return _apiService.makeApiRequiest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }

  Future<dynamic> createNewExpenseType({String shopId, String name}) async {
    String url = "/expense_category/?name=$name&shop_id=$shopId";
    return _apiService.makeApiRequiest(
      method: apiMethods.post,
        url: url,
        body: null,
        headers: null
    );
  }
}
