// import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
// import 'package:hishabee_business_manager_fl/app/_widgets/desktop_app_bar.dart';
// import 'package:hishabee_business_manager_fl/app/_widgets/desktop_left_menue.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/_bindings/due_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/_naviagtion/due_page_routes.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/_navigation/due_page_routs.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_item_by_uniq_id.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_item_by_unuque_id.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_details_controller.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/new_page/add_new_due.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
import 'package:intl/intl.dart';
import 'package:darq/darq.dart';
import 'add_due_page.dart';
import 'due_item_details.dart';
import 'due_payment_page.dart';

class DueDetailsPage extends GetView<DueDetailsController> {
  var shop;
  var due;
  DueDetailsPage({this.shop, this.due});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height - 62,
              width: size.width,
              child: Stack(
                children: [
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView(
                      children: [
                        Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                        size: 25,
                                        color: DEFAULT_BLUE,
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                    Text(
                                      'due_details'.tr,
                                      style: TextStyle(
                                          fontSize: 16, color: DEFAULT_BLUE),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 40,
                                left: 10,
                                right: 10,
                              ),
                              child: Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: DEFAULT_BLUE,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10, top: 5),
                                            child: Container(
                                              width: 150,
                                              child: Obx(
                                                () => controller.due.value ==
                                                        null
                                                    ? Text(
                                                        // "Contact name",
                                                        "No Data",
                                                        style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    : Text(
                                                        // "Contact name",
                                                        "${controller.due.value.contactName}",
                                                        style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          PopupMenuButton(
                                              onSelected: (value) {
                                                switch (value) {
                                                  case 0:
                                                    Get.defaultDialog(
                                                      title: "Are you sure?",
                                                      content: Text(
                                                          'You want to delete this due record'),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            child: Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                  color:
                                                                      DEFAULT_BLUE),
                                                            )),
                                                        TextButton(
                                                            onPressed: () {
                                                              Get.back();
                                                              controller
                                                                  .deleteDue();
                                                            },
                                                            child: Text(
                                                                'Delete',
                                                                style: TextStyle(
                                                                    color:
                                                                        DEFAULT_BLUE))),
                                                      ],
                                                    );
                                                    break;
                                                }
                                              },
                                              itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                        value: 0,
                                                        child: Text('Delete')),
                                                  ],
                                              child: Icon(
                                                Icons.more_vert,
                                                size: 30,
                                                color: Colors.white,
                                              )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10, top: 5),
                                            child: controller.due.value == null
                                                ? Text(
                                                    // "Contact number",
                                                    "No Data",
                                                    style: TextStyle(
                                                      fontFamily: 'Rubik',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : Text(
                                                    // "Contact number",
                                                    "${controller.due.value.contactMobile}",
                                                    style: TextStyle(
                                                      fontFamily: 'Rubik',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                          ),
                                          Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                String number =
                                                    "tel: ${controller.due.value.contactMobile}";
                                                Utility.launchURL(number);
                                              },
                                              icon: Icon(
                                                Icons.call,
                                                color: Colors.white,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                String number =
                                                    "sms: ${controller.due.value.contactMobile}";
                                                Utility.launchURL(number);
                                              },
                                              icon: Icon(
                                                Icons.sms,
                                                color: Colors.white,
                                              )),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10),
                                        child: Obx(
                                          () => Text(
                                            "${controller.dueLeft.value} " +
                                                "tk".tr,
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, left: 10, right: 10),
                              child: Text(
                                'due_history'.tr,
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text(
                                'Lend',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, right: 20),
                              child: Text(
                                '/Borrow',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10, right: 10, bottom: 100),
                          child: Obx(
                            () => ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.dueItem.length,
                              itemBuilder: (BuildContext context, int index) {
                                GetAllDueItemByUid dueItem =
                                    controller.dueItem[index];
                                return InkWell(
                                  onTap: () {
                                    controller.selectedDueItem.value = dueItem;
                                    Get.toNamed(
                                      DuePageRoutes.DUE_ITEM_DETAILS_PAGE,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: size.height * 0.08,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(4),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 5,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8, left: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: size.width * 0.3,
                                              child: Text(
                                                DateFormat(
                                                        "dd MMM yyyy \nhh:mm")
                                                    .format(dueItem.createdAt),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: DEFAULT_BLACK),
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              "৳ ${dueItem.amount.abs()} /=",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: dueItem.amount > 0
                                                      ? Colors.red
                                                      : Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, bottom: 8),
                              child: InkWell(
                                onTap: () {
                                  GetAllDueItemByUid dueItem =
                                      GetAllDueItemByUid();
                                  Get.toNamed(
                                    DuePageRoutes.ADD_DUE_PAGE,
                                    arguments: {
                                      'shop': controller.shop.value,
                                      "due": controller.due.value,
                                      'dueType': 0,
                                      'route': 1,
                                      'dueItem': dueItem,
                                    },
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  width: size.width * 0.45 - 125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "add_due".tr,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, bottom: 8),
                              child: InkWell(
                                onTap: () {
                                  GetAllDueItemByUid dueItem =
                                      GetAllDueItemByUid();
                                  Get.toNamed(
                                    DuePageRoutes.ADD_DUE_PAGE,
                                    arguments: {
                                      'shop': controller.shop.value,
                                      "due": controller.due.value,
                                      'dueType': 1,
                                      'route': 1,
                                      'dueItem': dueItem,
                                    },
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  width: size.width * 0.45 - 125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.green,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "received_payment".tr,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
