import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/online_order_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/order_status.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/domain/repositories/i_online_shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/order_list_controller.dart';

class OrderDetailsController extends GetxController {
  final order = OnlineOrder().obs;

  final IOnlineShopRepository _onlineShopRepository;

  OrderDetailsController(this._onlineShopRepository);

  @override
  void onInit() {
    getArguments();
    super.onInit();
  }

  getArguments() {
    order.value = Get.arguments["order"];
  }

  accept() async {
    CustomDialog.showLoadingDialog();

    final res = await _onlineShopRepository.onlineShopUpdateOrderStatus(
        DataHolder.shopId, order.value.id, OrderStatus.ORDER_ACCEPTED);
    CustomDialog.hideDialog();

    final OrderListController orderListController = Get.find();

    orderListController.newOrders[orderListController.newOrders
        .indexWhere((element) => element.id == res.order.id)] = res.order;
    orderListController.filteredNewOrders
        .assignAll(orderListController.newOrders);
    print("AC: ${res.message}");
    Get.back();
  }

  reject() async {
    CustomDialog.showLoadingDialog();

    final res = await _onlineShopRepository.onlineShopUpdateOrderStatus(
        DataHolder.shopId, order.value.id, OrderStatus.ORDER_CANCELED);
    CustomDialog.hideDialog();

    final OrderListController orderListController = Get.find();

    orderListController.newOrders[orderListController.newOrders
        .indexWhere((element) => element.id == res.order.id)] = res.order;
    orderListController.filteredNewOrders
        .assignAll(orderListController.newOrders);

    Get.back();
  }
}
