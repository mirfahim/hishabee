import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
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
  ///contacts
  final image = Rxn<File>();
  final nameForContact = ''.obs;
  final address = ''.obs;
  final contactMobileNumber = ''.obs;
  final email = ''.obs;
  final position = ''.obs;
  final employeeId = ''.obs;
  final salary = 0.obs;
  final suppliedItems = ''.obs;
  // final contact = Rxn<Contact>();

  final name = ''.obs;
  final mobile = ''.obs;
  final maxLengthForText = 160.obs;
  final textInTheMessageField = ''.obs;
  final messageCount = 1.obs;
  final mobileNumbers = ''.obs;
  final totalSmsLeft = 0.obs;
  final changedSms = 0.obs;
  final circular = false.obs;
  var visibility = false.obs;
  final searchListContact = [].obs;
  final contactList = [].obs;
  RxList selectedMobileNumber = [].obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  ApiService _apiService = ApiService();
  var storageSmsCount = GetStorage('sms_count');
  RxList<Contact> contacts = <Contact>[].obs;

  ///CONTACTS

  Future<dynamic> addNewCustomer(
      {String shopId,
      int id,
      String name,
      String address,
      String mobile,
      String emailId,
      String imageUrl}) async{
    CustomDialog.showLoadingDialog(message: "Adding customer");
    if(imageUrl != null){
      String imageSource = await _apiService.uploadFile(file: File(imageUrl), type: '');
      imageUrl = imageSource
          .replaceAll("\\", "")
          .replaceAll('"', "")
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAllMapped('url:', (match) => "");
    }
    String url = "/customer/add?name=$name&shop_id=$shopId&address=$address&email="
        "$email&mobile=$mobile&image_src=${imageUrl == null ? '' : imageUrl}";
    return _apiService.makeApiRequest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }

  Future<dynamic> addNewEmploye({
    String shopId,
    int salary,
    int id,
    String name,
    String address,
    String mobile,
    String emailId,
    String position,
    String imageUrl}) async{
    CustomDialog.showLoadingDialog(message: "Adding customer");
    if(imageUrl != null){
      String imageSource = await _apiService.uploadFile(file: File(imageUrl), type: '');
      imageUrl = imageSource
          .replaceAll("\\", "")
          .replaceAll('"', "")
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAllMapped('url:', (match) => "");
    }
    String url = "/employee/add?name=$name&shop_id=$shopId&address="
        "$address&position=$position&mobile="
        "$mobile&monthly_salary=$salary&image_src=${imageUrl == null ? '' : imageUrl}";
    return _apiService.makeApiRequest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }

  Future<dynamic> addNewSupplier({
    String shopId,
    int id,
    String name,
    String address,
    String mobile,
    String emailId,
    String imageUrl,
    String suppliedItems}) async{
    CustomDialog.showLoadingDialog(message: "Adding customer");
    if(imageUrl != null){
      String imageSource = await _apiService.uploadFile(file: File(imageUrl), type: '');
      imageUrl = imageSource
          .replaceAll("\\", "")
          .replaceAll('"', "")
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAllMapped('url:', (match) => "");
    }
    String url = "/supplier/add?name=$name&shop_id=$shopId&address=$address&email="
        "$emailId&mobile=$mobile&supplied_items=$suppliedItems&"
        "image_src=${imageUrl == null ? '' : imageUrl}";
    return _apiService.makeApiRequest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }

  Future<dynamic> fetchAllSms(
      {String shopId, String statDate, String endDate}) async {
    String url = "/sms?shop_id=$shopId";
    return _apiService.makeApiRequest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }

  Future<dynamic> fetchSmsPackage() async {
    String url = "/sms/packages";
    return _apiService.makeApiRequest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  Future<dynamic> createSms(
      {String shopId, String number, String message, String smsCount}) async {
    String url =
        "/sms/add?shop_id=$shopId&number=$number&message=$message&sms_count=$smsCount";
    return _apiService.makeApiRequest(
        method: apiMethods.post, url: url, body: null, headers: null);
  }

  getAllContacts() async {
    var status = await Permission.contacts.request();
    if (status.isGranted) {
      List<Contact> _contacts = await ContactsService.getContacts();
      _contacts.forEach((contact) {
        print(contact.displayName);
        contactList.value = _contacts.toList();
        searchListContact.value = _contacts.toList();
      });
      // print("my contacts are ${contacts.}");
      // contacts.value = _contacts.toList();
      List allContact = _contacts.toList();
      //print("my all contact are ${contacts.value[0].phones[0].value}");
    } else if (status.isDenied) {
      List<Contact> _contacts = await ContactsService.getContacts();
      contactList.value = _contacts.toList();
      searchListContact.value = _contacts.toList();
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
  Future<dynamic> checkSubcription(String shopId) async {
    String url = '/subscription/verify?shop_id=$shopId';
    return _apiService.makeApiRequest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  getAllContactsFromPhone() async {
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
    return _apiService.makeApiRequest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  Future<dynamic> getAllEmployeContact(String shopId) {
    String url = '/employee/all?shop_id=$shopId';
    return _apiService.makeApiRequest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  Future<dynamic> getAllSuplierContact(String shopId) {
    String url = '/supplier/all?shop_id=$shopId';
    return _apiService.makeApiRequest(
        method: apiMethods.get, url: url, body: null, headers: null);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    // super.onInit();
  }
}
