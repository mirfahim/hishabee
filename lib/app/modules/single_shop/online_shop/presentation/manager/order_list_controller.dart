import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/online_order_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/domain/repositories/i_online_shop_repository.dart';

class OrderListController extends GetxController {
  final newOrders = <OnlineOrder>[].obs;
  final filteredNewOrders = <OnlineOrder>[].obs;
  final currentOrders = <OnlineOrder>[].obs;
  final filteredCurrentOrders = <OnlineOrder>[].obs;
  final completedOrders = <OnlineOrder>[].obs;
  final filteredCompletedOrders = <OnlineOrder>[].obs;

  final IOnlineShopRepository _onlineShopRepository;

  OrderListController(this._onlineShopRepository);

  @override
  void onInit() async {
    super.onInit();
  }

  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getNewOrders();
    await getCurrentOrders();
    await getCompletedOrders();
  }

  getNewOrders() async {
    // try {
    final res = await _onlineShopRepository.getAllNewOrder(DataHolder.shopId);
    newOrders.assignAll(res);
    filteredNewOrders.assignAll(res);
    // } catch (e) {
    //   // Fluttertoast.showToast(msg: e.toString());
    // }
  }

  getCurrentOrders() async {
    try {
      final res =
          await _onlineShopRepository.getAllActiveOrder(DataHolder.shopId);
      currentOrders.assignAll(res);
      filteredCurrentOrders.assignAll(res);
    } catch (e) {
      print("T: $e");
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  getCompletedOrders() async {
    try {
      final res =
          await _onlineShopRepository.getAllCompletedOrder(DataHolder.shopId);
      completedOrders.assignAll(res);
      filteredCompletedOrders.assignAll(res);
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  searchNewOrders(String keyword) {
    if (keyword.isEmpty) {
      filteredNewOrders.assignAll(newOrders);
    } else {
      final result = newOrders
          .where(
            (order) => order.paymentStatus
                .toLowerCase()
                .contains(keyword.toLowerCase()),
          )
          .toList();
      filteredNewOrders.assignAll(result);
    }
  }

  searchCurrentOrders(String keyword) {
    if (keyword.isEmpty) {
      filteredCurrentOrders.assignAll(currentOrders);
    } else {
      final result = currentOrders
          .where((order) =>
              order.paymentStatus.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
      filteredCurrentOrders.assignAll(result);
    }
  }

  searchCompletedOrders(String keyword) {
    if (keyword.isEmpty) {
      filteredCompletedOrders.assignAll(completedOrders);
    } else {
      final result = completedOrders
          .where((order) =>
              order.paymentStatus.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
      filteredCompletedOrders.assignAll(result);
    }
  }

  updateStatus(int orderId, String deliveryStatus) async {
    CustomDialog.showLoadingDialog();
    final res = await _onlineShopRepository.onlineShopUpdateOrderStatus(
        DataHolder.shopId, orderId, deliveryStatus);

    await getNewOrders();
    await getCurrentOrders();
    await getCompletedOrders();
    CustomDialog.hideDialog();

    Get.defaultDialog(content: Text(res.message));
  }
}
