import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/models/expense_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/presentation/manager/expense_list_controller.dart';
import 'package:intl/intl.dart';

class ExpenseListPage extends GetView<ExpenseListController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Stack(
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
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          'expense_list'.tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 70.0,
                      left: 15,
                      right: 30,
                    ),
                    child: Obx(
                      () => Text(
                        controller.shop.value.name,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: DEFAULT_BLACK,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 110.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  _selectStartDate(context);
                                },
                                child: Container(
                                  width: size.width * 0.4,
                                  height: 45,
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Obx(
                                          () => Text(
                                            "${controller.selectedStartDate.value != null ? DateFormat("dd-MM-yyyy").format(controller.selectedStartDate.value) : "Start Date"}",
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              // fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: DEFAULT_BLACK,
                                              letterSpacing: 1.1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "To",
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _selectEndDate(context);
                                  controller.getRangeExpenses();
                                },
                                child: Container(
                                  width: size.width * 0.4,
                                  height: 45,
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Obx(
                                          () => Text(
                                            "${controller.selectedEndDate.value != null ? DateFormat("dd-MM-yyyy").format(controller.selectedEndDate.value) : "End Date"}",
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: DEFAULT_BLACK,
                                              letterSpacing: 1.1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 160, left: 15, right: 15, bottom: 20),
                    child: Container(
                      height: size.height * 0.7,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Obx(
                        () => MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            itemCount: controller.filteredExpenseList.length,
                            itemBuilder: (BuildContext context, int index) {
                              ExpenseResponseModel model =
                                  controller.filteredExpenseList[index];
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.grey),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            width: size.width * 0.2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  model.type,
                                                  style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: DEFAULT_BLUE,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${DateFormat("dd MMM yyyy").format(model.createdAt)}",
                                                  style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: DEFAULT_BLACK,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: size.width * 0.3,
                                            child: Center(
                                              child: Text(
                                                model.details != null
                                                    ? model.details
                                                    : '',
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: DEFAULT_BLACK,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            width: size.width * 0.26,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20.0),
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  '${model.amount} /=',
                                                  style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: DEFAULT_BLUE,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "total_colon".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Obx(
                          () => Text(
                            "tk".tr + "  ${controller.tExpense} /=",
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 18,
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
    );
  }

  _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != controller.selectedStartDate.value) {
      controller.selectedStartDate.value = picked;
    }
    _selectEndDate(context);
  }

  _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != controller.selectedEndDate.value) {
      controller.selectedEndDate.value = picked;
    }
    controller.getRangeExpenses();
  }

  Widget getTransactions() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(
                0,
                3,
              ), // changes position of shadow
            ),
          ],
        ),
        /*child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "12 November 2020 |",
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      color: default_black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "10:38 PM",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Rubik',
                      color: default_black,
                    ),
                  ),
                ],
              ),
              Text(
                "3 items",
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.bold,
                  color: default_blue,
                ),
              ),
              Text(
                "99,000/=",
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.bold,
                  color: Colors.green[400],
                ),
              )
            ],
          ),
        ),*/
      ),
    );
  }
}
