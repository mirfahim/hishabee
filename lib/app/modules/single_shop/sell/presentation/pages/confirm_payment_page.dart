import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
// import 'package:hishabee_business_manager_fl/app/_widgets/desktop_app_bar.dart';
// import 'package:hishabee_business_manager_fl/app/_widgets/desktop_left_menue.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/_bindings/app_settings_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/pages/set_qr_code_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/_binding/contact_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/_navigation/contact_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/contact_type_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/pages/add_contact_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/_bindings/due_list_binding.dart';

// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_item_by_unuque_id.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/pages/add_due_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/pages/due_digital_payment_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_bindings/confirm_payment_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_bindings/sell_binding.dart';

// import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_navigation/sell_page_routs.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/confirm_payment_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_digital_payment_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_digital_payment_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_digital_payment_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/sell_digital_payment_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/sell_due_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/sell_with_qr_code_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';

import '../../../due_list/data/remote/models/get_all_due_item_by_uniq_id.dart';
import '../../_navigation/sell_page_route.dart';

class ConfirmPaymentPage extends GetView<ConfirmPaymentController> {
  final bool paying = true;
  //final SellDigitalPaymentController sellDigitalPaymentController = Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final shopFeatureController = Get.find<ShopFeaturesController>();

    TextEditingController CNController = TextEditingController(
        text: controller.selectedCustomer.value.name ?? "");
    TextEditingController CMController = TextEditingController(
        text: controller.selectedCustomer.value.mobile ?? "");
    TextEditingController CDController = TextEditingController(
        text: controller.selectedCustomer.value.address ?? "");
    TextEditingController CEController = TextEditingController(
        text: controller.selectedCustomer.value.email ?? "");

