import 'package:darq/darq.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/analytics_event.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_utils/help_button_box.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/overlay_youtube_video.dart';
import 'package:hishabee_business_manager_fl/app/_workmanager/analytics_service.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/add_transaction_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/new_transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/domain/repositories/i_transaction_repository.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class TransactionController extends GetxController {
  final ITransactionRepository transactionRepository;

  TransactionController(this.transactionRepository);

  final shop = Rxn<Shop>();

  final transactionList = TransactionResponse().obs;

  /* final todayTransactionList = <Transaction>[].obs;
  final yesterdayTransactionList = <Transaction>[].obs;
  final sevenDayTransactionList = <Transaction>[].obs;*/
  final transactionItemList = <TransactionItem>[].obs;
  final filterTransactionList = <Transactions>[].obs;

  final selectedStartDate = DateTime.now().obs;
  final selectedEndDate = DateTime.now().obs;

  final totalAmount = 0.0.obs;
  final totalPage = 0.obs;
  final showCase = true.obs;
  final showCaseTap = Rxn<bool>();

  @override

  void onInit() async {
    getArguments();
    getBox();
    // AnalyticsService.sendAnalyticsToServer(
    //     event: AnalyticsEvent.transactionList);
    // Future.delayed(const Duration(seconds: 5), () {
    //   showCase.value = false;
    // });

    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  getBox() async {
    showCaseTap.value = await HelpButton.getBox(ButtonKey.tranKey);
  }

  initData() async {
    await getAllTransaction();
    await getAllTransactionItem();
    getToDayTransaction();
  }

  getArguments() {
    shop.value = Get.arguments["shop"];
  }

  Future<dynamic> getALlTransactionItemByUniqueID({
    String uniqueID,
  }) async {
    String url = "/transaction/items?unique_id=$uniqueID";
    ApiService _apiService = ApiService();
    return _apiService.makeApiRequest(
        method: apiMethods.get,
        url: url,
        body: null,
        headers: null); //we will fetch the overview from this request
  }

  getAllTransaction() async {
    try {
      final result =
          await transactionRepository.getAllTransaction(shopId: shop.value.id);
      transactionList.value = result;
      totalPage.value = result.lastPage;
      print("my all transaction are ${result.total}");
      print("my shop id is ${shop.value.id}");
    } catch (e) {
      CustomDialog.showStringDialog(e.toString());
    }
  }

  getAllTransactionItem() async {
    print("step 111");
    try {
      final result = await transactionRepository.getAllTransactionItem(
          shopId: shop.value.id);
      print("my all transactions items are $result");
      final res = result.orderByDescending((element) => element.createdAt);
      transactionItemList.assignAll(res);
      print("my all transaction items are $res");
    } catch (e) {
      print("not working");
      // CustomDialog.showStringDialog("No Data Found");
    }
  }

  getSevenDayTransaction() {
    try {
      final result = transactionList.value.data.where((element) {
        if (element.createdAt != null) {
          return Utility.isThisWeek(element.createdAt);
        }
        return false;
      }).toList();
      final res = result.orderByDescending(
          (element) => element.createdAt.microsecondsSinceEpoch);

      filterTransactionList.assignAll(res);
      calculateTotalAmount(result);
    } catch (e) {
      CustomDialog.showStringDialog(e.toString());
    }
  }

  getToDayTransaction() {
    final result = transactionList.value.data.where((element) {
      if (element.createdAt != null) {
        return Utility.isToday(element.createdAt);
      }
      return false;
    }).toList();
    final res = result.orderByDescending(
        (element) => element.createdAt.microsecondsSinceEpoch);

    filterTransactionList.assignAll(res);

    calculateTotalAmount(filterTransactionList);
  }

  getYesterdayTransaction() {
    final result = transactionList.value.data.where((element) {
      if (element.shopId != null) {
        return Utility.isYesterDay(element.createdAt);
      }
      return false;
    }).toList();
    final res = result.orderByDescending(
        (element) => element.createdAt.microsecondsSinceEpoch);

    filterTransactionList.assignAll(res);

    calculateTotalAmount(result);
  }

  getMonthTransaction() {
    final result = transactionList.value.data.where((element) {
      if (element.createdAt != null) {
        return Utility.isThisMonth(element.createdAt);
      }
      return false;
    }).toList();
    final res = result.orderByDescending(
        (element) => element.createdAt.microsecondsSinceEpoch);

    filterTransactionList.assignAll(res);

    calculateTotalAmount(result);
  }

  calculateTotalAmount(List<Transactions> trans) {
    var temp = 0.0;
    trans.forEach((element) {
      temp += element.totalPrice;
    });
    totalAmount.value = temp;
  }

  getRangeTransaction() {
    final result = transactionList.value.data.where((element) {
      if (element.createdAt != null) {
        return Utility.isInRange(
            selectedStartDate.value, selectedEndDate.value, element.createdAt);
      }
      return false;
    }).toList();

    final res = result.orderByDescending(
        (element) => element.createdAt.microsecondsSinceEpoch);

    filterTransactionList.assignAll(res);

    calculateTotalAmount(result);
  }

  openTrainingVideo(BuildContext context) {
    final String url =
        "https://www.youtube.com/watch?v=5jQkPthCE28&list=PLO7C_xRyL47emWQfUcp2-djjzgdlPGcqS&index=11";
    final String title = "transaction_page_showcase".tr;
    HelpButton.setBox(ButtonKey.tranKey);
    Navigator.of(context).push(TutorialOverlay(url, title));
  }
}
