import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/_bindings/expense_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/presentation/manager/expense_page_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/presentation/pages/pay_salary_page.dart';

import 'bill_page.dart';
import 'expense_list_page.dart';
import 'inventory_page.dart';
import 'other_page.dart';
import 'rent_page.dart';

class ExpensesPage extends GetView<ExpensePageController> {
  final Shop shop;

  ExpensesPage({
    this.shop,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 15),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 25,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Text(
                    'expense'.tr,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: DEFAULT_BLACK,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(
                        Icons.contact_support,
                        size: 35,
                        color: DEFAULT_BLUE,
                      ),
                      onPressed: () {
                        controller.trainingVideoOpen(context);
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 65.0,
              ),
              child: Text(
                shop.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: DEFAULT_BLACK,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 100.0,
              ),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        onPressed: () {
                          Get.to(() => ExpenseListPage(),
                              arguments: {"shop": shop},
                              binding: ExpenseBinding());
                        },
                        child: Text(
                          "expense_list".tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        "add_new_expense".tr,
                        style: TextStyle(
                          color: DEFAULT_BLACK,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeBottom: true,
                        child: ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => PaySalaryPage(),
                                    arguments: {"shop": shop},
                                    binding: ExpenseBinding());
                              },
                              child: Container(
                                height: 45,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          "pay_salary".tr,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                      ),
                                      Icon(Icons.arrow_forward_ios),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => InventoryPage(),
                                    arguments: {"shop": shop},
                                    binding: ExpenseBinding());
                              },
                              child: Container(
                                height: 45,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          "new_inventory".tr,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                      ),
                                      Icon(Icons.arrow_forward_ios),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => BillPage(),
                                    arguments: {"shop": shop},
                                    binding: ExpenseBinding());
                              },
                              child: Container(
                                height: 45,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          "utility_bill".tr,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                      ),
                                      Icon(Icons.arrow_forward_ios)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => RentPage(),
                                    arguments: {"shop": shop},
                                    binding: ExpenseBinding());
                              },
                              child: Container(
                                height: 45,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          "rent".tr,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                      ),
                                      Icon(Icons.arrow_forward_ios)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => OtherExpensesPage(),
                                    arguments: {"shop": shop},
                                    binding: ExpenseBinding());
                              },
                              child: Container(
                                height: 45,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8),
                                        child: Text(
                                          "other".tr,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                      ),
                                      Icon(Icons.arrow_forward_ios)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => controller.showCaseTap.value == true
                  ? Positioned(
                      right: 50,
                      top: 20,
                      child: Obx(
                        () => OpacityAnimatedWidget.tween(
                          opacityEnabled: 1, //define start value
                          opacityDisabled: 0, //and end value
                          enabled: controller.showCase.value,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: DEFAULT_BLACK,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "expense_page_showcase".tr,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.play_arrow_sharp,
                                  size: 30,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
