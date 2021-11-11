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
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/_bindings/app_settings_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/pages/set_qr_code_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/_binding/contact_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/contact_type_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/pages/add_contact_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/_bindings/due_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/pages/add_due_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/pages/due_digital_payment_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_bindings/sell_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/confirm_payment_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/sell_digital_payment_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/pages/sell_with_qr_code_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';

class ConfirmPaymentPage extends GetView<ConfirmPaymentController> {
  final bool paying = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      body: SafeArea(
        child: paying
            ? Obx(
                () => Form(
                  key: controller.formKey,
                  child: MediaQuery.removePadding(
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
                            Column(
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
                                        "confirm_payment".tr,
                                        style: TextStyle(
                                          color: DEFAULT_BLACK,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: DEFAULT_BLACK,
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
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
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
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
                                          padding: const EdgeInsets.all(8.0),
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
                                      border: Border.all(color: DEFAULT_BLACK),
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.23),
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
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Container(
                                                width: size.width * 0.3,
                                                child: Text(
                                                  "received".tr,
                                                  style: TextStyle(
                                                    // color: default_yellow,
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
                                                    controller.amountReceived
                                                            .value =
                                                        double.parse(value);
                                                  } catch (e) {}

                                                  print(controller
                                                      .amountReceived.value);

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
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      "tk".tr,
                                                      style: TextStyle(
                                                        color: DEFAULT_BLACK,
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
                                      horizontal: 15.0, vertical: 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: DEFAULT_BLACK),
                                      onPressed: () async {
                                        await controller.addCashTransaction();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 25,
                                                width: 25,
                                                child: SvgPicture.asset(
                                                  'images/svg_image/cash_money.svg',
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                "cash".tr,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Rubik',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 10, bottom: 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: DEFAULT_BLACK),
                                      onPressed: () {
                                        if (controller
                                                .cred.value.user.nidVerified ==
                                            0) {
                                          CustomDialog.showNidVerigyDialog();
                                        } else {
                                          controller.addDigitalTransaction();
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 25,
                                                width: 25,
                                                child: SvgPicture.asset(
                                                  'images/svg_image/digital_payment.svg',
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                "digital_payment".tr,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Rubik',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 10, bottom: 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: DEFAULT_BLACK),
                                      onPressed: () {
                                        Due due = Due(); //TODO fix logic
                                        Get.to(() => AddDuePage(),
                                            binding: DueListBinding(),
                                            arguments: {
                                              "shop": controller.shop.value,
                                              "due": due,
                                            });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 25,
                                                width: 25,
                                                child: SvgPicture.asset(
                                                  'images/svg_image/due.svg',
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                "add_due".tr,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Rubik',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 10, bottom: 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: DEFAULT_BLACK),
                                      onPressed: () {
                                        Transaction transaction = new Transaction(
                                            shopId: controller.shop.value.id,
                                            note: controller.note.value,
                                            employeeName:
                                                controller.employeeName.value,
                                            employeeMobile:
                                                controller.employeeNumber.value,
                                            customerName:
                                                controller.customerName.value,
                                            customerMobile:
                                                controller.customerNumber.value,
                                            customerAddress: controller
                                                .customerAddress.value,
                                            totalDiscount:
                                                controller.totalDiscount.value,
                                            changeAmount: controller
                                                .exchangeAmount.value
                                                .toInt(),
                                            receivedAmount:
                                                controller.amountReceived.value,
                                            createdAt: DateTime.now(),
                                            time: DateTime.now(),
                                            totalPrice:
                                                controller.totalPrice.value,
                                            totalItem: controller
                                                .transactionItems.length,
                                            paymentMethod: 1,
                                            totalVat: 0.0,
                                            transactionItems:
                                                controller.transactionItems);
                                        Get.to(
                                          SellWithQRCodePage(),
                                          arguments: {
                                            "shop": controller.shop.value,
                                            "transaction": transaction,
                                          },
                                          binding: SellBinding(),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 25,
                                                width: 25,
                                                child: SvgPicture.asset(
                                                  'images/svg_image/qr_code.svg',
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                "personal_qr_code".tr,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Rubik',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        "add_note".tr,
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
                                          value: controller.addingNote.value,
                                          onToggle: (value) {
                                            controller.addingNote.value = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                controller.addingNote.value
                                    ? Padding(
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
                                                BorderRadius.circular(10),
                                          ),
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            onSaved: (value) {},
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 10),
                                              border: InputBorder.none,
                                              hintText: 'Add Note',
                                              hintStyle: TextStyle(
                                                fontWeight: FontWeight.w100,
                                                color: Colors.black26,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 10, bottom: 10),
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
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 10,
                                            bottom: 10),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10.0),
                                                    child: Container(
                                                      width: size.width * 0.2,
                                                      child: Text(
                                                        "employee_name".tr,
                                                        style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: DEFAULT_BLACK,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 16.0),
                                                    child: VerticalDivider(
                                                      thickness: 0.6,
                                                      color: DEFAULT_BLACK,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  InkWell(
                                                    onTap: () {
                                                      //_showMaterialDialog(context);
                                                    },
                                                    child: Container(
                                                      width: size.width * 0.58,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: (size.width /
                                                                    2) -
                                                                20,
                                                            child: Obx(
                                                              () =>
                                                                  TextFormField(
                                                                onSaved:
                                                                    (value) {
                                                                  controller
                                                                      .employeeName
                                                                      .value = value;
                                                                },
                                                                controller:
                                                                    ENController,
                                                                // keyboardType: TextInputType.number,
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
                                                                      "Customer Name",
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Rubik',
                                                                    color:
                                                                        DEFAULT_BLACK,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: IconButton(
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
                                                                                padding: const EdgeInsets.only(
                                                                                  top: 18.0,
                                                                                  left: 10,
                                                                                ),
                                                                                child: Text(
                                                                                  "Employee List",
                                                                                  style: TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: DEFAULT_BLACK,
                                                                                    fontSize: 18,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Row(
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
                                                                                height: MediaQuery.of(context).size.height * 0.6,
                                                                                child: Padding(
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
                                                                                alignment: Alignment.bottomRight,
                                                                                child: Row(
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
                                                                                              Get.to(() => AddContactPage(),
                                                                                                  arguments: {
                                                                                                    'shop': controller.shop.value,
                                                                                                    "type": ContactType.EMPLOYEE,
                                                                                                    "contact": employee,
                                                                                                  },
                                                                                                  binding: ContactBinding());
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
                                                                    .arrow_drop_down_circle,
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
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      width: 0.1,
                                                      color: Colors.black),
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
                                                      child: Container(
                                                        width: size.width * 0.2,
                                                        child: Text(
                                                          "mobile".tr,
                                                          style: TextStyle(
                                                            fontFamily: 'Rubik',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                DEFAULT_BLACK,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 16.0),
                                                      child: VerticalDivider(
                                                        thickness: 0.6,
                                                        color: DEFAULT_BLACK,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: size.width * 0.58,
                                                      child: Obx(
                                                        () => TextFormField(
                                                          onSaved: (value) {
                                                            controller
                                                                .employeeNumber
                                                                .value = value;
                                                          },
                                                          controller:
                                                              EMController,
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
                                                            hintText:
                                                                "Employee Mobile Number",
                                                            hintStyle: TextStyle(
                                                                color:
                                                                    DEFAULT_BLACK,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
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
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 10, bottom: 10),
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
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 10,
                                            bottom: 10),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Container(
                                                      width: size.width * 0.2,
                                                      child: Text(
                                                        "customer_name".tr,
                                                        style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: DEFAULT_BLACK,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 16.0),
                                                    child: VerticalDivider(
                                                      thickness: 0.6,
                                                      color: DEFAULT_BLACK,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  InkWell(
                                                    onTap: () {
                                                      //_showMaterialDialog(context);
                                                    },
                                                    child: Container(
                                                      width: size.width * 0.58,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: (size.width /
                                                                    2) -
                                                                20,
                                                            child: Obx(
                                                              () =>
                                                                  TextFormField(
                                                                onSaved:
                                                                    (value) {
                                                                  controller
                                                                      .customerName
                                                                      .value = value;
                                                                },
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
                                                                  hintText: controller
                                                                          .selectedCustomer
                                                                          .value
                                                                          .name ??
                                                                      "Customer Name",
                                                                  hintStyle: TextStyle(
                                                                      color:
                                                                          DEFAULT_BLACK,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                              child: IconButton(
                                                            onPressed: () {
                                                              showDialog(
                                                                context:
                                                                    context,
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
                                                                            const EdgeInsets.only(
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
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.6,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Obx(
                                                                            () =>
                                                                                ListView.builder(
                                                                              shrinkWrap: true,
                                                                              physics: ScrollPhysics(),
                                                                              itemCount: controller.searchCustomerList.length,
                                                                              itemBuilder: (BuildContext context, int index) {
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
                                                                            Alignment.bottomRight,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
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
                                                                                      Customer customer = new Customer();
                                                                                      Get.to(() => AddContactPage(),
                                                                                          arguments: {
                                                                                            'shop': controller.shop.value,
                                                                                            "type": ContactType.CUSTOMER,
                                                                                            "contact": customer,
                                                                                          },
                                                                                          binding: ContactBinding());
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
                                                              /*Get.defaultDialog(
                                                                barrierDismissible:
                                                                    false,
                                                                title:
                                                                    "Select Customer",
                                                                titleStyle:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                content: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      height: size
                                                                              .height *
                                                                          0.67,
                                                                      width: size
                                                                          .width,
                                                                      child: ListView
                                                                          .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemCount: controller
                                                                            .customers
                                                                            .length,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          var customer =
                                                                              controller.customers[index];
                                                                          return ElevatedButton(
                                                                            style: ElevatedButton.styleFrom(
                                                                                primary: Colors.white,
                                                                                onPrimary: Colors.grey,
                                                                                elevation: 0.0),
                                                                            onPressed:
                                                                                () {
                                                                              controller.selectedCustomer.value =
                                                                                  customer;
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment:
                                                                                  CrossAxisAlignment.start,
                                                                              children: [
                                                                                Container(
                                                                                    width: size.width / 2,
                                                                                    child: Text(
                                                                                      "${customer.name}",
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
                                                                  ],
                                                                ),
                                                                actions: <Widget>[
                                                                  TextButton(
                                                                    child: Text(
                                                                        'Close'),
                                                                    onPressed:
                                                                        () {
                                                                      navigator
                                                                          .pop();
                                                                    },
                                                                  )
                                                                ],
                                                              );*/
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .arrow_drop_down_circle,
                                                            ),
                                                          )),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      width: 0.1,
                                                      color: Colors.black),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: size.width * 0.2,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          "mobile".tr,
                                                          style: TextStyle(
                                                            fontFamily: 'Rubik',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                DEFAULT_BLACK,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 16.0),
                                                      child: VerticalDivider(
                                                        thickness: 0.6,
                                                        color: DEFAULT_BLACK,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: size.width * 0.58,
                                                      child: Obx(
                                                        () {
                                                          return TextFormField(
                                                            onSaved: (value) {
                                                              controller
                                                                  .customerNumber
                                                                  .value = value;
                                                            },
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
                                                              hintText: controller
                                                                      .selectedCustomer
                                                                      .value
                                                                      .mobile ??
                                                                  "Customer Mobile",
                                                              hintStyle: TextStyle(
                                                                  color:
                                                                      DEFAULT_BLACK,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      width: 0.1,
                                                      color: Colors.black),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Container(
                                                        width: size.width * 0.2,
                                                        child: Text(
                                                          "address".tr,
                                                          style: TextStyle(
                                                            fontFamily: 'Rubik',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                DEFAULT_BLACK,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 16.0),
                                                      child: VerticalDivider(
                                                        thickness: 0.6,
                                                        color: DEFAULT_BLACK,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: size.width * 0.58,
                                                      child: Obx(
                                                        () => TextFormField(
                                                          onSaved: (value) {
                                                            controller
                                                                .customerAddress
                                                                .value = value;
                                                          },
                                                          onChanged: (value) {},
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
                                                            hintText: controller
                                                                    .selectedCustomer
                                                                    .value
                                                                    .address ??
                                                                "Customer Address",
                                                            hintStyle: TextStyle(
                                                                color:
                                                                    DEFAULT_BLACK,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
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
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        "additional_discount_on_full_amount".tr,
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
                                          value: controller.discount.value,
                                          onToggle: (value) {
                                            controller.discount.value = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                controller.discount.value
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 10,
                                            bottom: 10),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      width: 0.1,
                                                      color: Colors.black),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: Container(
                                                        width: size.width * 0.2,
                                                        child: Text(
                                                          "discount".tr,
                                                          style: TextStyle(
                                                            fontFamily: 'Rubik',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                DEFAULT_BLACK,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 16.0),
                                                      child: VerticalDivider(
                                                        thickness: 0.6,
                                                        color: DEFAULT_BLACK,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: size.width * 0.58,
                                                      child: TextFormField(
                                                        initialValue: controller
                                                            .discountPercent
                                                            .value,
                                                        onChanged: (value) {
                                                          controller
                                                              .discountPercent
                                                              .value = value;

                                                          controller
                                                              .calculateDiscount();
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  right: 15),
                                                          suffix: Text("%"),
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          enabledBorder:
                                                              InputBorder.none,
                                                          hintStyle: TextStyle(
                                                            color:
                                                                Colors.blueGrey,
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
                                                      vertical: 10),
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      width: 0.1,
                                                      color: Colors.black),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: Container(
                                                        width: size.width * 0.2,
                                                        child: Text(
                                                          "tk_discount".tr,
                                                          style: TextStyle(
                                                            fontFamily: 'Rubik',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                DEFAULT_BLACK,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 16.0),
                                                      child: VerticalDivider(
                                                        thickness: 0.6,
                                                        color: DEFAULT_BLACK,
                                                      ),
                                                    ),
                                                    Container(
                                                        width:
                                                            size.width * 0.58,
                                                        child: Obx(
                                                          () => Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          15.0),
                                                              child: Text(
                                                                "${controller.totalDiscount.value} TK",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                  color:
                                                                      DEFAULT_BLACK,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                SizedBox(height: 20),
                              ],
                            )
                          ],
                        ),
                      ],
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
    );
  }
}
