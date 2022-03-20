import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/presentation/manager/add_expense_controller.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:intl/intl.dart';
// import 'package:month_picker_dialog/month_picker_dialog.dart';

// import 'package:month_picker_dialog/month_picker_dialog.dart';

class PaySalaryPage extends GetView<AddExpenseController> {
  @required
  final String type;

  PaySalaryPage({
    this.type,
  });

  var startDate = DateTime.now().obs;
  ExpenseController _expenseController = Get.put(ExpenseController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'paySalary'.tr,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          backgroundColor: DEFAULT_BODY_BG_COLOR,
          body: SafeArea(
            child: !controller.paying.value
                ? Stack(
                    children: [
                      ListView(
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10.0,
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
                                                      BorderRadius.circular(4),
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
                                                          const EdgeInsets.only(
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
                                                            fontFamily: 'Rubik',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                DEFAULT_BLACK,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
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
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0),
                                                      child: TextField(
                                                        // keyboardType: TextInputType.number,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          enabledBorder:
                                                              InputBorder.none,
                                                          hintText: "Note",
                                                          hintStyle: TextStyle(
                                                            fontFamily: 'Rubik',
                                                            fontSize: 16,
                                                            color:
                                                                Colors.blueGrey,
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
                                                  // Text(
                                                  //   "month".tr,
                                                  //   style: TextStyle(
                                                  //     fontFamily: 'Rubik',
                                                  //     fontSize: 16,
                                                  //     fontWeight:
                                                  //         FontWeight.bold,
                                                  //     color: DEFAULT_BLACK,
                                                  //   ),
                                                  // ),
                                                  // SizedBox(
                                                  //   height: 15,
                                                  // ),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //
                                                  //   },
                                                  //   child: Container(
                                                  //     height: 50,
                                                  //     decoration: BoxDecoration(
                                                  //       color: Colors.white,
                                                  //       borderRadius:
                                                  //           BorderRadius
                                                  //               .circular(4),
                                                  //       border: Border.all(
                                                  //           width: 1,
                                                  //           color: Colors.grey),
                                                  //     ),
                                                  //     child: Row(
                                                  //       mainAxisAlignment:
                                                  //           MainAxisAlignment
                                                  //               .spaceBetween,
                                                  //       children: [
                                                  //         Padding(
                                                  //           padding:
                                                  //               const EdgeInsets
                                                  //                       .only(
                                                  //                   left: 15.0),
                                                  //           child: Obx(
                                                  //             () => Text(
                                                  //               controller
                                                  //                   .month.value
                                                  //                   .toUpperCase(),
                                                  //               style:
                                                  //                   TextStyle(
                                                  //                 fontFamily:
                                                  //                     'Rubik',
                                                  //                 fontSize: 16,
                                                  //                 fontWeight:
                                                  //                     FontWeight
                                                  //                         .bold,
                                                  //                 color:
                                                  //                     DEFAULT_BLACK,
                                                  //               ),
                                                  //             ),
                                                  //           ),
                                                  //         ),
                                                  //         Padding(
                                                  //           padding:
                                                  //               const EdgeInsets
                                                  //                       .only(
                                                  //                   right:
                                                  //                       12.0),
                                                  //           child: Icon(Icons
                                                  //               .arrow_drop_down),
                                                  //         ),
                                                  //       ],
                                                  //     ),
                                                  //   ),
                                                  // ),
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
                                                            fontFamily: 'Rubik',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                            color: Colors.white,
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
                                                                    left: 15.0),
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
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _showPictureOptionDialogue();
                                                    },
                                                    child: (controller
                                                                .image.value ==
                                                            null)
                                                        ? Container(
                                                            // height: 50,
                                                            // width: 50,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black)),
                                                            child: Icon(Icons
                                                                .camera_alt),
                                                          )
                                                        : Image.file(
                                                            controller
                                                                .image.value,
                                                            alignment: Alignment
                                                                .topLeft,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: 50,
                                                          ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    getDialog();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 3,
                                                          vertical: 7),
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons
                                                              .calendar_today),
                                                          Obx(
                                                            () => Text(
                                                                '${DateFormat.yMMMMd().format(startDate.value)}'),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showPictureOptionDialogue() {
    final AddExpenseController controller = Get.find();

    try {
      if (Platform.isIOS) {
        showDialog(
            context: Get.context,
            builder: (_) => CupertinoAlertDialog(
                  title: Text("Picture option"),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          ImageHelper.getImageFromCamera().then((value) {
                            controller.image.value = value;
                            navigator.pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                  height: 80,
                                  image: AssetImage('images/icons/camera.png'),
                                ),
                                Text("Camera")
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //getImageFromGallery(option);
                          ImageHelper.getImageFromGallery().then((value) {
                            controller.image.value = value;
                            navigator.pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                  height: 80,
                                  image: AssetImage('images/icons/gallery.png'),
                                ),
                                Text("Gallery")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Close'),
                      onPressed: () {
                        navigator.pop();
                      },
                    )
                  ],
                ));
      } else {
        showDialog(
            context: Get.context,
            builder: (_) => AlertDialog(
                  title: Text("Picture option"),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          ImageHelper.getImageFromCamera().then((value) {
                            controller.image.value = value;
                            navigator.pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                  height: 80,
                                  image: AssetImage('images/icons/camera.png'),
                                ),
                                Text("Camera")
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //getImageFromGallery(option);
                          ImageHelper.getImageFromGallery().then((value) {
                            controller.image.value = value;
                            navigator.pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                  height: 80,
                                  image: AssetImage('images/icons/gallery.png'),
                                ),
                                Text("Gallery")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Close'),
                      onPressed: () {
                        navigator.pop();
                      },
                    )
                  ],
                ));
      }
    } catch (e) {}
  }

  void getDialog() async {
    await _selectStartDate();
    // await _selectEndDate(context);
    // widgets.controller.getRangeTransaction();
  }

  _selectStartDate() async {
    final DateTime picked = await showDatePicker(
      helpText: "start_date".tr,
      context: Get.context,
      initialDate: startDate.value,
      // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: DEFAULT_BLACK,
              onPrimary: DEFAULT_BODY_BG_COLOR,
              surface: Colors.green,
              onSurface: DEFAULT_BLACK,
            ),
            dialogBackgroundColor: DEFAULT_BODY_BG_COLOR,
          ),
          child: child,
        );
      },
    );
    if (picked != null) {
      startDate.value = picked;
    }
  }
}
