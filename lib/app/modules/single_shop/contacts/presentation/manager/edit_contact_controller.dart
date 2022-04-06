import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/_navigation/contact_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/contact_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/supplier_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_contact_repository.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';
import 'package:http/http.dart';

import 'contact_controller.dart';

class EditContactsController extends GetxController {
  final name = "".obs;
  final position = "".obs;
  final employeeId = ''.obs;
  final email = "".obs;
  final address = "".obs;
  final mobile = "".obs;
  final monthlySalary = 0.obs;
  final suppliedItems = "".obs;
  final image = Rxn<File>();

  final contactType = ''.obs;
  final contact = Rxn<Contact>();
  final shop = Rxn<Shop>();
  final formKey = GlobalKey<FormState>();

  final loading = false.obs;

  EditContactsController(this.contactRepository, this.fileRepository);

  final IContactRepository contactRepository;
  final IFileRepository fileRepository;
  ApiService _apiService = ApiService();
  @override
  onInit() {
    getArguments();
    super.onInit();
  }

  getArguments() {
    shop.value = Get.arguments['shop'];
    contactType.value = Get.arguments["type"];
    contact.value = Get.arguments["contact"];
  }

  editEmployeeNew({int shopId, int id, String name, String address, String mobile,
  String emailId, String employeeId, String position, int monthlySalary, String imageUrl
  }) async{

    if(imageUrl != null){
      String imageSource = await _apiService.uploadFile(file: File(imageUrl), type: '');
      imageUrl = imageSource
          .replaceAll("\\", "")
          .replaceAll('"', "")
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAllMapped('url:', (match) => "");
    }
    String url =
        "/employee/edit?name=$name&shop_id="
        "$shopId&address=$address&position=$position&mobile="
        "$mobile&email=$emailId&monthly_salary=$monthlySalary&image_src="
        "${imageUrl == null ? '' : imageUrl}&id="
        "$id&employee_id=${employeeId == null ? '': employeeId}";
    print('image url from function : $imageUrl');
    print('url link from function: $url');
    return _apiService.makeApiRequest(
        method: apiMethods.put, url: url, body: null, headers: null);

  }
  editCustomerNew({int shopId, int id, String name, String address, String mobile,
    String emailId, String imageUrl
  }) async{

    if(imageUrl != null){
      String imageSource = await _apiService.uploadFile(file: File(imageUrl), type: '');
      imageUrl = imageSource
          .replaceAll("\\", "")
          .replaceAll('"', "")
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAllMapped('url:', (match) => "");
    }
    String url =
        "/customer/edit?name=$name&shop_id=$shopId&address="
        "$address&mobile=$mobile&email=$emailId&image_src="
        "${imageUrl == null ? '' : imageUrl}&id=$id";
    print('image url from function : $imageUrl');
    print('url link from function: $url');
    return _apiService.makeApiRequest(
        method: apiMethods.put, url: url, body: null, headers: null);

  }

