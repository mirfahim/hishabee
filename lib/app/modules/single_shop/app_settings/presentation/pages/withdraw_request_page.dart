import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/page_background.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/page_header.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/manager/withdraw_request_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/widgets/withdraw_footer.dart';

class WithdrawRequest extends GetResponsiveView<WithdrawRequestController> {
  @override
  Widget builder() {
    Size size = MediaQuery.of(screen.context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: size.height * 0.2,
              width: size.width,
              child: Image.asset(
                "images/topBg.png",
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Obx(
                    () => controller.accountInfo.value == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : MediaQuery.removePadding(
                            context: screen.context,
                            removeTop: true,
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  child: buildPageHeader('withdraw_request'.tr,
                                      controller.shop.value.name),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "digital_balance_colon".tr,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLACK),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${controller.shop.value.walletBalance}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 60,
                                  margin: EdgeInsets.only(
                                    left: 20,
                                    top: 10,
                                    right: 20,
                                    bottom: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                      bottomLeft: Radius.circular(4),
                                      bottomRight: Radius.circular(4),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Container(
                                    height: 170,
                                    width: size.width,
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Container(
                                            width: size.width * 0.8,
                                            child: Text(
                                              "digital_balance_is_paid_to_your_account_at_the_end_of_every_month_please_update_your_account_information_to_receive_payment_correctly"
                                                  .tr,
                                              style: TextStyle(
                                                  fontFamily: "Rubik",
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        topRight: Radius.circular(4),
                                        bottomLeft: Radius.circular(4),
                                        bottomRight: Radius.circular(4),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, left: 20, right: 20),
                                  child: Text(
                                    "account_information".tr,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: DEFAULT_BLACK,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, left: 20, right: 20),
                                  child: Text(
                                    "account_type".tr,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: DEFAULT_BLACK,
                                    ),
                                  ),
                                ),
                                PopupMenuButton(
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        value: 0,
                                        child: Text(
                                          "Bkash",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 1,
                                        child: Text(
                                          "Bank",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                      ),
                                    ];
                                  },
                                  onSelected: (value) async {
                                    switch (value) {
                                      case 0:
                                        controller.accountType.value = "BKASH";
                                        break;
                                      case 1:
                                        controller.accountType.value = "BANK";
                                        break;
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, left: 20, right: 20),
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
                                              child: Obx(
                                                () {
                                                  return Text(
                                                    controller.accountType
                                                                .value ==
                                                            "BKASH"
                                                        ? "Bkash"
                                                        : "Bank",
                                                    style: TextStyle(
                                                      fontFamily: 'Rubik',
                                                      // fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLACK,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Icon(Icons.arrow_drop_down),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () {
                                    return controller.accountType.value ==
                                            "BKASH"
                                        ? Form(
                                            key: controller.bKashFormKey,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0,
                                                          left: 20,
                                                          right: 20),
                                                  child: Text(
                                                    "bkash_mobile_number".tr,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: DEFAULT_BLACK,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0,
                                                          left: 20,
                                                          right: 20),
                                                  child: Container(
                                                    height: 48,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.grey),
                                                    ),
                                                    child: TextFormField(
                                                      initialValue:
                                                          "${controller.accountInfo.value.seller.bkash ?? ""}",
                                                      cursorColor:
                                                          DEFAULT_BLACK,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10),
                                                        hintText:
                                                            "Bank Routing Number",
                                                      ),
                                                      onSaved: (value) {
                                                        controller.bKash.value =
                                                            value;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0,
                                                          left: 20,
                                                          right: 20),
                                                  child: Text(
                                                    "important_please_verify_that_this_is_correct_payment_will_be_sent_to_this_account_mobile_number"
                                                        .tr,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: DEFAULT_BLACK,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0,
                                                          left: 20,
                                                          right: 20),
                                                  child: Text(
                                                    "bkash_transaction_fee_will_be_deducted"
                                                        .tr,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Form(
                                            key: controller.bankFormKey,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0,
                                                          left: 20,
                                                          right: 20),
                                                  child: Text(
                                                    "bank_account_name".tr,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: DEFAULT_BLACK,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0,
                                                          left: 20,
                                                          right: 20),
                                                  child: Container(
                                                    height: 48,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.grey),
                                                    ),
                                                    child: TextFormField(
                                                      initialValue:
                                                          "${controller.accountInfo.value.seller.bankAccName}",
                                                      cursorColor:
                                                          DEFAULT_BLACK,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10),
                                                        hintText:
                                                            "Bank Account Name",
                                                      ),
                                                      onSaved: (value) {
                                                        controller.accountName
                                                            .value = value;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0,
                                                          left: 20,
                                                          right: 20),
                                                  child: Text(
                                                    "bank_account_number".tr,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: DEFAULT_BLACK,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0,
                                                          left: 20,
                                                          right: 20),
                                                  child: Container(
                                                    height: 48,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.grey),
                                                    ),
                                                    child: TextFormField(
                                                      initialValue:
                                                          "${controller.accountInfo.value.seller.bankAccNo}",
                                                      cursorColor:
                                                          DEFAULT_BLACK,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10),
                                                        hintText:
                                                            "Bank Account Number",
                                                      ),
                                                      onSaved: (value) {
                                                        controller.accountNumber
                                                            .value = value;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0,
                                                          left: 20,
                                                          right: 20),
                                                  child: Text(
                                                    "bank_name".tr,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: DEFAULT_BLACK,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0,
                                                          left: 20,
                                                          right: 20),
                                                  child: Container(
                                                    height: 48,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.grey),
                                                    ),
                                                    child: TextFormField(
                                                      initialValue:
                                                          "${controller.accountInfo.value.seller.bankName}",
                                                      cursorColor:
                                                          DEFAULT_BLACK,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10),
                                                        hintText: "Bank Name",
                                                      ),
                                                      onSaved: (value) {
                                                        controller.bankName
                                                            .value = value;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0,
                                                          left: 20,
                                                          right: 20),
                                                  child: Text(
                                                    "bank_routing_number".tr,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: DEFAULT_BLACK,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0,
                                                          left: 20,
                                                          right: 20),
                                                  child: Container(
                                                    height: 48,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.grey),
                                                    ),
                                                    child: TextFormField(
                                                      initialValue:
                                                          "${controller.accountInfo.value.seller.bankRoutingNo.toString()}",
                                                      cursorColor:
                                                          DEFAULT_BLACK,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10),
                                                        hintText:
                                                            "Bank Routing Number",
                                                      ),
                                                      onSaved: (value) {
                                                        controller
                                                            .bankRoutingNumber
                                                            .value = value;
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                  },
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (controller.accountType.value ==
                                        "BKASH") {
                                      controller.bKashFormKey.currentState
                                          .save();
                                      await controller.saveAccountInfo();
                                    } else {
                                      controller.bankFormKey.currentState
                                          .save();
                                      await controller.saveAccountInfo();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, left: 20, right: 20),
                                    child: Container(
                                      height: 45,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.red,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "save".tr,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, left: 20, right: 20),
                                  child: Container(
                                    child: Divider(
                                      thickness: 2,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                WithdrawFooter()
                              ],
                            ),
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
