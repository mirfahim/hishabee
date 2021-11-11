import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/presentation/manager/add_expense_controller.dart';
// import 'package:month_picker_dialog/month_picker_dialog.dart';

// import 'package:month_picker_dialog/month_picker_dialog.dart';

class PaySalaryPage extends GetView<AddExpenseController> {
  @required
  final String type;

  PaySalaryPage({
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
          backgroundColor: DEFAULT_BODY_BG_COLOR,
          body: SafeArea(
            child: !controller.paying.value
                ? Stack(
                    children: [
                      Container(
                        height: size.height * 0.2,
                        width: size.width,
                        child: Image.asset(
                          "images/topBg.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
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
                                        'paySalary'.tr,
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
                                    right: 15,
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
                                    left: 15,
                                    right: 15,
                                  ),
                                  child: Form(
                                    key: controller.salaryFormKey,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: size.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "employee_name".tr,
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: DEFAULT_BLACK,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  employeeDialog(context);
                                                },
                                                child: Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.grey),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15.0),
                                                        child: Obx(
                                                          () => Text(
                                                            controller.selectedEmployee
                                                                        .value ==
                                                                    null
                                                                ? "--Select Employee--"
                                                                : controller
                                                                    .selectedEmployee
                                                                    .value
                                                                    .name,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Rubik',
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  DEFAULT_BLACK,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 12.0),
                                                        child: Icon(Icons
                                                            .arrow_drop_down),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                width: size.width,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "add_note".tr,
                                                      style: TextStyle(
                                                        fontFamily: 'Rubik',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DEFAULT_BLACK,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        border: Border.all(
                                                          width: 1,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15.0),
                                                        child: TextField(
                                                          // keyboardType: TextInputType.number,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            focusedBorder:
                                                                InputBorder
                                                                    .none,
                                                            enabledBorder:
                                                                InputBorder
                                                                    .none,
                                                            hintText: "Note",
                                                            hintStyle:
                                                                TextStyle(
                                                              fontFamily:
                                                                  'Rubik',
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .blueGrey,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                width: size.width,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "month".tr,
                                                      style: TextStyle(
                                                        fontFamily: 'Rubik',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DEFAULT_BLACK,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        // {
                                                        //   showMonthPicker(
                                                        //           context:
                                                        //               context,
                                                        //           firstDate: DateTime(
                                                        //               DateTime.now()
                                                        //                       .year -
                                                        //                   1,
                                                        //               5),
                                                        //           lastDate: DateTime(
                                                        //               DateTime.now()
                                                        //                       .year +
                                                        //                   1,
                                                        //               9),
                                                        //           initialDate:
                                                        //               DateTime(DateTime
                                                        //                       .now()
                                                        //                   .year))
                                                        //       .then((date) {
                                                        //     if (date != null) {
                                                        //       controller
                                                        //           .selectedMonth
                                                        //           .value = date;
                                                        //       switch (controller
                                                        //           .selectedMonth
                                                        //           .value
                                                        //           .month) {
                                                        //         case 1:
                                                        //           controller.month
                                                        //                   .value =
                                                        //               "january";
                                                        //           break;
                                                        //         case 2:
                                                        //           controller.month
                                                        //                   .value =
                                                        //               "february";
                                                        //           break;
                                                        //         case 3:
                                                        //           controller.month
                                                        //                   .value =
                                                        //               "march";
                                                        //           break;
                                                        //         case 4:
                                                        //           controller.month
                                                        //                   .value =
                                                        //               "april";
                                                        //           break;
                                                        //         case 5:
                                                        //           controller.month
                                                        //                   .value =
                                                        //               "may";
                                                        //           break;
                                                        //         case 6:
                                                        //           controller.month
                                                        //                   .value =
                                                        //               "june";
                                                        //           break;
                                                        //         case 7:
                                                        //           controller.month
                                                        //                   .value =
                                                        //               "july";
                                                        //           break;
                                                        //         case 8:
                                                        //           controller.month
                                                        //                   .value =
                                                        //               "august";
                                                        //           break;
                                                        //         case 9:
                                                        //           controller.month
                                                        //                   .value =
                                                        //               "september";
                                                        //           break;
                                                        //         case 10:
                                                        //           controller.month
                                                        //                   .value =
                                                        //               "october";
                                                        //           break;
                                                        //         case 11:
                                                        //           controller.month
                                                        //                   .value =
                                                        //               "november";
                                                        //           break;
                                                        //         case 12:
                                                        //           controller.month
                                                        //                   .value =
                                                        //               "december";
                                                        //           break;
                                                        //         default:
                                                        //           controller.month
                                                        //                   .value =
                                                        //               "--Select Month--";
                                                        //           break;
                                                        //       }
                                                        //     }
                                                        //   });
                                                        // ,
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          border: Border.all(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          15.0),
                                                              child: Obx(
                                                                () => Text(
                                                                  controller
                                                                      .month
                                                                      .value
                                                                      .toUpperCase(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Rubik',
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        DEFAULT_BLACK,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          12.0),
                                                              child: Icon(Icons
                                                                  .arrow_drop_down),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      width: size.width,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "amount".tr,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Rubik',
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  DEFAULT_BLACK,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          15.0),
                                                              child:
                                                                  TextFormField(
                                                                onChanged:
                                                                    (value) {
                                                                  if (value ==
                                                                      "") {
                                                                    controller
                                                                        .amount
                                                                        .value = 0;
                                                                  } else {
                                                                    controller
                                                                            .amount
                                                                            .value =
                                                                        int.parse(
                                                                            value);
                                                                  }
                                                                },
                                                                validator:
                                                                    (value) {
                                                                  if (value
                                                                      .isEmpty) {
                                                                    return 'Please enter amount';
                                                                  }
                                                                  return null;
                                                                },
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter
                                                                      .allow(
                                                                    RegExp(
                                                                        '[0-9]'),
                                                                  ),
                                                                ],
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
                                                                  hintText:
                                                                      "Amount",
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Rubik',
                                                                    color: Colors
                                                                        .blueGrey,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 20),
                              child: getDefaultBlueButton(context, "save".tr,
                                  () async {
                                if (controller.salaryFormKey.currentState
                                    .validate()) {
                                  controller.salaryFormKey.currentState.save();
                                  await controller.addNewSalary();
                                }
                              }),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(
                    height: size.height,
                    width: size.width,
                  ),
          )),
    );
  }

  employeeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(18.0),
        child: new Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 18.0,
                  left: 10,
                ),
                child: Text(
                  "Select Employee",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 60,
                      child: TextField(
                        cursorColor: DEFAULT_BLACK,
                        onChanged: (value) {
                          controller.searchEmployee(value);
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: DEFAULT_BLACK),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: DEFAULT_BLACK),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: DEFAULT_BLUE,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: controller.searchEmployeeList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var employeeList = controller.searchEmployeeList;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.selectedEmployee.value =
                                    employeeList[index];

                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${employeeList[index].name} ( ${employeeList[index].mobile} )",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: DEFAULT_BLACK,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Divider(
                              color: DEFAULT_BLACK,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "close".tr,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
