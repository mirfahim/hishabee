import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/controllers/sms/sms_controller.dart';

class SmsCustomDialogContacts extends StatefulWidget {
  @override
  State<SmsCustomDialogContacts> createState() =>
      _SmsCustomDialogContactsState();
}

class _SmsCustomDialogContactsState extends State<SmsCustomDialogContacts> {
  SmsController _smsController = SmsController();
  List listOfContacts = [];
  List searchListContacts = [];
  bool checkedValue = false;
  @override
  void initState() {
    _smsController.getAllContacts();
    listOfContacts = _smsController.contacts.value;
    super.initState();

    ///whatever you want to run on page build.
  }

  Widget build(BuildContext context) {
    print("my contact list is ${_smsController.contacts.value.length}");
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.white,
      child: _buildChild(context, height, width),
    );
  }

  _buildChild(BuildContext context, double height, double width) =>
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            height: 600,
            width: 700,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Text('Contact List'),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: width,
                  decoration: BoxDecoration(
                      color: Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Customer'),
                        Text('Supplier'),
                        Text('Workers')
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    fillColor: Colors.white,
                    label: Text('Search Customer'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Obx(
                  () => Container(
                    height: 400,
                    child: _smsController.contacts.length == 0
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          )
                        : ListView.builder(
                            itemCount:
                                _smsController.contacts.value.length >= 30
                                    ? 30
                                    : _smsController.contacts.value.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, index) {
                              print(
                                  "my contact list is +++ ${_smsController.contacts.value}");
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListTile(
                                  onTap: () {},
                                  title: Text(_smsController
                                      .contacts.value[index].displayName),
                                  trailing: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(),
                                  ),
                                ),
                                // child: GestureDetector(
                                //   onTap: () {
                                //
                                //   },
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(10),
                                //         color: Colors.grey[100]),
                                //     child: CheckboxListTile(
                                //       title: Text(_smsController
                                //           .contacts.value[index].displayName),
                                //       value: checkedValue,
                                //       onChanged: (newValue) {
                                //         setState(() {
                                //           checkedValue = newValue;
                                //           _smsController.selectedMobileNumber
                                //               .add(_smsController.contacts
                                //                   .value[index].displayName);
                                //         });
                                //       },
                                //       controlAffinity: ListTileControlAffinity
                                //           .leading, //  <-- leading Checkbox
                                //     ),
                                //   ),
                                // ),
                              );
                            },
                          ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Future.delayed(Duration.zero, () async {
                              Navigator.pop(context);
                            });
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          child: Text(
                            'Close',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Add Customer'),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
