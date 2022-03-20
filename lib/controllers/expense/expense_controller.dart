import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/expense/custom_expense_page.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_model.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class ExpenseController extends GetxController {

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
  final employeeNameController = TextEditingController();
  final image = Rxn<File>();

  Future<dynamic> getAllExpense({String shopId, String userId, String startDate, String endDate,}) async {
    String url = "/expense/all?user_id=$userId&shop_id=$shopId&start_date=$startDate&end_date=$endDate";
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

  Future<dynamic> createNewExpenseEmployee(
      {String shopId,
        String type,
        String purpose,
        String details,
        String amount,
        File imageURL, String contactName,String contactNumber}
      ) async{
    CustomDialog.showLoadingDialog(message: 'Creating New Expense');
    String imageUrl ='';

    if(imageURL != null){
      String imageSource = await _apiService.uploadFile(file: imageURL, type: '');
      imageUrl = imageSource
          .replaceAll("\\", "")
          .replaceAll('"', "")
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAllMapped('url:', (match) => "");
    }else{
      imageUrl = '';
    }

    print('image url from main function ${imageUrl}');
    String url =
        "/expense/add?shop_id=$shopId&type=$type&purpose=$purpose&"
        "contact_name=$contactName&contact_type=EMPLOYEE"
        "&details=$details&amount=$amount&image=$imageUrl&contact_name=$contactName";
    return _apiService.makeApiRequest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }
  Future<dynamic> createNewExpense(
      {String shopId,
      String type,
      String purpose,
      String details,
      String amount,
      File imageURL}) async {

    CustomDialog.showLoadingDialog(message: 'Creating New Expense');
    String imageUrl ='';

    if(imageURL != null){
      String imageSource = await _apiService.uploadFile(file: imageURL, type: '');
       imageUrl = imageSource
          .replaceAll("\\", "")
          .replaceAll('"', "")
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAllMapped('url:', (match) => "");
    }else{
      imageUrl = '';
    }

    print('image url from main function ${imageUrl}');
    String url =
        "/expense/add?shop_id=$shopId&type=$type&purpose=$purpose&details=$details&amount=$amount&image=$imageUrl";
    return _apiService.makeApiRequest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }

  Future<dynamic> updateExpenseWithoutImage(
    {String categoryid,
      String contactName,
    String type,
    String shopId,
    String purpose,
    String description,
    String amount,
    String date}) async {
    CustomDialog.showLoadingDialog(message: 'Updating...');
    String url =
        "/expense/edit?shop_id=$shopId${contactName != null ? '&contact_name=$contactName':''}&type=$type&purpose=$purpose${description != null ? '&details=$description' : ''}"
        "&amount=$amount&id=$categoryid&created_at="
        "$date";
    print('date from update $date');
    return _apiService.makeApiRequest(
        method: apiMethods.put, url: url, body: null, headers: null);
  }
  Future<dynamic> updateExpense(
      {String categoryid,
        String contactName,
      String type,
      String shopId,
      String purpose,
      String description,
      String amount,
      String date, File imageUrl, bool imageChange}) async {
    CustomDialog.showLoadingDialog(message: 'Updating...');

    String imageURL ='';
    if(imageUrl != null){
      String imageSource = await _apiService.uploadFile(file: imageUrl, type: '');
       imageURL = imageSource
          .replaceAll("\\", "")
          .replaceAll('"', "")
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAllMapped('url:', (match) => "");
    }else{
      imageURL ='';
    }
      print('print from expense controller update $imageChange');
      String url =
          "/expense/edit?shop_id=$shopId${contactName != null ? '&contact_name=$contactName':''}&type=$type&purpose=$purpose${description != null ? '&details=$description' : ''}"
          "&amount=$amount&id=$categoryid&image=$imageURL&created_at="
          "$date&image_changed=$imageChange";
      print('date from update $date');
      return _apiService.makeApiRequest(
          method: apiMethods.put, url: url, body: null, headers: null);
    // }

  }

  Future<dynamic> deleteExpense({String categoryid}) async {
    CustomDialog.showLoadingDialog(message: 'please wait');
    String url = "/expense/delete?id=$categoryid";
    return _apiService.makeApiRequest(
        method: apiMethods.delete, url: url, body: null, headers: null);
  }
  Future<dynamic> fetchEmployee({String shopId}){
    String url = "/employee/all?shop_id=$shopId";
    return _apiService.makeApiRequest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }
}
