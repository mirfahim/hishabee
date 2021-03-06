import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/expense/custom_expense_page.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_model.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class DueController extends GetxController {
  RxInt totalExpense = 0.obs;
  RxInt fixedAmount = 0.obs;
  RxInt totalFixedExpense = 0.obs;
  RxInt fixedAmountForEditDelete = 0.obs;
  RxList allExpenseList = [].obs;
  RxList allFixedExpenseList = [].obs;
  RxList allExpenseCategory = [].obs;
  RxList allExpenseCategoryBased = [].obs;
  ApiService _apiService = ApiService();
  RxInt listCount = 6.obs;
  RxInt categoryWiseTotalAmount = 0.obs;
  RxList fixedCategory = [].obs;

  Future<dynamic> getAllDue(
      {String shopId, String userId, String startDate, String endDate}) async {
    String url = "/due/all?shop_id=$shopId";
    return _apiService.makeApiRequest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }

  Future<dynamic> getAllExpenseCategory({String shopId}) async {
    String url = "/expense_category?shop_id=$shopId";
    return _apiService.makeApiRequest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }

  Future<dynamic> createNewExpenseType({String shopId, String name}) async {
    CustomDialog.showLoadingDialog(message: 'Creating Expense Type');
    String url = "/expense_category/?name=$name&shop_id=$shopId";
    return _apiService.makeApiRequest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }

  Future<dynamic> deleteCategory({String categoryid}) async {
    CustomDialog.showLoadingDialog(message: 'please wait');
    String url = "/expense_category?id=$categoryid";
    return _apiService.makeApiRequest(
        method: apiMethods.delete, url: url, body: null, headers: null);
  }

  Future<dynamic> updateCategory(
      {String categoryid, String name, String shopId}) async {
    CustomDialog.showLoadingDialog(message: 'Updating Expense Type');
    String url = "/expense_category/?name=$name&shop_id=$shopId&id=$categoryid";
    return _apiService.makeApiRequest(
        method: apiMethods.put, url: url, body: null, headers: null);
  }

  Future<dynamic> createNewExpense(
      {String shopId,
      String type,
      String purpose,
      String details,
      String amount}) async {
    CustomDialog.showLoadingDialog(message: 'Creating New Expense');
    String url =
        "/expense/add?shop_id=$shopId&type=$type&purpose=$purpose&details=$details&amount=$amount";
    return _apiService.makeApiRequest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }

  Future<dynamic> updateExpense(
      {String categoryid,
      String type,
      String shopId,
      String purpose,
      String description,
      String amount}) async {
    CustomDialog.showLoadingDialog(message: 'Updating...');
    String url =
        "/expense/edit?shop_id=$shopId&type=$type&purpose=$purpose&details=$description&amount=$amount&id=$categoryid&image&image_changed=true";
    return _apiService.makeApiRequest(
        method: apiMethods.put, url: url, body: null, headers: null);
  }

  Future<dynamic> deleteExpense({String categoryid}) async {
    CustomDialog.showLoadingDialog(message: 'please wait');
    String url = "/expense/delete?id=$categoryid";
    return _apiService.makeApiRequest(
        method: apiMethods.delete, url: url, body: null, headers: null);
  }
}
