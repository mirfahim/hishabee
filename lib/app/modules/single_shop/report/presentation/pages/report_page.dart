import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/overlay_youtube_video.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/_bindings/expense_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/presentation/pages/expense_list_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/report/presentation/manager/report_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/report/presentation/widgets/custom_card_container.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/report/presentation/widgets/expenses_pie_chart.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/report/presentation/widgets/sale_line_chart.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/report/presentation/widgets/sale_vs_expenses_bar_chart.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/_bindings/transactions_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/pages/transactions_page.dart';

class ReportPage extends GetView<ReportController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
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
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: DEFAULT_BLACK,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    Expanded(
                      child: Text(
                        'reports'.tr,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: DEFAULT_BLACK,
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.contact_support,
                          size: 35,
                          color: DEFAULT_BLUE,
                        ),
                        onPressed: () {
                          final String url =
                              "https://www.youtube.com/watch?v=F6HEZXXkotg&list=PLO7C_xRyL47emWQfUcp2-djjzgdlPGcqS&index=13";
                          final String title = "report_page_showcase".tr;
                          Navigator.of(context)
                              .push(TutorialOverlay(url, title));
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 80.0,
                  left: 15,
                ),
                child: Obx(
                  () => Text(
                    '${controller.shop.value.name}',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 110.0,
                      // right: 10,
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          () => TransactionPage(),
                          arguments: {"shop": controller.shop.value},
                          binding: TransactionsBinding(),
                        );
                      },
                      child: CustomCardContainer(
                        width: double.infinity,
                        height: 140,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "today_s_sale".tr,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Obx(
                              () => Text(
                                "tk".tr +
                                    " ${controller.todaysSale.value}" +
                                    " /=",
                                style: TextStyle(
                                    color: DEFAULT_BLUE,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 0.2,
                              color: Colors.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: "today_s_net_profit".tr,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Rubik',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "tk".tr,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: DEFAULT_BLUE,
                                            fontSize: 12,
                                          ),
                                        ),
                                        TextSpan(
                                          text: " 2500",
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: DEFAULT_BLUE,
                                            fontSize: 12,
                                          ),
                                        ),
                                        TextSpan(
                                          text: " /=",
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: DEFAULT_BLUE,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "transaction_report".tr,
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      color: DEFAULT_BLUE,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, right: 0),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => ExpenseListPage(),
                            arguments: {"shop": controller.shop.value},
                            binding: ExpenseBinding());
                      },
                      child: CustomCardContainer(
                        width: double.infinity,
                        height: 140,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "today_s_expense".tr,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => RichText(
                                    text: TextSpan(
                                        text: "tk".tr,
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLUE,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                " ${controller.todaysExpense.value}",
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: DEFAULT_BLUE,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " /=",
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: DEFAULT_BLUE,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 0.2,
                              color: Colors.black,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, top: 8),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "expense_report".tr,
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    color: DEFAULT_BLUE,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        () => TransactionPage(),
                        arguments: {"shop": controller.shop.value},
                        binding: TransactionsBinding(),
                      );
                    },
                    child: Container(
                      child: SaleLineChart(
                        animate: true,
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(() => ExpenseListPage(),
                            arguments: {"shop": controller.shop.value},
                            binding: ExpenseBinding());
                      },
                      child: Container(child: ExpensesPieChart())),
                  SaleVsExpenseBarChart(
                    animate: true,
                  ),
                ],
              ),
              Positioned(
                right: 40,
                top: 20,
                child: Obx(
                  () => OpacityAnimatedWidget.tween(
                    opacityEnabled: 1, //define start value
                    opacityDisabled: 0, //and end value
                    enabled: controller.showCase.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: DEFAULT_BLACK,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "report_page_showcase".tr,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
