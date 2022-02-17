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
  SmsController _smsController = Get.find();
  List listOfContacts = [];
  List searchListContacts = [];

  int checkedValue;
  @override
  void initState() {
    _smsController.getAllContacts();
    listOfContacts = _smsController.contacts.value;
    setState(() {
      searchListContacts = _smsController.contacts.value;
    });
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
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (value) => _runFilter(value),
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
                            itemCount: searchListContacts.length >= 30
                                ? 30
                                : searchListContacts.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListTile(
                                  onTap: () {
                                    _smsController.selectedMobileNumber.add(
                                        _smsController
                                            .contacts.value[index].displayName);
                                    print(
                                        "my selected contacts is ${_smsController.selectedMobileNumber}");
                                    setState(() {
                                      checkedValue = index;
                                    });
                                  },
                                  title: Text(_smsController
                                      .contacts.value[index].displayName),
                                  trailing: checkedValue == index
                                      ? Container(
                                          height: 20,
                                          width: 20,
                                          child: Center(
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                          ),
                                        )
                                      : Container(
                                          height: 20,
                                          width: 20,
                                          child: Center(
                                            child: Icon(Icons.check),
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                          ),
                                        ),
                                ),
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

  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      results = _smsController.contacts.value;
    } else {
      results = _smsController.contacts.value
          .where((item) => item.displayName
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Refresh the UI
    setState(() {
      searchListContacts = results;
    });
  }
}
