import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/add_qr_code_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_qr_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_payment_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/confirm_payment_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/sold_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/domain/repositories/i_transaction_repository.dart';
import 'package:image_picker/image_picker.dart';

class SellWithQrCodeController extends GetxController
    with StateMixin<List<Qrcode>> {
  final IFileRepository fileRepository;
  final IQrRepository qrRepository;
  final ITransactionRepository transactionRepository;
  final shop = Rxn<Shop>();
  final transaction = Rxn<Transaction>();
  final picker = ImagePicker();
  final file = Rxn<File>();

  SellWithQrCodeController(
      this.fileRepository, this.qrRepository, this.transactionRepository);

  @override
  void onInit() {
    getArguments();
    append(() => getAllQrCode);
    super.onInit();
  }

  getArguments() {
    shop.value = Get.arguments["shop"];
    transaction.value = Get.arguments["transaction"];
  }

  Future<List<Qrcode>> getAllQrCode() {
    return qrRepository.getAllQrCode(shopId: shop.value.id);
  }

  Future<void> uploadQrCode(int shopId, File file, String type) async {
    final response = await fileRepository.uploadFile(file: file, type: type);
    if (response != null) {
      await qrRepository.addQrCode(
          shopId: shopId, imageSrc: response, type: type);
    }
  }

  Future getImageFromCamera(int option) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final qrFile = File(pickedFile.path);
        uploadQrCode(
          shop.value.id,
          qrFile,
          "paymentQR" + option.toString(),
        );
      } else {
        print('No image selected.');
      }
      Get.back();
    } catch (e) {}
  }

  Future getImageFromGallery(int option) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final qrFile = File(pickedFile.path);
        uploadQrCode(
          shop.value.id,
          qrFile,
          "paymentQR" + option.toString(),
        );
        /*imageFileList.value[option] = File(pickedFile.path);
        Utility.saveImageToPreferences(
          "paymentQR" + option.toString(),
          Utility.base64String(imageFileList.value[option].readAsBytesSync()),
        );
        key.value = "paymentQR" + option.toString();*/
      } else {
        print('No image selected.');
      }
      Get.back();
    } catch (e) {}
  }

  sellByQrCode() {
    Get.dialog(
      CupertinoAlertDialog(
        content: Text("please_confirm".tr),
        actions: <Widget>[
          TextButton(
            child: Text(
              'close'.tr,
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
            onPressed: () {
              navigator.pop();
            },
          ),
          TextButton(
            child: Text(
              'confirm'.tr,
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
            onPressed: () async {
              CustomDialog.showLoadingDialog(message: "Selling...");
              await transactionRepository.addTransaction(
                  shop.value.id, transaction.value);
              final SellController sc = Get.find();
              sc.cart.clear();
              sc.calculateTotalCartPrice();
              if (Get.isDialogOpen) {
                Get.back();
              }
              Get.to(() => SoldPage(
                    transaction: transaction.value,
                    shop: shop.value,
                    route: 2,
                  ));
            },
          ),
        ],
      ),
    );
  }
}
