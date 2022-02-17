import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/repositories/auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/data_sources/shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/models/sms/create_sms_model.dart';
import 'package:hishabee_business_manager_fl/models/sms/sms_package_model.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SmsController extends GetxController {
  final maxLengthForText = 160.obs;
  final textInTheMessageField = ''.obs;
  final messageCount = 1.obs;
  final mobileNumbers = ''.obs;
  final totalSmsLeft = 0.obs;
  final changedSms = 0.obs;
  final circular = false.obs;
  var visibility = false.obs;
  final selectedMobileNumber = [].obs;
  ApiService _apiService = ApiService();
  var storageSmsCount = GetStorage('sms_count');
  RxList<Contact> contacts = <Contact>[].obs;

  Future<dynamic> fetchAllSms(
      {String shopId, String statDate, String endDate}) async {
    String url = "/sms?shop_id=$shopId";
    return _apiService.makeApiRequiest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }

  Future<dynamic> fetchSmsPackage() async {
    String url = "/sms/packages";
    return _apiService.makeApiRequiest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  Future<dynamic> createSms(
      {String shopId, String number, String message, String smsCount}) async {
    String url =
        "/sms/add?shop_id=$shopId&number=$number&message=$message&sms_count=$smsCount";
    return _apiService.makeApiRequiest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }

  Future<dynamic> checkSubcription(String shopId) async {
    String url = '/subscription/verify?shop_id=$shopId';
    return _apiService.makeApiRequiest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  getAllContacts() async {
    var status = await Permission.contacts.request();
    if (status.isGranted) {
      List<Contact> _contacts = await ContactsService.getContacts();
      _contacts.forEach((contact) {
        print(contact.displayName);
        contacts.value = _contacts.toList();
      });
      // print("my contacts are ${contacts.}");
      // contacts.value = _contacts.toList();
      List allContact = _contacts.toList();
      //print("my all contact are ${contacts.value[0].phones[0].value}");
    } else if (status.isDenied) {
      List<Contact> _contacts = await ContactsService.getContacts();
      contacts.value = _contacts.toList();
    } else {
      showDialog(
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text('Contacts list permission'),
                content: Text('This app needs contact list access'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('Deny'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                    child: Text('Settings'),
                    onPressed: () => openAppSettings(),
                  ),
                ],
              ));
    }
  }

  Future<dynamic> getAllCustomerContact(String shopId) {
    String url = '/customer/all?shop_id=$shopId';
    return _apiService.makeApiRequiest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  Future<dynamic> getAllEmployeContact(String shopId) {
    String url = '/employee/all?shop_id=$shopId';
    return _apiService.makeApiRequiest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  Future<dynamic> getAllSuplierContact(String shopId) {
    String url = '/supplier/all?shop_id=$shopId';
    return _apiService.makeApiRequiest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    // super.onInit();
  }
}
