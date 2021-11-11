import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/presentation/manager/add_expense_controller.dart';

class RentPage extends GetView<AddExpenseController> {
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
                    MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView(
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
                                      'rent'.tr,
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 70.0,
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
                                  left: 15,
                                  right: 15,
                                  top: 100.0,
                                ),
                                child: Form(
                                  key: controller.rentFormKey,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: size.width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: size.width,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "rent_for".tr,
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
                                                          color: Colors.grey),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0),
                                                      child: TextFormField(
                                                        validator: (value) {
                                                          if (value.isEmpty) {
                                                            return 'Please enter note';
                                                          }
                                                          return null;
                                                        },
                                                        onChanged: (value) {
                                                          controller.purpose
                                                              .value = value;
                                                        },
                                                        // keyboardType: TextInputType.number,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          enabledBorder:
                                                              InputBorder.none,
                                                          hintText: "Rent For",
                                                          hintStyle: TextStyle(
                                                            fontFamily: 'Rubik',
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
                                                  Text(
                                                    "details_optional".tr,
                                                    style: TextStyle(
                                                      fontFamily: 'Rubik',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLACK,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Container(
                                                    height: 85,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.grey),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0),
                                                      child: TextField(
                                                        onChanged: (value) {
                                                          controller.details
                                                              .value = value;
                                                        },
                                                        // keyboardType: TextInputType.number,
                                                        minLines: 1,
                                                        maxLines: 5,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          enabledBorder:
                                                              InputBorder.none,
                                                          hintText: "Details",
                                                          hintStyle: TextStyle(
                                                            fontFamily: 'Rubik',
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
                                horizontal: 15.0, vertical: 40),
                            child: getDefaultBlueButton(context, "save".tr,
                                () async {
                              //addRent();
                              if (controller.rentFormKey.currentState
                                  .validate()) {
                                controller.rentFormKey.currentState.save();
                                await controller.addExpense("Rent");
                                CustomDialog.showStringDialog(
                                    controller.result.value.message);
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
        ),
      ),
    );
  }
}
