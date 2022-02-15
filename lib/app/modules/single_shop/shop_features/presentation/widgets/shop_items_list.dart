import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/shop_item_card.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/_navigation/contact_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/_bindings/due_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/pages/due_details_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/pages/due_list_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/_bindings/expense_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/presentation/pages/expenses_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_bindings/sell_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/quick_sell_front.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/sell_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/_bindings/transactions_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/pages/transactions_page.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/expense/expense_front.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/new_pages/updated_UI/due_details_customer.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/new_pages/updated_UI/due_front.dart';

class ShopItemsList extends GetResponsiveView<ShopFeaturesController> {
  final Shop shop;

  ShopItemsList({
    this.shop,
  });

  @override
  Widget builder() {
    Size size = MediaQuery.of(screen.context).size;
    final double itemHeight = size.height * 0.13;
    final double itemWidth = size.width * 0.44;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, top: 5,left: 20, right: 20),
      child: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // InkWell(
                //   onTap: () {
                //     Get.to(() => ProductListPage(),
                //         arguments: {
                //           "shop": shop,
                //         },
                //         binding: ProductListBinding());
                //   },
                //   child: Container(
                //     height: itemHeight,
                //     width: itemWidth,
                //     decoration: SHOP_ITEM_DECORATION,
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Image.asset(
                //           'images/shop_features/productList.png',
                //           height:
                //               screen.responsiveValue(mobile: 40, tablet: 60),
                //         ),
                //         SizedBox(
                //           height: 10,
                //         ),
                //         Text(
                //           "product_list".tr,
                //           style: TextStyle(
                //             fontFamily: 'Rubik',
                //             fontSize: 16,
                //             fontWeight: FontWeight.normal,
                //             color: DEFAULT_BLACK,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Expanded(
                  child: InkWell(
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
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => QuickSell(),
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
                          Text(
                            "sell_pos".tr,
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
                ),
              ],
            ),
            SizedBox(
              height: itemHeight * 0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => DueFront());
                          // arguments: {
                          //   "shop": shop,
                          // },
                          // binding: DueListBinding());
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
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.to(
                          () => ExpenseList(
                                // shop: shop,
                              ),
                          arguments:
                          // {
                          //   "shop":
                          shop,
                          // },
                          // binding: ExpenseBinding()
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
                  ),
                )
              ],
            ),
            SizedBox(
              height: itemHeight * 0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SizedBox(
                //   width: size.width * 0.03,
                // ),
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
                // InkWell(
                //   onTap: () async {
                //     if (shop.package == PackageName.standard) {
                //       CustomDialog.showStringDialog(
                //           "Please upgrade your package");
                //     } else {
                //       if (await controller.networkInfo.isConnected()) {
                //         Get.to(
                //           () => StoreDashBoard(),
                //           arguments: {
                //             "shop": shop,
                //           },
                //           binding: StoreBinding(),
                //         );
                //       } else {
                //         CustomDialog.showStringDialog(
                //             "Please connect to the internet");
                //       }
                //     }
                //   },
                //   child: Container(
                //     height: itemHeight,
                //     width: itemWidth,
                //     decoration: SHOP_ITEM_DECORATION,
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Image.asset(
                //           'images/shop_features/onlineOrders.png',
                //           height:
                //               screen.responsiveValue(mobile: 40, tablet: 60),
                //         ),
                //         SizedBox(
                //           height: 5,
                //         ),
                //         Text(
                //           "online_orders".tr,
                //           style: TextStyle(
                //             fontFamily: 'Rubik',
                //             fontSize: 16,
                //             fontWeight: FontWeight.normal,
                //             color: DEFAULT_BLACK,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
            SizedBox(
              height: itemHeight * 0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // InkWell(
                //   onTap: () {
                //     Get.toNamed(
                //       ReportRoutes.REPORT,
                //       arguments: {
                //         "shop": shop,
                //       },
                //     );
                //   },
                //   child: Container(
                //     height: itemHeight,
                //     width: itemWidth,
                //     decoration: SHOP_ITEM_DECORATION,
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Image.asset(
                //           'images/shop_features/report.png',
                //           height:
                //               screen.responsiveValue(mobile: 40, tablet: 60),
                //         ),
                //         SizedBox(
                //           height: 10,
                //         ),
                //         Text(
                //           "reports".tr,
                //           style: TextStyle(
                //             fontFamily: 'Rubik',
                //             fontSize: 16,
                //             fontWeight: FontWeight.normal,
                //             color: DEFAULT_BLACK,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: size.width * 0.03,
                ),
              ],
            ),
            SizedBox(
              height: itemHeight * 0.15,
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         Get.toNamed(
            //           NotificationRoutes.NOTIFICATION,
            //           arguments: {
            //             "shop": shop,
            //           },
            //         );
            //       },
            //       child: Container(
            //         height: itemHeight,
            //         width: itemWidth,
            //         decoration: SHOP_ITEM_DECORATION,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Image.asset(
            //               'images/shop_features/notifications.png',
            //               height:
            //                   screen.responsiveValue(mobile: 40, tablet: 60),
            //             ),
            //             SizedBox(
            //               height: 10,
            //             ),
            //             Text(
            //               "notification".tr,
            //               style: TextStyle(
            //                 fontFamily: 'Rubik',
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.normal,
            //                 color: DEFAULT_BLACK,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       width: size.width * 0.03,
            //     ),
            //     InkWell(
            //       onTap: () {
            //         showModalBottomSheet(
            //             isScrollControlled: true,
            //             context: screen.context,
            //             builder: (BuildContext context) {
            //               return SizedBox(
            //                   height: MediaQuery.of(context).size.height * 0.75,
            //                   child: CalcButton());
            //             });
            //       },
            //       child: Container(
            //         height: itemHeight,
            //         width: itemWidth,
            //         decoration: SHOP_ITEM_DECORATION,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Image.asset(
            //               'images/shop_features/calculator.png',
            //               height:
            //                   screen.responsiveValue(mobile: 40, tablet: 60),
            //             ),
            //             SizedBox(
            //               height: 10,
            //             ),
            //             Text(
            //               "calculator".tr,
            //               style: TextStyle(
            //                 fontFamily: 'Rubik',
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.normal,
            //                 color: DEFAULT_BLACK,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            // SizedBox(
            //   height: itemHeight * 0.15,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         Get.to(
            //           () => MarketingShopPage(),
            //           arguments: {
            //             "shop": shop,
            //           },
            //           binding: MarketingShopBinding(),
            //         );
            //       },
            //       child: Container(
            //         height: itemHeight,
            //         width: itemWidth,
            //         decoration: SHOP_ITEM_DECORATION,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             //need update Icon
            //             Image.asset(
            //               'images/shop_features/onlineOrders.png',
            //               height:
            //                   screen.responsiveValue(mobile: 40, tablet: 60),
            //             ),
            //             SizedBox(
            //               height: 10,
            //             ),
            //             Text(
            //               "hishabee_marketing".tr,
            //               style: TextStyle(
            //                 fontFamily: 'Rubik',
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.normal,
            //                 color: DEFAULT_BLACK,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       width: size.width * 0.03,
            //     ),
            //     InkWell(
            //       onTap: () {
            //         Get.toNamed(
            //           SettingsRoutes.SETTINGS,
            //           arguments: {
            //             "shop": shop,
            //           },
            //         );
            //       },
            //       child: Container(
            //         height: itemHeight,
            //         width: itemWidth,
            //         decoration: SHOP_ITEM_DECORATION,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Image.asset(
            //               'images/shop_features/settings.png',
            //               height:
            //                   screen.responsiveValue(mobile: 40, tablet: 60),
            //             ),
            //             SizedBox(
            //               height: 5,
            //             ),
            //             Text(
            //               "app_setting".tr,
            //               style: TextStyle(
            //                 fontFamily: 'Rubik',
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.normal,
            //                 color: DEFAULT_BLACK,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         Get.to(
            //           () => SmsPage(),
            //           arguments: {
            //             "shop": shop,
            //           },
            //           binding: SMSBindings(),
            //         );
            //       },
            //       child: Container(
            //         height: itemHeight,
            //         width: itemWidth,
            //         decoration: SHOP_ITEM_DECORATION,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Image.asset(
            //               'images/shop_features/settings.png',
            //               height:
            //                   screen.responsiveValue(mobile: 40, tablet: 60),
            //             ),
            //             SizedBox(
            //               height: 5,
            //             ),
            //             Text(
            //               "sms_marketing".tr,
            //               style: TextStyle(
            //                 fontFamily: 'Rubik',
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.normal,
            //                 color: DEFAULT_BLACK,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
