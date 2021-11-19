import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_utils/package_nane.dart';
import 'package:hishabee_business_manager_fl/app/_utils/shop_item_card.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/_navigation/settings_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/calculator/views/pages/calculator_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/_navigation/contact_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/_bindings/due_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/pages/due_list_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/_bindings/expense_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/presentation/pages/expenses_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/marketing_shop/_binding/marketing_shop_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/marketing_shop/presentation/pages/marketing_shop_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/_navigation/notification_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/_bindings/store_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/pages/store_dashboard.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/_bindings/product_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/pages/product_list_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/report/_navigation/report_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_bindings/sell_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/sell_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sms_service/_bindings/sms_bindings.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sms_service/_navigation/sms_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sms_service/presentation/pages/sms_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/_bindings/transactions_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/pages/transactions_page.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/emi/emi.dart';

class AdvanceItemsList extends GetResponsiveView<ShopFeaturesController> {
  final Shop shop;

  AdvanceItemsList({
    this.shop,
  });

  @override
  Widget builder() {
    Size size = MediaQuery.of(screen.context).size;
    final double itemHeight = size.height * 0.13;
    final double itemWidth = size.width * 0.44;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, top: 5),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => ProductListPage(),
                        arguments: {
                          "shop": shop,
                        },
                        binding: ProductListBinding());
                  },
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/shop_features/productList.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "product_list".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => SellPageShowcase(),
                        arguments: {
                          "shop": shop,
                        },
                        binding: SellBinding());
                  },
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/shop_features/sell.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            "sell_pos".tr,
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: itemHeight * 0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(
                      () => TransactionPage(),
                      arguments: {
                        "shop": shop,
                      },
                      binding: TransactionsBinding(),
                    );
                  },
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/shop_features/transcation.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "transaction_exchange_amp_refund".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                InkWell(
                  onTap: () async {
                    if (shop.package == PackageName.standard) {
                      CustomDialog.showStringDialog(
                          "Please upgrade your package");
                    } else {
                      if (await controller.networkInfo.isConnected()) {
                        Get.to(
                          () => StoreDashBoard(),
                          arguments: {
                            "shop": shop,
                          },
                          binding: StoreBinding(),
                        );
                      } else {
                        CustomDialog.showStringDialog(
                            "Please connect to the internet");
                      }
                    }
                  },
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/shop_features/onlineOrders.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "online_orders".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: itemHeight * 0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => DueListPage(),
                        arguments: {
                          "shop": shop,
                        },
                        binding: DueListBinding());
                  },
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/shop_features/duelist.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "dueList".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                        () => ExpensesPage(
                              shop: shop,
                            ),
                        arguments: {
                          "shop": shop,
                        },
                        binding: ExpenseBinding());
                  },
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/shop_features/expenses.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "expenses".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: itemHeight * 0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(
                      ReportRoutes.REPORT,
                      arguments: {
                        "shop": shop,
                      },
                    );
                  },
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/shop_features/report.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "reports".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(
                      ContactRoutes.CONTACTS,
                      arguments: {
                        "shop": shop,
                      },
                    );
                  },
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/shop_features/contacts.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "contact".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: itemHeight * 0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(
                      NotificationRoutes.NOTIFICATION,
                      arguments: {
                        "shop": shop,
                      },
                    );
                  },
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/shop_features/notifications.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "notification".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: screen.context,
                        builder: (BuildContext context) {
                          return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.75,
                              child: CalcButton());
                        });
                  },
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/shop_features/calculator.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "calculator".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: itemHeight * 0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(
                      () => MarketingShopPage(),
                      arguments: {
                        "shop": shop,
                      },
                      binding: MarketingShopBinding(),
                    );
                  },
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //need update Icon
                        Image.asset(
                          'images/shop_features/onlineOrders.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "hishabee_marketing".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(
                      SettingsRoutes.SETTINGS,
                      arguments: {
                        "shop": shop,
                      },
                    );
                  },
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/shop_features/settings.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "app_setting".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(
                      () => SmsPage(),
                      arguments: {
                        "shop": shop,
                      },
                      binding: SMSBindings(),
                    );
                  },
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/shop_features/settings.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "sms_marketing".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(EMI(), arguments: shop);
                    // Get.to(
                    //   () => SmsPage(),
                    //   arguments: {
                    //     "shop": shop,
                    //   },
                    //   binding: SMSBindings(),
                    // );
                  },
                  child: Container(
                    height: itemHeight,
                    width: itemWidth,
                    decoration: SHOP_ITEM_DECORATION,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/shop_features/emi.png',
                          height:
                              screen.responsiveValue(mobile: 40, tablet: 60),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "emi".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
