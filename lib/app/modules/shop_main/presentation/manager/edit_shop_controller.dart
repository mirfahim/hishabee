import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/area_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/edit_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_shop_all_type_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_area_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/manager/manage_shop_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/manager/select_shop_controller.dart';

class EditShopController extends GetxController {
  final shop = Shop().obs;

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
  final address = ''.obs;
  final publicNumber = ''.obs;
  final shopNumber = 0.obs;
  final floorNumber = 0.obs;
  final referralCode = ''.obs;
  final vatPercent = 0.obs;

  final image = File('').obs;

  final editShopResponse = EditShopResponseModel().obs;

  //final selectedPlace = PickResult().obs;

  final initialPosition = LatLng(23.8103, 90.4125);

  final IShopRepository _shopRepository;
  final IAreaRepository _areaRepository;
  final IFileRepository _fileRepository;

  EditShopController(
      this._shopRepository, this._areaRepository, this._fileRepository);

  @override
  void onInit() async {
    getArguments();

    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getAllShopType();
    await getAllArea();

    getSelectedShopType(shop.value.type);

    getSelectedArea(shop.value.area);
  }

  getArguments() {
    shop.value = Get.arguments["shop"];
  }

  getAllShopType() async {
    final response = await _shopRepository.getAllShopType();

    shopTypes.assignAll(response);
  }

  getAllArea() async {
    final response = await _areaRepository.getAllArea();

    divisions.assignAll(response);
    divisionSearch.assignAll(response);
  }

  editShop() async {
    String logoUrl;
    if (image.value.path != '') {
      CustomDialog.showLoadingDialog(message: 'Uploading file...');
      logoUrl =
          await _fileRepository.uploadFile(file: image.value, type: 'shop');

      CustomDialog.hideDialog();
    }

    CustomDialog.showLoadingDialog(message: 'Updating shop...');

    if (logoUrl != null) {
      editShopResponse.value = await _shopRepository.editShop(
        shopId: shop.value.id,
        name: shopName.value,
        typeId: selectedShopType.value.id,
        address: address.value,
        id: shop.value.userId,
        lat: shop.value.lat,
        lng: shop.value.lng,
        shopNumber: shopNumber.value,
        floorNumber: floorNumber.value,
        vatPercent: vatPercent.value,
        areaId: selectedArea.value.id,
        logoUrl: logoUrl,
        publicNumber: publicNumber.value,
        referralCode: referralCode.value,
      );
    } else {
      editShopResponse.value = await _shopRepository.editShop(
        shopId: shop.value.id,
        name: shopName.value,
        typeId: selectedShopType.value.id,
        address: address.value,
        id: shop.value.userId,
        lat: shop.value.lat,
        lng: shop.value.lng,
        shopNumber: shopNumber.value,
        floorNumber: floorNumber.value,
        vatPercent: vatPercent.value,
        areaId: selectedArea.value.id,
        publicNumber: publicNumber.value,
        referralCode: referralCode.value,
      );
    }
    CustomDialog.hideDialog();
    if (editShopResponse.value.code == 200) {
      final ManageShopController manageShopController = Get.find();
      final SelectShopController selectShopController = Get.find();
      await manageShopController.getAllShop();
      await selectShopController.reload();

      Get.back();
      Get.snackbar('Success', 'Shop updated successfully',
          backgroundColor: Colors.green);
    } else {
      Get.snackbar('Error', editShopResponse.value.message,
          backgroundColor: Colors.red);
    }
  }

  getSelectedShopType(int typeId) {
    if (selectedShopType.value.name == null) {
      for (ShopType type in shopTypes) {
        if (type.id == typeId) {
          selectedShopType.value = type;
          break;
        }
      }
    }
  }

  getSelectedArea(int areaId) {
    for (Division division in divisions) {
      for (District district in division.districts) {
        for (Area area in district.areas) {
          if (area.id == areaId) {
            selectedDivision.value = division;
            selectedDistrict.value = district;
            selectedArea.value = area;

            break;
          }
        }
      }
    }
  }
}
