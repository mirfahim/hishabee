import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';
import 'package:uuid/uuid.dart';

class DueController extends GetxController {
  final dueList = [].obs;
  final filterList = [].obs;
  final dueHistoryList = [].obs;
  final dueItemList = [].obs;
  final customerCount = 0.obs;
  final employeeCount = 0.obs;
  final supplierCount = 0.obs;
  final payDue = 0.0.obs;
  final takeDue = 0.0.obs;
  final addNewDueName = TextEditingController().obs;
  final addNewDueMobile = TextEditingController().obs;
  final addNewDueAmount = TextEditingController().obs;
  final addNewDueDescription = TextEditingController().obs;
  var dueUniqueId;
  final dueItemUniqueId = '';
  var imageForAddDue;

  ApiService _apiService = ApiService();

  Future<dynamic> getAllDue({shopId, startDate, endDate}) {
    String url = '/due/all?shop_id=$shopId'
        '${startDate == null ? '' : '&start_date=$startDate'}'
        '${endDate == null ? '' : '&end_date=$endDate'}';
    return _apiService.makeApiRequest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  Future<dynamic> getAllDueItem({shopId}) {
    String url = '/due_item/all?shop_id=$shopId';
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
        'version=${-1}&updated_at=$updatedAt&created_at=$createdAt';
    return _apiService.makeApiRequest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }

  Future<dynamic> addNewDue(
      {amount, shopId, contactType, mobile, name, updatedDate, createdDate, image, dueAlert, uniqueId}) async {

    dueUniqueId = uniqueId;
    CustomDialog.showLoadingDialog(message: 'Creating Due...');
    if(image != null){
      String imageSource = await _apiService.uploadFile(file: image, type: '');
      image = imageSource
          .replaceAll("\\", "")
          .replaceAll('"', "")
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAllMapped('url:', (match) => "");
      imageForAddDue = image;
    }else{
      image = '';
      imageForAddDue = '';
    }
    String url = '/due/add?amount=$amount&shop_id=$shopId&unique_id=$dueUniqueId'
        '&contact_type=$contactType&contact_mobile=$mobile&contact_name=$name'
        '&version=0&updated_at=$updatedDate&created_at=$createdDate&due_alert=$dueAlert&image=$imageForAddDue';
    return _apiService.makeApiRequest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }

  Future<dynamic> addNewDueItem(
      {amount, shopId, contactType, mobile, name, updatedDate, createdDate, dueAlert, dueItemUniqueId}) async {
    // const dueItemUniqueId = Uuid();
    // var id = dueItemUniqueId.v4();
    //asdasdasdasdasd
    CustomDialog.showLoadingDialog(message: 'Creating Due...');
    // if(image != null){
    //   String imageSource = await _apiService.uploadFile(file: image, type: '');
    //   image = imageSource
    //       .replaceAll("\\", "")
    //       .replaceAll('"', "")
    //       .replaceAll("{", "")
    //       .replaceAll("}", "")
    //       .replaceAllMapped('url:', (match) => "");
    // }else{
    //   image = '';
    // }
    String url = '/due_item/add?amount=$amount&shop_id=$shopId&unique_id=$dueItemUniqueId&due_unique_id=$dueUniqueId&due_left=$amount'
        '&version=0&updated_at=$updatedDate&created_at=$createdDate&due_alert=$dueAlert&image=$imageForAddDue';
    return _apiService.makeApiRequest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }

  Future<dynamic> editDue(
      {amount,
      shopId,
      contactType,
      mobile,
      name,
      updatedDate,
      createdDate,
      version}) {
    const uniqueId = Uuid();
    var id = uniqueId.v4();
    String url = '/due/add?amount=$amount&shop_id=$shopId&unique_id=$id'
        '&contact_type=$contactType&contact_mobile=$mobile&contact_name=$name'
        '&version=$version&updated_at=$updatedDate&created_at=$createdDate';
    return _apiService.makeApiRequest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }

  Future<dynamic> editDueItem(
      {amount,
      shopId,
      contactType,
      mobile,
      name,
      updatedDate,
      createdDate,
      version,
      dueUniqueId,
      dueLeft}) {
    const uniqueId = Uuid();
    var id = uniqueId.v4();
    String url = '/due_item/add?amount=$amount&shop_id=$shopId&unique_id=$id'
        '&due_unique_id=$dueUniqueId&due_left=$dueLeft'
        '&version=$version&updated_at=$updatedDate&created_at=$createdDate';
    return _apiService.makeApiRequest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }
}