  editSupplierNew({int shopId, int id, String name, String address, String mobile,
    String emailId, String imageUrl
  }) async{

    if(imageUrl != null){
      String imageSource = await _apiService.uploadFile(file: File(imageUrl), type: '');
      imageUrl = imageSource
          .replaceAll("\\", "")
          .replaceAll('"', "")
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAllMapped('url:', (match) => "");
    }
    String url =
        "/supplier/edit?name=$name&shop_id=$shopId&address="
        "$address&mobile=$mobile&email="
        "$emailId&image_src=${imageUrl == null ? '' : imageUrl}&id=$id";
    print('image url from function : $imageUrl');
    print('url link from function: $url');
    return _apiService.makeApiRequest(
        method: apiMethods.put, url: url, body: null, headers: null);

  }
  deleteEmployee({int id}) async{
    String url = '/employee/delete?id=$id';
    return _apiService.makeApiRequest(
      method: apiMethods.delete, url: url, body: null, headers: null
    );
  }
  deleteCustomer({int id, int shopId}) async{
    String url = '/customer/delete?shop_id=$shopId&id=$id';
    return _apiService.makeApiRequest(
        method: apiMethods.delete, url: url, body: null, headers: null
    );
  }
  deleteSupplier({int id, int shopId}) async{
    String url = '/supplier/delete?shop_id=$shopId&id=$id';
    return _apiService.makeApiRequest(
        method: apiMethods.delete, url: url, body: null, headers: null
    );
}
  editEmployee() async {
    CustomDialog.showLoadingDialog();
    String imageSource;
    Employee employee;
    // try {
      if (image.value != null) {
        imageSource = await fileRepository.uploadFile(
            file: image.value, type: contactType.value);
        String imageUrl = imageSource
            .replaceAll("\\", "")
            .replaceAll('"', "")
            .replaceAll("{", "")
            .replaceAll("}", "")
            .replaceAllMapped('url:', (match) => "");
        employee = await contactRepository.updateEmployee(
          shopId: shop.value.id,
          id: contact.value.id,
          name: name.value,
          address: address.value,
          mobile: mobile.value,
          email: email.value,
          employeeId: employeeId.value,
          position: position.value,
          monthlySalary: monthlySalary.value,
          imageSource: imageUrl,
        );
      }
      else{
        employee = await contactRepository.updateEmployee(
            shopId: shop.value.id,
            id: contact.value.id,
            name: name.value,
            address: address.value,
            mobile: mobile.value,
            email: email.value,
            employeeId: employeeId.value,
            position: position.value,
            monthlySalary: monthlySalary.value);
      }


      final cc = Get.find<ContactController>();

      await cc.getAllEmployee();

      if (Get.isDialogOpen) {
        Get.back();
      }

      CustomDialog.showStringDialog('Contact updated successfully');
      Future.delayed(Duration(seconds: 1), () {
        Get.back();
        Get.back();
        Get.back();
      });
    // } catch (e) {
    //   CustomDialog.showStringDialog(e.toString());
    //   final cc = Get.find<ContactController>();
    //   cc.tabIndex.value = 0;
    //
    //   // Get.back();
    // }
  }

  editCustomer() async {
    CustomDialog.showLoadingDialog(message: "Editing contact");
    String imageSource;
    Customer customer;

    try {
      if (image.value != null) {
        imageSource = await fileRepository.uploadFile(
            file: image.value, type: contactType.value);
        customer = await contactRepository.updateCustomer(
          shopId: shop.value.id,
          id: contact.value.id,
          name: name.value,
          email: email.value,
          mobile: mobile.value,
          address: address.value,
          imageSource: imageSource,
        );
      }
      customer = await contactRepository.updateCustomer(
        shopId: shop.value.id,
        id: contact.value.id,
        name: name.value,
        email: email.value,
        mobile: mobile.value,
        address: address.value,
      );

      final cc = Get.find<ContactController>();

      await cc.getAllCustomer();

      if (Get.isDialogOpen) {
        Get.back();
        CustomDialog.showStringDialog('Contact updated successfully');
        Future.delayed(Duration(seconds: 1), () {
          Get.back();
          Get.back();
          Get.back();
        });
      }
    } catch (e) {
      CustomDialog.showStringDialog(e.toString());
      final cc = Get.find<ContactController>();
      cc.tabIndex.value = 1;

      Get.offAllNamed(ContactRoutes.CONTACTS);
    }
  }

  editSupplier() async {
    CustomDialog.showLoadingDialog(message: "Editing contact");
    String imageSource;
    Supplier supplier;
    try {
      if (image.value != null) {
        imageSource = await fileRepository.uploadFile(
            file: image.value, type: contactType.value);
        supplier = await contactRepository.updateSupplier(
          shopId: shop.value.id,
          id: contact.value.id,
          name: name.value,
          address: address.value,
          mobile: mobile.value,
          email: email.value,
          suppliedItems: suppliedItems.value,
          imageSource: imageSource,
        );
      }
      supplier = await contactRepository.updateSupplier(
        shopId: shop.value.id,
        id: contact.value.id,
        name: name.value,
        address: address.value,
        mobile: mobile.value,
        email: email.value,
        suppliedItems: suppliedItems.value,
      );

      final cc = Get.find<ContactController>();

      await cc.getAllSupplier();

      if (Get.isDialogOpen) {
        Get.back();
        CustomDialog.showStringDialog('Contact updated successfully');
        // Future.delayed(Duration(seconds: 1), () {
        //   Get.back();
        //   Get.back();
        // });
      }
    } catch (e) {
      CustomDialog.showStringDialog(e.toString());
      final cc = Get.find<ContactController>();
      cc.tabIndex.value = 2;

      Get.offAllNamed(ContactRoutes.CONTACTS);
    }
  }
}
