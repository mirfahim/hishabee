import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sms_service/presentation/manager/get_all_sms_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sms_service/presentation/pages/package_page.dart';
import 'package:hishabee_business_manager_fl/controllers/sms/sms_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/sms/sms_page.dart';
import 'package:hishabee_business_manager_fl/models/sms/sms_package_model.dart';

class SmsCreatePage extends GetResponsiveView {
  final TextEditingController messageController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  SmsController _smsController = SmsController();
  // RxInt maxLengthForText = 160.obs;
  // final textInTheMessageField = ''.obs;
  // RxInt messageCount = 1.obs;
  // final SMSController controller;
  //
  // SmsPage({@required this.controller});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
                    Get.to(SmsHistory());
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
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (number) {
                      _smsController.mobileNumbers.value = number;
                    },
                    keyboardType: TextInputType.number,
                    controller: numberController,
                    decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        focusColor: Colors.black,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        prefixIcon: Icon(
                          Icons.call,
                          color: Colors.grey,
                        )),
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
                          onPressed: () {},
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
                            side:
                                const BorderSide(width: 1, color: Colors.black),
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
                          onPressed: () {},
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
                            side:
                                const BorderSide(width: 1, color: Colors.black),
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
                          onPressed: () {},
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
                            side:
                                const BorderSide(width: 1, color: Colors.black),
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
                    onPressed: () {},
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
                        focusColor: Colors.black,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black),
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
                    onPressed: () {
                      _smsController.createSms(
                          shopId: '105',
                          number: "01761685693",
                          message: "I am Nehal",
                          smsCount: '1');
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
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Buy SMS',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                        Text(
                          'SMS left - 30',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        )
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
          )),
    );
  }
}
