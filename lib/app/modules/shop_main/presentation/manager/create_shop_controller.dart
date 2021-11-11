import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hishabee_business_manager_fl/app/_utils/analytics_event.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_workmanager/analytics_service.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/area_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/create_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_shop_all_type_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_area_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_shop_repository.dart';

import 'select_shop_controller.dart';

class CreateShopController extends GetxController {
  final shopName = ''.obs;
  final shopTypes = <ShopType>[].obs;
  final selectedShopType = ShopType().obs;
  final selectedDivision = Division().obs;
  final selectedDistrict = District().obs;
  final selectedArea = Area().obs;
  final divisions = <Division>[].obs;
  final divisionSearch = <Division>[].obs;
  final districtSearch = <District>[].obs;
  final areaSearch = <Area>[].obs;
  final image = Rxn<File>();
  final address = ''.obs;
  final referralCode = ''.obs;
  final createdShopResponse = CreateShopResponseModel().obs;
  //final selectedPlace = PickResult().obs;

  final initialPosition = LatLng(23.8103, 90.4125);

  final IShopRepository _shopRepository;
  final IAreaRepository _areaRepository;
  final IFileRepository _fileRepository;

  CreateShopController(
      this._shopRepository, this._areaRepository, this._fileRepository);

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await AnalyticsService.sendAnalytics(
        event: AnalyticsEvent.storeCreationStarted);
    await getAllShopTypes();
    await getAllArea();
  }

  getAllShopTypes() async {
    final response = await _shopRepository.getAllShopType();
    shopTypes.assignAll(response);
  }

  getAllArea() async {
    final response = await _areaRepository.getAllArea();
    divisions.assignAll(response);
    divisionSearch.assignAll(response);
  }

  Future<void> createShop() async {
    if (image.value != null) {
      CustomDialog.showLoadingDialog(message: 'Uploading file...');
      final logoUrl =
          await _fileRepository.uploadFile(file: image.value, type: 'shop');
      CustomDialog.hideDialog();
      CustomDialog.showLoadingDialog(message: 'Creating shop...');

      try {
        createdShopResponse.value = await _shopRepository.createShop(
          name: shopName.value,
          typeId: selectedShopType.value.id,
          areaId: selectedArea.value.id,
          address: address.value,
          referralCode: referralCode.value,
          logoUrl: logoUrl,
        );
      } catch (e) {
        CustomDialog.showStringDialog('An error occurred!');
      }

      CustomDialog.hideDialog();
    } else {
      try {
        CustomDialog.showLoadingDialog(message: 'Creating shop...');

        createdShopResponse.value = await _shopRepository.createShop(
          name: shopName.value,
          typeId: selectedShopType.value.id,
          areaId: selectedArea.value.id,
          address: address.value,
          referralCode: referralCode.value,
        );
      } catch (e) {
        CustomDialog.showStringDialog('An error occurred!');
      }
      CustomDialog.hideDialog();

      if (createdShopResponse.value.code == 200) {
        await AnalyticsService.sendAnalytics(
            event: AnalyticsEvent.storeCreationCompleted);
        final SelectShopController selectShopController = Get.find();
        await selectShopController.reload();

        Get.back();
        Get.snackbar('Success', 'Shop created successfully',
            backgroundColor: Colors.green);
      } else {
        Get.snackbar('Error', '${createdShopResponse.value.message}',
            backgroundColor: Colors.red);
      }
    }
  }
}
