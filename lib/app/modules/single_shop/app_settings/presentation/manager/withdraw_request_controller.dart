import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/account_information_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_account_information_repository.dart';

class WithdrawRequestController extends GetxController {
  final IAccountInformationRepository accountInformationRepository;

  WithdrawRequestController(this.accountInformationRepository);

  final shop = Rxn<Shop>();
  final accountInfo = Rxn<AccountInformationResponseModel>();
  final accountType = 'BKASH'.obs;
  final bKash = ''.obs;
  final accountName = ''.obs;
  final accountNumber = ''.obs;
  final bankName = ''.obs;
  final bankRoutingNumber = ''.obs;
  var bKashFormKey = new GlobalKey<FormState>();
  var bankFormKey = new GlobalKey<FormState>();

  onInit() async {
    getArguments();
    await getAccount();
    super.onInit();
  }

  getArguments() {
    shop.value = Get.arguments["shop"];
  }

  Future<GenericResponseModel> saveAccountInfo() async {
    CustomDialog.showLoadingDialog(message: "Saving Account information");
    final response = await accountInformationRepository.saveAccountInformation(
        shopId: shop.value.id,
        accountType: accountType.value,
        bKash: bKash.value,
        accountName: accountName.value,
        accountNumber: accountNumber.value,
        bankName: bankName.value,
        bankRoutingNumber: bankRoutingNumber.value);
    await getAccount();
    CustomDialog.hideDialog();
    return response;
  }

  Future getAccount() async {
    final response = await accountInformationRepository.getAccountInformation();
    accountInfo.value = response;
  }
}
