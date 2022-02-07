import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/manager/splash_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/data_sources/shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/controllers/sms/sms_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/sms/emplyeDialog.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/sms/sms_dialog_box.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/sms/sms_packages.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/sms/sms_page.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/sms/supplyerDialog.dart';
import 'package:hishabee_business_manager_fl/models/sms/sms_package_model.dart';
import 'package:hishabee_business_manager_fl/new_UI/expense_list/helper_for_dialog.dart';

import 'customerDialog.dart';

class SmsCreatePage extends GetResponsiveView {
  final TextEditingController messageController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  SmsController _smsController = Get.find();
  Shop shop = Get.arguments['shop'];
  var storageSms = GetStorage('sms');
  var storageSmsCount = GetStorage('sms_count');

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    _smsController.totalSmsLeft.value =
        storageSmsCount.read('sms_count') == null
            ? shop.smsCount
            : storageSmsCount.read('sms_count');
    storageSms.write("shop_id", shop.id);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back),
            ),
            backgroundColor: Colors.amber,
            title: Text('SMS'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: GestureDetector(
                  onTap: () {
                    Get.to(SmsHistory(), arguments: {'shop': shop});
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.history),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Message History')
                    ],
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Column(
                children: [
                  Obx(() {
                    return SizedBox(
                      height: _smsController.selectedMobileNumber.length <= 0
                          ? 0
                          : 60,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount:
                                _smsController.selectedMobileNumber.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(_smsController
                                                .selectedMobileNumber[index]),
                                            IconButton(
                                              onPressed: () {
                                                _smsController
                                                    .selectedMobileNumber
                                                    .removeWhere((item) =>
                                                        item ==
                                                        _smsController
                                                                .selectedMobileNumber[
                                                            index]);
                                              },
                                              icon: Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                              ),
                                              iconSize: 16,
                                              padding: EdgeInsets.all(0),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    );
                  }),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextField(
                              onChanged: (number) {
                                _smsController.mobileNumbers.value = number;
                                if (numberController.text.length == 11) {
                                  _smsController.visibility.value = true;
                                } else if (numberController.text.length > 11 ||
                                    numberController.text.length < 11) {
                                  _smsController.visibility.value = false;
                                }
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]'),
                                ),
                              ],
                              keyboardType: TextInputType.number,
                              controller: numberController,
                              decoration: InputDecoration(
                                labelText: 'Mobile Number',
                                labelStyle: TextStyle(color: Colors.black),
                                focusColor: Colors.black,
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.call,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Obx(() => Visibility(
                              visible: _smsController.visibility.value,
                              child: Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (!numberController.text.isEmpty) {
                                        _smsController.selectedMobileNumber.add(
                                            '\"${numberController.text}\"');
                                        numberController.clear();
                                        _smsController.visibility.value = false;
                                        print(_smsController
                                            .selectedMobileNumber);
                                      }
                                    },
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.black),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Text(
                    'Get Number From',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              Future.delayed(Duration.zero, () async {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (context, _, __) =>
                                        SmsCustomCustomerDialogContacts(),
                                    opaque: false));
                              });
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.people,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'Customer',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                )
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1, color: Colors.black),
                              primary: Colors.white,
                              fixedSize: Size(140, 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              Future.delayed(Duration.zero, () async {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (context, _, __) =>
                                        SmsCustomEmployeDialogContacts(),
                                    opaque: false));
                              });
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.people,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'Employee',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                )
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1, color: Colors.black),
                              primary: Colors.white,
                              fixedSize: Size(140, 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              Future.delayed(Duration.zero, () async {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (context, _, __) =>
                                        SmsCustomSupplyerDialogContacts(),
                                    opaque: false));
                              });
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.people,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'Supplier',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                )
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1, color: Colors.black),
                              primary: Colors.white,
                              fixedSize: Size(140, 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: ElevatedButton(
                      onPressed: () async {

                        await _smsController.getAllContacts();
                        Future.delayed(Duration.zero, () async {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (context, _, __) =>
                                  SmsCustomDialogContacts(),
                              opaque: false));
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.contacts,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Import from contacts',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(width: 1, color: Colors.black),
                        primary: Colors.white,
                        fixedSize: Size(width, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Obx(() {
                      return TextField(
                        controller: messageController,
                        onChanged: (text) {
                          // setState(() {
                          _smsController.textInTheMessageField.value = text;
                          // });
                          RegExp exp = RegExp("[A-Za-z0-9]");
                          if (exp.hasMatch(text.substring(0)) &&
                              text.substring(0) != " ") {
                            // setState(() {
                            _smsController.maxLengthForText.value = 160;
                            // });
                            if ((text.length / 160) <= 1) {
                              // setState(() {
                              _smsController.messageCount.value = 1;
                              // });
                            } else if ((text.length / 160) > 1 &&
                                (text.length / 160) < 2) {
                              // setState(() {
                              _smsController.messageCount.value = 2;
                              // });
                            } else if ((text.length / 160) > 2 &&
                                (text.length / 160) < 3) {
                              // setState(() {
                              _smsController.messageCount.value = 3;
                              // });
                            }
                          } else {
                            // setState(() {
                            _smsController.maxLengthForText.value = 70;
                            // });
                            if ((text.length / 70) <= 1) {
                              // setState(() {
                              _smsController.messageCount.value = 1;
                              // });
                            } else if ((text.length / 70) > 1 &&
                                (text.length / 70) < 2) {
                              // setState(() {
                              _smsController.messageCount.value = 2;
                              // });
                            } else if ((text.length / 70) > 2 &&
                                (text.length / 70) < 3) {
                              // setState(() {
                              _smsController.messageCount.value = 3;
                              // });
                            }
                          }
                        },
                        // maxLength: maxLengthForText,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          helperText:
                              '${_smsController.textInTheMessageField.value.length} Characters | ${_smsController.messageCount.value} Messages | (${_smsController.maxLengthForText.value}/1 messages)',
                          labelText: 'Message',
                          labelStyle: TextStyle(color: Colors.black),
                          focusColor: Colors.black,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _smsController.createSms(
                            shopId: '${storageSms.read("shop_id")}',
                            number: "${_smsController.selectedMobileNumber}",
                            message:
                                "${_smsController.textInTheMessageField.value}",
                            smsCount: '${_smsController.messageCount.value} ');
                        // numberController.clear();
                        await smsCount();
                        await smsCount();
                        messageController.clear();
                        _smsController.textInTheMessageField.value = '';
                        _smsController.messageCount.value = 1;
                        _smsController.selectedMobileNumber.value = [];
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Send Messages',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(width: 1, color: Colors.black),
                        primary: Colors.black,
                        fixedSize: Size(width, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                          SMSPackages(),
                          // arguments: {'shop': shop}
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Buy SMS',
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                          Obx(() => Text(
                                '${_smsController.totalSmsLeft.value}',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ))
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(width: 1, color: Colors.blue),
                        primary: Colors.white,
                        fixedSize: Size(110, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<dynamic> smsCount() async {
    var data =
        await _smsController.checkSubcription('${storageSms.read("shop_id")}');
    _smsController.totalSmsLeft.value = await data['shop']['sms_count'];
    storageSmsCount.write("sms_count", data['shop']['sms_count']);
    print('SMS left - ${_smsController.totalSmsLeft.value}');
  }
}
