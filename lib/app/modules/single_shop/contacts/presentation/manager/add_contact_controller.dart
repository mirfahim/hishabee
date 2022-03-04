import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/_navigation/contact_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/supplier_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_contact_repository.dart';

import 'contact_controller.dart';

class AddContactsController extends GetxController {
  final name = "".obs;
  final position = "".obs;
  final employeeId = ''.obs;
  final email = "".obs;
  final address = "".obs;
  final mobile = "".obs;
  final salary = 0.obs;
  final suppliedItems = "".obs;
  final image = Rxn<File>();

  final contactType = ''.obs;
  final shop = Rxn<Shop>();

  final loading = false.obs;

  AddContactsController(this.contactRepository, this.fileRepository);

  final IContactRepository contactRepository;

  final IFileRepository fileRepository;

  @override
  onInit() {
    getArguments();
    super.onInit();
  }

  getArguments() {
    shop.value = Get.arguments["shop"];
    contactType.value = Get.arguments["type"];
  }

  addNewEmployee() async {
    String imageSource;
    Employee employee;

    CustomDialog.showLoadingDialog(message: "Adding employee");
    try {
      if (image.value != null) {
        imageSource = await fileRepository.uploadFile(
            file: image.value, type: contactType.value);
        String imageUrl = imageSource
            .replaceAll("\\", "")
            .replaceAll('"', "")
            .replaceAll("{", "")
            .replaceAll("}", "")
            .replaceAllMapped('url:', (match) => "");
        employee = await contactRepository.addNewEmployee(
          name: name.value,
          shopId: shop.value.id,
          address: address.value,
          mobile: mobile.value,
          email: email.value,
          employeeId: employeeId.value,
          position: position.value,
          monthlySalary: salary.value,
          imageSource: imageUrl,
        );
      }
      employee = await contactRepository.addNewEmployee(
          name: name.value,
          shopId: shop.value.id,
          address: address.value,
          mobile: mobile.value,
          email: email.value,
          employeeId: employeeId.value,
          position: position.value,
          monthlySalary: salary.value);

      final cc = Get.find<ContactController>();

      cc.employeeList.add(employee);

      if (Get.isDialogOpen) {
        Get.back();
        CustomDialog.showStringDialog('Contact added successfully');
        Future.delayed(Duration(seconds: 1), () {
          Get.back();
          Get.back();
        });
      }
    } catch (e) {
      CustomDialog.showStringDialog(e);
      final cc = Get.find<ContactController>();
      cc.tabIndex.value = 0;

      await cc.getAllCustomer();
      Get.offAllNamed(ContactRoutes.CONTACTS);
    }
  }

  addNewCustomer() async {
    String imageSource;
    Customer customer;

    CustomDialog.showLoadingDialog(message: "Adding customer");

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
        customer = await contactRepository.addNewCustomer(
          name: name.value,
          email: email.value,
          mobile: mobile.value,
          address: address.value,
          shopId: shop.value.id,
          imageSource: imageUrl,
        );
      // }

      // customer = await contactRepository.addNewCustomer(
      //     name: name.value,
      //     email: email.value,
      //     mobile: mobile.value,
      //     address: address.value,
      //     shopId: shop.value.id);

      final cc = Get.find<ContactController>();

      cc.customerList.add(customer);

      if (Get.isDialogOpen) {
        Get.back();
        CustomDialog.showStringDialog('Contact added successfully');
        Future.delayed(Duration(seconds: 1), () {
          Get.back();
          Get.back();
        });
      }
    }
    // catch (e) {
    //   CustomDialog.showStringDialog(e);
    //   final cc = Get.find<ContactController>();
    //   cc.tabIndex.value = 1;
    //
    //   await cc.getAllCustomer();
    //   Get.offAllNamed(ContactRoutes.CONTACTS);
    // }
  }

  addNewSupplier() async {
    String imageSource;
    Supplier supplier;

    CustomDialog.showLoadingDialog(message: "Adding employee");

    try {
      if (image.value != null) {
        imageSource = await fileRepository.uploadFile(
            file: image.value, type: contactType.value);
        supplier = await contactRepository.addNewSupplier(
          name: name.value,
          shopId: shop.value.id,
          address: address.value,
          mobile: mobile.value,
          email: email.value,
          suppliedItems: suppliedItems.value,
          imageSource: imageSource,
        );
      }
      supplier = await contactRepository.addNewSupplier(
          name: name.value,
          shopId: shop.value.id,
          address: address.value,
          mobile: mobile.value,
          email: email.value,
          suppliedItems: suppliedItems.value);

      final cc = Get.find<ContactController>();

      cc.supplierList.add(supplier);

      if (Get.isDialogOpen) {
        Get.back();
        CustomDialog.showStringDialog('Contact added successfully');
        Future.delayed(Duration(seconds: 1), () {
          Get.back();
          Get.back();
        });
      }
    } catch (e) {
      CustomDialog.showStringDialog(e);
      final cc = Get.find<ContactController>();
      cc.tabIndex.value = 2;

      await cc.getAllCustomer();
      Get.offAllNamed(ContactRoutes.CONTACTS);
    }
  }
}
