import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/_navigation/contact_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/contact_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/supplier_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_contact_repository.dart';

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

  editEmployee() async {
    CustomDialog.showLoadingDialog();
    String imageSource;
    Employee employee;
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
      }else{
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
    } catch (e) {
      CustomDialog.showStringDialog(e.toString());
      final cc = Get.find<ContactController>();
      cc.tabIndex.value = 0;

      // Get.back();
    }
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
