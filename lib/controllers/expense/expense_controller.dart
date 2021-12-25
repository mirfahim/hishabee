import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/expense/pay_salary_page.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_model.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class ExpenseController extends GetxController {
  RxInt totalExpense = 0.obs;
  RxList allExpenseList = [].obs;
  RxList allExpenseCategory = [].obs;
  RxList allExpenseCategoryBased = [].obs;
  ApiService _apiService = ApiService();
  RxInt listCount = 6.obs;
  RxInt categoryWiseTotalAmount = 0.obs;

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
        method: apiMethods.post, url: url, body: null, headers: null);
  }

  Future<dynamic> deleteCategory({String categoryid}) async {
    String url = "/expense_category?id=$categoryid";
    return _apiService.makeApiRequiest(
        method: apiMethods.delete, url: url, body: null, headers: null);
  }

  Future<dynamic> updateCategory(
      {String categoryid, String name, String shopId}) async {
    String url = "/expense_category/?name=$name&shop_id=$shopId&id=$categoryid";
    return _apiService.makeApiRequiest(
        method: apiMethods.put, url: url, body: null, headers: null);
  }

  Future<dynamic> createNewExpense(
      {String shopId,
      String type,
      String purpose,
      String details,
      String amount}) async {
    String url =
        "/expense/add?shop_id=$shopId&type=$type&purpose=$purpose&details=$details&amount=$amount";
    return _apiService.makeApiRequiest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }

  Future<dynamic> updateExpense(
      {String categoryid,
      String type,
      String shopId,
      String purpose,
      String description,
      String amount}) async {
    CustomDialog.showLoadingDialog(message: 'please wait');
    String url =
        "/expense/edit?shop_id=$shopId&type=$type&purpose=$purpose&details=$description&amount=$amount&id=$categoryid&image&image_changed=true";
    return _apiService.makeApiRequiest(
        method: apiMethods.put, url: url, body: null, headers: null);
  }

  Future<dynamic> deleteExpense({String categoryid}) async {
    CustomDialog.showLoadingDialog(message: 'please wait');
    String url = "/expense/delete?id=$categoryid";
    return _apiService.makeApiRequiest(
        method: apiMethods.delete, url: url, body: null, headers: null);
  }
}
