import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_area_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/online_shop_info_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/domain/repositories/i_online_shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/store_dashboard_controller.dart';

class OnlineStoreSettingController extends GetxController {
  final storePublished = false.obs;
  final logo = Rxn<File>();
  final bannerUrl = Rxn<String>();
  final storeLink = Rxn<String>();
  final fb = Rxn<String>();
  final ig = Rxn<String>();
  final yt = Rxn<String>();
  final areaName = Rxn<String>();
  final shopTypeName = Rxn<String>();
  final bannerList =
      <File>[].obs; // picked file should be added by bannerList.add(picked)
  final selectedBannerList = <File>[]
      .obs; // selected file should be added by selectedBannerList.add(picked)
  final sampleBannerUrlList = <String>[].obs;
  final onlineShopInfoResponse = OnlineShopInfoResponseModel().obs;

  final IOnlineShopRepository _onlineShopRepository;
  final IFileRepository _fileRepository;
  final IAreaRepository _areaRepository;
  final IShopRepository _shopRepository;

  OnlineStoreSettingController(this._onlineShopRepository, this._fileRepository,
      this._areaRepository, this._shopRepository);

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
    await getArea();
    await getShopType();
    await getAllSampleBanners();
  }

  getArguments() {
    onlineShopInfoResponse.value = Get.arguments["onlineShopInfoResponse"];
  }

  getArea() async {
    final res = await _areaRepository.getAllArea();

    res.forEach((element) {
      element.districts.forEach((el) {
        el.areas.forEach((e) {
          if (e.id == onlineShopInfoResponse.value.shop.area) {
            areaName.value = element.name;
          }
        });
      });
    });
  }

  getShopType() async {
    final res = await _shopRepository.getAllShopType();

    res.forEach((element) {
      if (element.id == onlineShopInfoResponse.value.shop.type) {
        shopTypeName.value = element.name;
      }
    });
  }

  getAllSampleBanners() async {
    final result = await _onlineShopRepository.getAllSampleBanner();
    print(result);

    sampleBannerUrlList.assignAll(result);
  }

  storePublishToggle() async {
    if (onlineShopInfoResponse.value.shop.public != storePublished.value) {
      CustomDialog.showLoadingDialog();

      final res = await _onlineShopRepository
          .onlineShopPublishToggle(DataHolder.shopId);
      CustomDialog.hideDialog();

      if (res.code == 200) {
        onlineShopInfoResponse.value = res;
        Get.find<OnlineStoreDashboardController>()
            .onlineShopInfoResponse
            .value = res;
      } else {
        Get.defaultDialog(title: "Error", content: Text(res.message));
      }
    }
  }

  updateLogo() async {
    if (logo.value != null) {
      CustomDialog.showLoadingDialog();

      final url =
          await _fileRepository.uploadFile(file: logo.value, type: "logo");
      CustomDialog.hideDialog();

      CustomDialog.showLoadingDialog();

      final res = await _onlineShopRepository.onlineShopUpdateLogo(
          DataHolder.shopId, url);
      CustomDialog.hideDialog();

      if (res.code == 200) {
        Get.back();
      } else {
        Get.defaultDialog(title: "Error", content: Text(res.message));
      }
    }
  }

  updateBanner() async {
    final urls = <String>[];
    selectedBannerList.forEach((element) async {
      CustomDialog.showLoadingDialog();

      final url =
          await _fileRepository.uploadFile(file: element, type: "banner");
      CustomDialog.hideDialog();

      urls.add(url);
    });
    CustomDialog.showLoadingDialog();

    final res = await _onlineShopRepository.onlineShopUpdateBanner(
        DataHolder.shopId, urls);
    CustomDialog.hideDialog();

    if (res.code != 200) {
      Get.defaultDialog(title: "Error", content: Text(res.message));
    }
  }

  updateStoreLink() async {
    CustomDialog.showLoadingDialog();

    final res = await _onlineShopRepository.onlineShopUpdateSlug(
        DataHolder.shopId, storeLink.value);
    CustomDialog.hideDialog();

    if (res.code == 200) {
      onlineShopInfoResponse.value = res;

      CustomDialog.showLoadingDialog();
      final resp =
          await _onlineShopRepository.getOnlineShopInfo(DataHolder.shopId);
      CustomDialog.hideDialog();

      Get.back();
    } else {
      Get.defaultDialog(title: "Error", content: Text(res.message));
    }
  }

  updateSocialMediaLinks() async {
    CustomDialog.showLoadingDialog();
    final res = await _onlineShopRepository.onlineShopUpdateSocials(
        DataHolder.shopId,
        fb: fb.value,
        ig: ig.value,
        yt: yt.value);
    CustomDialog.hideDialog();
    if (res.code == 200) {
      onlineShopInfoResponse.value = res;
      Get.back();
    } else {
      Get.defaultDialog(title: "Error", content: Text(res.message));
    }
  }
}
