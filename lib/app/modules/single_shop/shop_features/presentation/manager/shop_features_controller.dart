import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/_bindings/app_settings_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/pages/web_view_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/domain/repositories/i_transaction_repository.dart';

class ShopFeaturesController extends GetxController {
  final shop = Shop().obs;
  final campaign = Rxn<Campaign>();
  final transactionList = <Transactions>[].obs;
  var smsCount = GetStorage('sms_count');
  var tabIndex = 1;
  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  final filterTransactionList = <Transactions>[].obs;

  final todaysSale = 0.0.obs;
  final walletBalance = 0.obs;
  var getShopId = GetStorage('shop_id');
  final IShopRepository shopRepository;

  final IProductRepository productRepository;

  final ITransactionRepository transactionRepository;
  final INetworkInfo networkInfo;
  final IAuthRepository authRepository;

  ShopFeaturesController(this.productRepository, this.transactionRepository,
      this.shopRepository, this.networkInfo, this.authRepository);

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getCurrentShop();
    await checkShopSubscription();
    await getAllTransaction();
    getToDayTransaction();
    await updateFcmToken();
  }

  Future<void> updateFcmToken() async {
    String token = await FirebaseMessaging.instance.getToken();

    print("FCM: $token");

    final response = await authRepository.updateFcmToken(fcmToken: token);
  }

  getCurrentShop() async {
    shop.value = await shopRepository.getCurrentShop();
    DataHolder.shopId = shop.value.id;
    getShopId.write('shop_id',shop.value.id);
    walletBalance.value = shop.value.walletBalance.toInt();
  }

  getAllTransaction() async {
    final result = await transactionRepository.getAllTransaction(
        shopId: DataHolder.shopId);

    transactionList.assignAll(result.data);
  }

  getToDayTransaction() {
    final result = transactionList.where((element) {
      if (element.createdAt != null) {
        return Utility.isToday(element.createdAt);
      }
      return false;
    }).toList();
    filterTransactionList.assignAll(result);

    calculateTotalAmount(filterTransactionList);
  }

  calculateTotalAmount(List<Transactions> trans) {
    var temp = 0.0;
    trans.forEach((element) {
      temp += element.totalPrice;
    });
    todaysSale.value = temp;
  }

  checkShopSubscription() async {
    try {
      final result =
          await shopRepository.checkShopSubscription(shopId: shop.value.id);
      var dateTime = await shopRepository.getCampaignDate();
      var now = DateTime.now();
      if (result.code == 200) {
        campaign.value = result.shop.campaign;
        // smsCount.write('sms_count', result.shop.smsCount);
        if (campaign.value != null) {
          if (dateTime == null) {
            campaignDialog();
          } else if (now.difference(dateTime).inDays > 0) {
            campaignDialog();
          }
        }
      }
    } catch (e) {
      print(" catch $e");
    }
  }

  campaignDialog() {
    var height = Get.size.height * 0.47;
    var width = Get.size.width;

    var now = DateTime.now();

    var todayMidnight = DateTime(now.year, now.month, now.day, 23, 59);
    Get.defaultDialog(
        radius: 4,
        title: "",
        content: Container(
            height: height,
            width: width,
            child: Column(
              children: [
                Container(
                  height: height * 0.5,
                  width: width,
                  child: Image.network(
                    "${campaign.value.image}",
                    fit: BoxFit.cover,
                  ),
                ),
                CountdownTimer(
                  endTime: todayMidnight.millisecondsSinceEpoch,
                  widgetBuilder: (_, CurrentRemainingTime time) {
                    if (time == null) {
                      return Text('');
                    }
                    return Text(
                      '${time.days == null ? 00 : time.days} : ${time.hours == null ? 0 : time.hours} : ${time.min} : ${time.sec}',
                      style: TextStyle(
                          color: DEFAULT_BLACK,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Hurry up and grab this offer",
                  style: TextStyle(
                      color: DEFAULT_BLACK,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "before the time runs out!",
                  style: TextStyle(
                      color: DEFAULT_BLACK,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () async {
                      await shopRepository.setCampaignDate().then((value) {
                        Get.to(
                            () => WebViewPage(
                                  viewUrl: "${campaign.value.paymentUrl}",
                                ),
                            binding: AppSettingsBinding());
                      });
                    },
                    child: Container(
                      height: 40,
                      width: width,
                      decoration: BoxDecoration(
                        color: DEFAULT_BLACK,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            "claim_the_offer".tr,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