    TextEditingController ENController = TextEditingController(
        text: controller.selectedEmployee.value.name == null
            ? ""
            : controller.selectedEmployee.value.name);
    TextEditingController EMController = TextEditingController(
        text: controller.selectedEmployee.value.mobile == null
            ? ""
            : controller.selectedEmployee.value.mobile);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'payment'.tr,
          style: TextStyle(
            fontFamily: 'Roboto',
          ),
        ),
        titleSpacing: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  'images/svg_image/help.svg',
                  height: 32,
                )),
          )
        ],
        backgroundColor: DEFAULT_YELLOW_BG,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                  // height: size.height,
                  // width: size.width,
                  child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  child: paying
                      ? Obx(
                          () => Form(
                            key: controller.formKey,
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: false,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15.0,
                                        right: 15.0,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: DEFAULT_BLACK,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        height: 55,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Container(
                                                width: size.width * 0.3,
                                                child: Text(
                                                  "grand_total".tr,
                                                  style: TextStyle(
                                                    color: DEFAULT_YELLOW_BG,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: VerticalDivider(
                                                color: DEFAULT_YELLOW_BG,
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Text(
                                                "tk".tr +
                                                    " ${controller.totalPrice} /=",
                                                style: TextStyle(
                                                  color: DEFAULT_YELLOW_BG,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 12.0,
                                        left: 15.0,
                                        right: 15.0,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: DEFAULT_BLACK),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.23),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        height: 55,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Container(
                                                    width: size.width * 0.3,
                                                    child: Text(
                                                      "received".tr,
                                                      style: TextStyle(
                                                        // color: default_yellow,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: VerticalDivider(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 12.0),
                                                child: Form(
                                                  child: TextFormField(
                                                    initialValue:
                                                        "${controller.totalPrice}",
                                                    cursorColor: DEFAULT_BLACK,
                                                    autofocus: true,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                    onChanged: (value) {
                                                      try {
                                                        controller
                                                                .amountReceived
                                                                .value =
                                                            double.parse(value);
                                                      } catch (e) {}

                                                      print(controller
                                                          .amountReceived
                                                          .value);

                                                      controller
                                                          .calculateExchangeAmount();
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      suffix: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          "tk".tr,
                                                          style: TextStyle(
                                                            color:
                                                                DEFAULT_BLACK,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 20.0,
                                        left: 15.0,
                                        right: 15.0,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            "exchange_amount_colon".tr,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Obx(
                                            () => Text(
                                              //nedd to update localization
                                              "tk".tr +
                                                  " ${controller.exchangeAmount.value} /=",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: DEFAULT_BLUE,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10),
                                      child: InkWell(
                                        onTap: () async {
                                          await controller.quickSell();
                                          // await controller
                                          //     .addTransactionItems();
                                        },
                                        child: Container(
                                          height: 50,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(.35),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 80,
                                                    width: 80,
                                                    child: SvgPicture.asset(
                                                      'images/svg_image/payment_cash.svg',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "cash".tr,
                                                    style: TextStyle(
                                                      color: DEFAULT_BLACK,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10),
                                      child: InkWell(
                                        onTap: () {
                                          if (controller
                                                  .selectedCustomer.value !=
                                              null) {
                                            Due due = Due();
                                            GetAllDueItemByUid dueItem =
                                                GetAllDueItemByUid();
                                            Get.to(SellDue(),
                                                binding:
                                                    ConfirmPaymentBinding(),
                                                arguments: {
                                                  "due": due,
                                                  "dueType": 0.0,
                                                  "route": 0,
                                                  'dueItem': dueItem,
                                                  'customer': controller
                                                      .selectedCustomer.value,
                                                  'dueAmount': controller
                                                      .totalPrice.value,
                                                  'shop': controller.shop.value,
                                                  'totalPrice': controller
                                                      .totalPrice.value,
                                                  'itemLenght':
                                                      controller.cart.length,
                                                  'note': controller.note.value,
                                                  'cart': controller.cart,
                                                  'discount':
                                                      controller.discount,
                                                });
                                            // Get.toNamed(SellPageRoutes.SELL_DUE_PAGE,
                                            //     arguments: {
                                            //       "due": due,
                                            //       "dueType": 0,
                                            //       "route": 0,
                                            //       'dueItem':dueItem,
                                            //       'customer':controller.selectedCustomer.value,
                                            //       'dueAmount': controller.totalPrice.value,
                                            //       'shop': controller.shop.value,
                                            //       'totalPrice': controller.totalPrice.value,
                                            //       'itemLenght': controller.cart.length,
                                            //       'note': controller.note.value,
                                            //       'cart': controller.cart,
                                            //     });
                                          } else {
                                            CustomDialog.showStringDialog(
                                                'Please select a Customder');
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(.35),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 80,
                                                    width: 80,
                                                    child: SvgPicture.asset(
                                                      'images/svg_image/due_svg.svg',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "add_due".tr,
                                                    style: TextStyle(
                                                      color: DEFAULT_BLACK,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10),
                                      child: InkWell(
                                        onTap: () async {
                                          Transactions transaction =
                                              new Transactions();
                                          controller.payWithQr.value = true;
                                          Get.to(SellDue(),
                                              arguments: {
                                                "shop": controller.shop.value,
                                                // "transaction": transaction,
                                              },
                                              binding: SellBinding());
                                        },
                                        child: Container(
                                          height: 50,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(.35),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 80,
                                                    width: 80,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: SvgPicture.asset(
                                                        'images/svg_image/nkash_qr.svg',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "personal_qr_code".tr,
                                                    style: TextStyle(
                                                      color: DEFAULT_BLACK,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10),
                                      child: InkWell(
                                        onTap: () async {
                                          ///TODO DIGITAL PAYMENT
                                          CustomDialog.showLoadingDialog(
                                              message:
                                                  'Opening Digital Payment');
                                          Future.delayed(Duration(seconds: 1),
                                              () {
                                            controller.generateLink();
                                            Get.back();
                                          });
                                        },
                                        child: Container(
                                          height: 50,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(.35),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 80,
                                                    width: 80,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: SvgPicture.asset(
                                                        'images/svg_image/digital_payment.svg',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "digital_payment".tr,
                                                    style: TextStyle(
                                                      color: DEFAULT_BLACK,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Padding(
                                    //       padding: const EdgeInsets.symmetric(
                                    //           horizontal: 15.0, vertical: 10),
                                    //       child: ElevatedButton(
                                    //         style: ElevatedButton.styleFrom(
                                    //             primary: Colors.white),
                                    //         onPressed: () async {
                                    //           await controller
                                    //               .quickSell();
                                    //         },
                                    //         child: Container(
                                    //           width: size.width * 0.3,
                                    //           height: 150,
                                    //           decoration: BoxDecoration(
                                    //             color: Colors.white,
                                    //             // boxShadow: [
                                    //             //   BoxShadow(
                                    //             //     color: Colors.grey.withOpacity(0.5),
                                    //             //     spreadRadius: 5,
                                    //             //     blurRadius: 7,
                                    //             //     offset: Offset(0, 3), // changes position of shadow
                                    //             //   ),
                                    //             // ],
                                    //           ),
                                    //           child: Column(
                                    //             mainAxisAlignment: MainAxisAlignment.center,
                                    //             crossAxisAlignment: CrossAxisAlignment.center,
                                    //             children: [
                                    //               Container(
                                    //                 height: 80,
                                    //                 width: 80,
                                    //                 child: SvgPicture.asset(
                                    //                   'images/svg_image/cash_money.svg',
                                    //                   color:DEFAULT_BLACK,
                                    //                 ),
                                    //               ),
                                    //               SizedBox(width: 10),
                                    //               Text(
                                    //                 "cash".tr,
                                    //                 style: TextStyle(
                                    //                   color: DEFAULT_BLACK,
                                    //                   fontFamily: 'Roboto',
                                    //                   fontWeight:
                                    //                   FontWeight.w500,
                                    //                   fontSize: 16,
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     Padding(
                                    //       padding: const EdgeInsets.only(
                                    //           left: 15,
                                    //           right: 15,
                                    //           top: 10,
                                    //           bottom: 10),
                                    //       child: ElevatedButton(
                                    //         style: ElevatedButton.styleFrom(
                                    //             primary: Colors.white),
                                    //         onPressed: () {
                                    //           ///TODO DIGITAL PAYMENT
                                    //           CustomDialog.showLoadingDialog(message: 'Opening Digital Payment');
                                    //           Future.delayed(Duration(seconds: 1),(){
                                    //             Get.back();
                                    //           });
                                    //         },
                                    //         child: Container(
                                    //           width: size.width * 0.3,
                                    //           height: 150,
                                    //           decoration: BoxDecoration(
                                    //             color: Colors.white,
                                    //             boxShadow: [
                                    //               BoxShadow(
                                    //                 color: Colors.grey.withOpacity(0.5),
                                    //                 spreadRadius: 5,
                                    //                 blurRadius: 7,
                                    //                 offset: Offset(0, 3), // changes position of shadow
                                    //               ),
                                    //             ],
                                    //           ),
                                    //           child: Column(
                                    //             mainAxisAlignment: MainAxisAlignment.center,
                                    //             crossAxisAlignment: CrossAxisAlignment.center,
                                    //             children: [
                                    //               Container(
                                    //                 height: 80,
                                    //                 width: 80,
                                    //                 child: SvgPicture.asset(
                                    //                   'images/svg_image/digital_payment.svg',
                                    //                 ),
                                    //               ),
                                    //               SizedBox(height: 10),
                                    //               Text(
                                    //                 "digital_payment".tr,
                                    //                 style: TextStyle(
                                    //                   color: DEFAULT_BLACK,
                                    //                   fontFamily: 'Rubik',
                                    //                   fontWeight:
                                    //                   FontWeight.w600,
                                    //                   fontSize: 14,
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Padding(
                                    //       padding: const EdgeInsets.only(
                                    //           left: 15,
                                    //           right: 15,
                                    //           top: 10,
                                    //           bottom: 10),
                                    //       child: ElevatedButton(
                                    //         style: ElevatedButton.styleFrom(
                                    //             primary: Colors.white),
                                    //         onPressed: () {
                                    //           if(controller.selectedCustomer.value != null){
                                    //             Due due = Due();
                                    //             GetAllDueItemByUid dueItem = GetAllDueItemByUid();
                                    //             Get.to(SellDue(),
                                    //                 binding: ConfirmPaymentBinding(),
                                    //             arguments: {
                                    //               "due": due,
                                    //               "dueType": 0,
                                    //               "route": 0,
                                    //               'dueItem':dueItem,
                                    //               'customer':controller.selectedCustomer.value,
                                    //               'dueAmount': controller.totalPrice.value,
                                    //               'shop': controller.shop.value,
                                    //               'totalPrice': controller.totalPrice.value,
                                    //               'itemLenght': controller.cart.length,
                                    //               'note': controller.note.value,
                                    //               'cart': controller.cart,
                                    //             }
                                    //             );
                                    //             // Get.toNamed(SellPageRoutes.SELL_DUE_PAGE,
                                    //             //     arguments: {
                                    //             //       "due": due,
                                    //             //       "dueType": 0,
                                    //             //       "route": 0,
                                    //             //       'dueItem':dueItem,
                                    //             //       'customer':controller.selectedCustomer.value,
                                    //             //       'dueAmount': controller.totalPrice.value,
                                    //             //       'shop': controller.shop.value,
                                    //             //       'totalPrice': controller.totalPrice.value,
                                    //             //       'itemLenght': controller.cart.length,
                                    //             //       'note': controller.note.value,
                                    //             //       'cart': controller.cart,
                                    //             //     });
                                    //           }else{
                                    //             CustomDialog.showStringDialog('Please select a Customder');
                                    //           }
                                    //         },
                                    //         child: Container(
                                    //           width: size.width * 0.3,
                                    //           height: 150,
                                    //           decoration: BoxDecoration(
                                    //             color: Colors.white,
                                    //             boxShadow: [
                                    //               BoxShadow(
                                    //                 color: Colors.grey.withOpacity(0.5),
                                    //                 spreadRadius: 5,
                                    //                 blurRadius: 7,
                                    //                 offset: Offset(0, 3), // changes position of shadow
                                    //               ),
                                    //             ],
                                    //           ),
                                    //           child: Column(
                                    //             mainAxisAlignment: MainAxisAlignment.center,
                                    //             crossAxisAlignment: CrossAxisAlignment.center,
                                    //             children: [
                                    //               Container(
                                    //                 height: 80,
                                    //                 width: 80,
                                    //                 child: SvgPicture.asset(
                                    //                   'images/svg_image/due.svg',
                                    //                   color: DEFAULT_BLACK,
                                    //                 ),
                                    //               ),
                                    //               SizedBox(height: 10),
                                    //               Text(
                                    //                 "add_due".tr,
                                    //                 style: TextStyle(
                                    //                   color: DEFAULT_BLACK,
                                    //                   fontFamily: 'Rubik',
                                    //                   fontWeight:
                                    //                   FontWeight.w600,
                                    //                   fontSize: 14,
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     Padding(
                                    //       padding: const EdgeInsets.only(
                                    //           left: 15,
                                    //           right: 15,
                                    //           top: 10,
                                    //           bottom: 10),
                                    //       child: ElevatedButton(
                                    //         style: ElevatedButton.styleFrom(
                                    //             primary: Colors.white),
                                    //         onPressed: () {
                                    //           Transactions transaction = new Transactions();
                                    //           controller.payWithQr.value = true;
                                    //           Get.toNamed(
                                    //             SellPageRoutes.SELL_QR_PAGE,
                                    //             arguments: {
                                    //               "shop":
                                    //               controller.shop.value,
                                    //               "transaction": transaction,
                                    //             },
                                    //           );
                                    //         },
                                    //         child: Container(
                                    //           width: size.width * 0.3,
                                    //           height: 150,
                                    //           decoration: BoxDecoration(
                                    //             color: Colors.white,
                                    //             boxShadow: [
                                    //               BoxShadow(
                                    //                 color: Colors.grey.withOpacity(0.5),
                                    //                 spreadRadius: 5,
                                    //                 blurRadius: 7,
                                    //                 offset: Offset(0, 3), // changes position of shadow
                                    //               ),
                                    //             ],
                                    //           ),
                                    //           child: Column(
                                    //             mainAxisAlignment: MainAxisAlignment.center,
                                    //             crossAxisAlignment: CrossAxisAlignment.center,
                                    //             children: [
                                    //               Container(
                                    //                 height: 80,
                                    //                 width: 80,
                                    //                 child: SvgPicture.asset(
                                    //                   'images/svg_image/qr_code.svg',
                                    //                   color: DEFAULT_BLACK,
                                    //                 ),
                                    //               ),
                                    //               SizedBox(height: 10),
                                    //               Text(
                                    //                 "personal_qr_code".tr,
                                    //                 style: TextStyle(
                                    //                   color: DEFAULT_BLACK,
                                    //                   fontFamily: 'Rubik',
                                    //                   fontWeight:
                                    //                   FontWeight.w600,
                                    //                   fontSize: 14,
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 10,
                                          bottom: 10),
                                      child: Container(
                                        height: 50,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          onSaved: (value) {},
                                          decoration: InputDecoration(
                                            labelText: "add_note".tr,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 10),
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.w100,
                                              color: Colors.black26,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 10,
                                          bottom: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "employee_information".tr,
                                            style: TextStyle(
                                              color: DEFAULT_BLACK,
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Spacer(),
                                          Obx(
                                            () => FlutterSwitch(
                                              height: 20.0,
                                              width: 40.0,
                                              padding: 4.0,
                                              toggleSize: 20.0,
                                              borderRadius: 20.0,
                                              activeColor: Colors.black,
                                              value: controller
                                                  .addingEmployeeInfo.value,
                                              onToggle: (value) {
                                                controller.addingEmployeeInfo
                                                    .value = value;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    controller.addingEmployeeInfo.value
                                        ? Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 10),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.grey
                                                              .withOpacity(.35),
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0),
                                                          child: Text(
                                                            "employee_name".tr,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Rubik',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  DEFAULT_BLACK,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                          height: 30,
                                                          child:
                                                              VerticalDivider(
                                                                  thickness: 2,
                                                                  color: Colors
                                                                      .black,
                                                                  indent: 0,
                                                                  endIndent:
                                                                      0)),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 3.0),
                                                          child: TextFormField(
                                                            onChanged: (value) {
                                                              // controller.searchProduct(value);
                                                            },
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              errorBorder:
                                                                  InputBorder
                                                                      .none,
                                                              disabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  "search_for_employee"
                                                                      .tr,
                                                              hintStyle: TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  fontFamily:
                                                                      'Roboto'),
                                                              // border: InputBorder(bo),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder: (_) =>
                                                                    KeyboardAwareDialog(
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              top: 18.0,
                                                                              left: 10,
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              "Employee List",
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                color: DEFAULT_BLACK,
                                                                                fontSize: 18,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.7,
                                                                                  child: TextFormField(
                                                                                    onChanged: (value) {
                                                                                      //controller.searchCustomer(value);
                                                                                    },
                                                                                    decoration: InputDecoration(
                                                                                      prefixIcon: Icon(
                                                                                        Icons.search,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.6,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Obx(
                                                                                () => ListView.builder(
                                                                                  shrinkWrap: true,
                                                                                  itemCount: controller.employees.length,
                                                                                  itemBuilder: (BuildContext context, int index) {
                                                                                    var employee = controller.employees[index];
                                                                                    return ElevatedButton(
                                                                                      style: ElevatedButton.styleFrom(primary: Colors.white, onPrimary: Colors.grey, elevation: 0.0),
                                                                                      onPressed: () {
                                                                                        controller.selectedEmployee.value = employee;
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                              width: size.width / 2,
                                                                                              child: Text(
                                                                                                "${employee.name}",
                                                                                                style: TextStyle(color: DEFAULT_BLUE, fontFamily: "Rubik"),
                                                                                              )),
                                                                                          SizedBox(height: 10),
                                                                                          Divider(),
                                                                                        ],
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.bottomRight,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(right: 10.0),
                                                                                  child: Container(
                                                                                    child: TextButton(
                                                                                        onPressed: () => Navigator.of(context).pop(),
                                                                                        child: Text(
                                                                                          "close".tr,
                                                                                          style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                                                                                        )),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(right: 10.0),
                                                                                  child: Container(
                                                                                    margin: EdgeInsets.all(8),
                                                                                    height: 35,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(4),
                                                                                      color: DEFAULT_BLACK,
                                                                                    ),
                                                                                    child: TextButton(
                                                                                        onPressed: () {
                                                                                          Employee employee = new Employee();
                                                                                          Get.toNamed(
                                                                                            ContactRoutes.ADD_CONTACT,
                                                                                            arguments: {
                                                                                              'shop': controller.shop.value,
                                                                                              "type": ContactType.EMPLOYEE,
                                                                                              "contact": employee,
                                                                                            },
                                                                                          );
                                                                                        },
                                                                                        child: Center(
                                                                                          child: Text(
                                                                                            "add_new_employee".tr,
                                                                                            style: TextStyle(color: Colors.white, fontSize: 14),
                                                                                          ),
                                                                                        )),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ));
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .keyboard_arrow_down_outlined,
                                                            color: Colors.black,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 10),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.grey
                                                              .withOpacity(.35),
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0),
                                                          child: Text(
                                                            "employee_number"
                                                                .tr,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  DEFAULT_BLACK,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                          height: 30,
                                                          child:
                                                              VerticalDivider(
                                                                  thickness: 2,
                                                                  color: Colors
                                                                      .black,
                                                                  indent: 0,
                                                                  endIndent:
                                                                      0)),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 3.0),
                                                          child: TextFormField(
                                                            onChanged: (value) {
                                                              // controller.searchProduct(value);
                                                            },
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              errorBorder:
                                                                  InputBorder
                                                                      .none,
                                                              disabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  "employee_number"
                                                                      .tr,
                                                              hintStyle: TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  fontFamily:
                                                                      'Roboto'),
                                                              // border: InputBorder(bo),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        // Container(
                                        //   width: size.width,
                                        //       child: Padding(
                                        //   padding: const EdgeInsets.only(
                                        //         left: 15,
                                        //         right: 15,
                                        //         top: 10,
                                        //         bottom: 10),
                                        //   child: Column(
                                        //       children: [
                                        //         Container(
                                        //           height: 50,
                                        //           width: size.width,
                                        //           decoration: BoxDecoration(
                                        //             border: Border.all(
                                        //                 color: Colors.grey),
                                        //             borderRadius:
                                        //             BorderRadius
                                        //                 .circular(10),
                                        //           ),
                                        //           child: Row(
                                        //             children: [
                                        //               Expanded(
                                        //                 child: Padding(
                                        //                   padding:
                                        //                   const EdgeInsets
                                        //                       .symmetric(
                                        //                       horizontal:
                                        //                       10.0),
                                        //                   child: Text(
                                        //                     "employee_name"
                                        //                         .tr,
                                        //                     style:
                                        //                     TextStyle(
                                        //                       fontFamily:
                                        //                       'Rubik',
                                        //                       fontWeight:
                                        //                       FontWeight
                                        //                           .bold,
                                        //                       color:
                                        //                       DEFAULT_BLACK,
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //               Padding(
                                        //                 padding:
                                        //                 const EdgeInsets
                                        //                     .symmetric(
                                        //                     vertical:
                                        //                     16.0),
                                        //                 child:
                                        //                 VerticalDivider(
                                        //                   thickness: 0.6,
                                        //                   color:
                                        //                   DEFAULT_BLACK,
                                        //                 ),
                                        //               ),
                                        //               // Spacer(),
                                        //               Expanded(
                                        //                   flex: 2,
                                        //                 child: InkWell(
                                        //                   onTap: () {
                                        //                     //_showMaterialDialog(context);
                                        //                   },
                                        //                   child: Container(
                                        //                     // width:
                                        //                     // 450 ,
                                        //                     child: Row(
                                        //                       children: [
                                        //                         Container(
                                        //                           width: size.width,
                                        //                           child:
                                        //                           TextFormField(
                                        //                             onSaved:
                                        //                                 (value) {
                                        //                               controller
                                        //                                   .employeeName
                                        //                                   .value = value;
                                        //                             },
                                        //                             controller:
                                        //                             ENController,
                                        //                             // keyboardType: TextInputType.number,
                                        //                             decoration:
                                        //                             InputDecoration(
                                        //                               border:
                                        //                               InputBorder.none,
                                        //                               focusedBorder:
                                        //                               InputBorder.none,
                                        //                               enabledBorder:
                                        //                               InputBorder.none,
                                        //                               hintText:
                                        //                               "Customer Name",
                                        //                               hintStyle:
                                        //                               TextStyle(
                                        //                                 fontFamily:
                                        //                                 'Rubik',
                                        //                                 color:
                                        //                                 DEFAULT_BLACK,
                                        //                               ),
                                        //                             ),
                                        //                           ),
                                        //                         ),
                                        //                         IconButton(
                                        //                           onPressed:
                                        //                               () {
                                        //                             showDialog(
                                        //                                 context:
                                        //                                 context,
                                        //                                 builder: (_) =>
                                        //                                     KeyboardAwareDialog(
                                        //                                       child: Column(
                                        //                                         mainAxisSize: MainAxisSize.min,
                                        //                                         crossAxisAlignment: CrossAxisAlignment.start,
                                        //                                         children: [
                                        //                                           Padding(
                                        //                                             padding: const EdgeInsets.only(
                                        //                                               top: 18.0,
                                        //                                               left: 10,
                                        //                                             ),
                                        //                                             child: Text(
                                        //                                               "Employee List",
                                        //                                               style: TextStyle(
                                        //                                                 fontWeight: FontWeight.bold,
                                        //                                                 color: DEFAULT_BLACK,
                                        //                                                 fontSize: 18,
                                        //                                               ),
                                        //                                             ),
                                        //                                           ),
                                        //                                           Padding(
                                        //                                             padding: const EdgeInsets.all(8.0),
                                        //                                             child: Row(
                                        //                                               children: [
                                        //                                                 Container(
                                        //                                                   width: MediaQuery.of(context).size.width * 0.7,
                                        //                                                   child: TextFormField(
                                        //                                                     onChanged: (value) {
                                        //                                                       //controller.searchCustomer(value);
                                        //                                                     },
                                        //                                                     decoration: InputDecoration(
                                        //                                                       prefixIcon: Icon(
                                        //                                                         Icons.search,
                                        //                                                       ),
                                        //                                                     ),
                                        //                                                   ),
                                        //                                                 ),
                                        //                                               ],
                                        //                                             ),
                                        //                                           ),
                                        //                                           Container(
                                        //                                             height: MediaQuery.of(context).size.height * 0.6,
                                        //                                             child: Padding(
                                        //                                               padding: const EdgeInsets.all(8.0),
                                        //                                               child: Obx(
                                        //                                                     () => ListView.builder(
                                        //                                                   shrinkWrap: true,
                                        //                                                   itemCount: controller.employees.length,
                                        //                                                   itemBuilder: (BuildContext context, int index) {
                                        //                                                     var employee = controller.employees[index];
                                        //                                                     return ElevatedButton(
                                        //                                                       style: ElevatedButton.styleFrom(primary: Colors.white, onPrimary: Colors.grey, elevation: 0.0),
                                        //                                                       onPressed: () {
                                        //                                                         controller.selectedEmployee.value = employee;
                                        //                                                         Navigator.pop(context);
                                        //                                                       },
                                        //                                                       child: Column(
                                        //                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                        //                                                         children: [
                                        //                                                           Container(
                                        //                                                               width: size.width / 2,
                                        //                                                               child: Text(
                                        //                                                                 "${employee.name}",
                                        //                                                                 style: TextStyle(color: DEFAULT_BLUE, fontFamily: "Rubik"),
                                        //                                                               )),
                                        //                                                           SizedBox(height: 10),
                                        //                                                           Divider(),
                                        //                                                         ],
                                        //                                                       ),
                                        //                                                     );
                                        //                                                   },
                                        //                                                 ),
                                        //                                               ),
                                        //                                             ),
                                        //                                           ),
                                        //                                           Align(
                                        //                                             alignment: Alignment.bottomRight,
                                        //                                             child: Row(
                                        //                                               mainAxisAlignment: MainAxisAlignment.end,
                                        //                                               children: [
                                        //                                                 Padding(
                                        //                                                   padding: const EdgeInsets.only(right: 10.0),
                                        //                                                   child: Container(
                                        //                                                     child: TextButton(
                                        //                                                         onPressed: () => Navigator.of(context).pop(),
                                        //                                                         child: Text(
                                        //                                                           "close".tr,
                                        //                                                           style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                                        //                                                         )),
                                        //                                                   ),
                                        //                                                 ),
                                        //                                                 Padding(
                                        //                                                   padding: const EdgeInsets.only(right: 10.0),
                                        //                                                   child: Container(
                                        //                                                     margin: EdgeInsets.all(8),
                                        //                                                     height: 35,
                                        //                                                     decoration: BoxDecoration(
                                        //                                                       borderRadius: BorderRadius.circular(4),
                                        //                                                       color: DEFAULT_BLACK,
                                        //                                                     ),
                                        //                                                     child: TextButton(
                                        //                                                         onPressed: () {
                                        //                                                           Employee employee = new Employee();
                                        //                                                           Get.toNamed(ContactRoutes.ADD_CONTACT,
                                        //                                                             arguments: {
                                        //                                                               'shop': controller.shop.value,
                                        //                                                               "type": ContactType.EMPLOYEE,
                                        //                                                               "contact": employee,
                                        //                                                             },);
                                        //                                                         },
                                        //                                                         child: Center(
                                        //                                                           child: Text(
                                        //                                                             "add_new_employee".tr,
                                        //                                                             style: TextStyle(color: Colors.white, fontSize: 14),
                                        //                                                           ),
                                        //                                                         )),
                                        //                                                   ),
                                        //                                                 ),
                                        //                                               ],
                                        //                                             ),
                                        //                                           )
                                        //                                         ],
                                        //                                       ),
                                        //                                     ));
                                        //                           },
                                        //                           icon:
                                        //                           Icon(
                                        //                             Icons
                                        //                                 .arrow_drop_down_circle,
                                        //                           ),
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //         Padding(
                                        //           padding: const EdgeInsets
                                        //               .symmetric(
                                        //               vertical: 10),
                                        //           child: Container(
                                        //             height: 50,
                                        //             decoration:
                                        //             BoxDecoration(
                                        //               color: Colors.white,
                                        //               borderRadius:
                                        //               BorderRadius
                                        //                   .circular(8),
                                        //               border: Border.all(
                                        //                   width: 0.1,
                                        //                   color:
                                        //                   Colors.black),
                                        //             ),
                                        //             child: Row(
                                        //               mainAxisAlignment:
                                        //               MainAxisAlignment
                                        //                   .spaceBetween,
                                        //               children: [
                                        //                 Padding(
                                        //                   padding:
                                        //                   const EdgeInsets
                                        //                       .only(
                                        //                       left:
                                        //                       15.0),
                                        //                   child: Container(
                                        //                     width:
                                        //                     size.width *
                                        //                         0.2,
                                        //                     child: Text(
                                        //                       "mobile".tr,
                                        //                       style:
                                        //                       TextStyle(
                                        //                         fontFamily:
                                        //                         'Rubik',
                                        //                         fontWeight:
                                        //                         FontWeight
                                        //                             .bold,
                                        //                         color:
                                        //                         DEFAULT_BLACK,
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //                 Padding(
                                        //                   padding:
                                        //                   const EdgeInsets
                                        //                       .symmetric(
                                        //                       vertical:
                                        //                       16.0),
                                        //                   child:
                                        //                   VerticalDivider(
                                        //                     thickness: 0.6,
                                        //                     color:
                                        //                     DEFAULT_BLACK,
                                        //                   ),
                                        //                 ),
                                        //                 Container(
                                        //                   width:
                                        //                   size.width ,
                                        //                   child:
                                        //                   TextFormField(
                                        //                     onSaved:
                                        //                         (value) {
                                        //                       controller
                                        //                           .employeeNumber
                                        //                           .value = value;
                                        //                     },
                                        //                     controller:
                                        //                     EMController,
                                        //                     decoration:
                                        //                     InputDecoration(
                                        //                       border:
                                        //                       InputBorder
                                        //                           .none,
                                        //                       focusedBorder:
                                        //                       InputBorder
                                        //                           .none,
                                        //                       enabledBorder:
                                        //                       InputBorder
                                        //                           .none,
                                        //                       hintText:
                                        //                       "Employee Mobile Number",
                                        //                       hintStyle: TextStyle(
                                        //                           color:
                                        //                           DEFAULT_BLACK,
                                        //                           fontWeight:
                                        //                           FontWeight
                                        //                               .normal),
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ],
                                        //   ),
                                        // ),
                                        //     )
                                        : Container(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 10,
                                          bottom: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "customer_information".tr,
                                            style: TextStyle(
                                              color: DEFAULT_BLACK,
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Spacer(),
                                          Obx(
                                            () => FlutterSwitch(
                                              height: 20.0,
                                              width: 40.0,
                                              padding: 4.0,
                                              toggleSize: 20.0,
                                              borderRadius: 20.0,
                                              activeColor: Colors.black,
                                              value: controller
                                                  .addingCustomerInfo.value,
                                              onToggle: (value) {
                                                controller.addingCustomerInfo
                                                    .value = value;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    controller.addingCustomerInfo.value
                                        ? Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 10),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.grey
                                                              .withOpacity(.35),
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0),
                                                          child: Text(
                                                            "customer_name".tr,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  DEFAULT_BLACK,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                          height: 30,
                                                          child:
                                                              VerticalDivider(
                                                                  thickness: 2,
                                                                  color: Colors
                                                                      .black,
                                                                  indent: 0,
                                                                  endIndent:
                                                                      0)),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 3.0),
                                                          child: TextFormField(
                                                            onChanged: (value) {
                                                              // controller.searchProduct(value);
                                                            },
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              errorBorder:
                                                                  InputBorder
                                                                      .none,
                                                              disabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  "search_for_customer"
                                                                      .tr,
                                                              hintStyle: TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  fontFamily:
                                                                      'Roboto'),
                                                              // border: InputBorder(bo),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder: (_) =>
                                                                  KeyboardAwareDialog(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        top:
                                                                            18.0,
                                                                        left:
                                                                            10,
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        "Customer List",
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              DEFAULT_BLACK,
                                                                          fontSize:
                                                                              18,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.7,
                                                                            child:
                                                                                TextFormField(
                                                                              onChanged: (value) {
                                                                                //controller.searchCustomer(value);
                                                                              },
                                                                              decoration: InputDecoration(
                                                                                prefixIcon: Icon(
                                                                                  Icons.search,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.6,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Obx(
                                                                          () =>
                                                                              ListView.builder(
                                                                            shrinkWrap:
                                                                                true,
                                                                            physics:
                                                                                ScrollPhysics(),
                                                                            itemCount:
                                                                                controller.searchCustomerList.length,
                                                                            itemBuilder:
                                                                                (BuildContext context, int index) {
                                                                              return Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  GestureDetector(
                                                                                    onTap: () {
                                                                                      controller.selectedCustomer.value = controller.searchCustomerList[index];
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Obx(
                                                                                        () => Text(
                                                                                          "${controller.searchCustomerList[index].name} ( ${controller.searchCustomerList[index].mobile} )",
                                                                                          style: TextStyle(
                                                                                            fontSize: 14,
                                                                                            fontWeight: FontWeight.bold,
                                                                                            color: Colors.black,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Divider(),
                                                                                ],
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomRight,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 10.0),
                                                                            child:
                                                                                Container(
                                                                              child: TextButton(
                                                                                  onPressed: () => Navigator.of(context).pop(),
                                                                                  child: Text(
                                                                                    "close".tr,
                                                                                    style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 10.0),
                                                                            child:
                                                                                Container(
                                                                              margin: EdgeInsets.all(8),
                                                                              height: 35,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(4),
                                                                                color: DEFAULT_BLACK,
                                                                              ),
                                                                              child: TextButton(
                                                                                  onPressed: () {
                                                                                    Customer customer = new Customer();
                                                                                    Get.toNamed(
                                                                                      ContactRoutes.ADD_CONTACT,
                                                                                      arguments: {
                                                                                        'shop': controller.shop.value,
                                                                                        "type": ContactType.CUSTOMER,
                                                                                        "contact": customer,
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      "add_new_customer".tr,
                                                                                      style: TextStyle(color: Colors.white, fontSize: 14),
                                                                                    ),
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .keyboard_arrow_down_outlined,
                                                            color: Colors.black,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 10),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.grey
                                                              .withOpacity(.35),
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0),
                                                          child: Text(
                                                            "customer_number"
                                                                .tr,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  DEFAULT_BLACK,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                          height: 30,
                                                          child:
                                                              VerticalDivider(
                                                                  thickness: 2,
                                                                  color: Colors
                                                                      .black,
                                                                  indent: 0,
                                                                  endIndent:
                                                                      0)),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 3.0),
                                                          child: TextFormField(
                                                            onChanged: (value) {
                                                              // controller.searchProduct(value);
                                                            },
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              errorBorder:
                                                                  InputBorder
                                                                      .none,
                                                              disabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  "customer_number"
                                                                      .tr,
                                                              hintStyle: TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  fontFamily:
                                                                      'Roboto'),
                                                              // border: InputBorder(bo),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 10),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.grey
                                                              .withOpacity(.35),
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0),
                                                          child: Text(
                                                            "customer_address"
                                                                .tr,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  DEFAULT_BLACK,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                          height: 30,
                                                          child:
                                                              VerticalDivider(
                                                                  thickness: 2,
                                                                  color: Colors
                                                                      .black,
                                                                  indent: 0,
                                                                  endIndent:
                                                                      0)),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 3.0),
                                                          child: TextFormField(
                                                            onChanged: (value) {
                                                              // controller.searchProduct(value);
                                                            },
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              errorBorder:
                                                                  InputBorder
                                                                      .none,
                                                              disabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  "customer_address"
                                                                      .tr,
                                                              hintStyle: TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  fontFamily:
                                                                      'Roboto'),
                                                              // border: InputBorder(bo),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 30),
                              Text(
                                "Please Wait",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
