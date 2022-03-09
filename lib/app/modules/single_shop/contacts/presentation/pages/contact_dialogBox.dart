import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/manager/add_contact_controller.dart';
class ContactBox extends StatefulWidget {

  @override
  _ContactBoxState createState() => _ContactBoxState();
}


class _ContactBoxState extends State<ContactBox> {
  AddContactsController _addContactsController = Get.find();


  @override
  void initState() {
    _addContactsController.getAllContacts();
    setState(() {
      _addContactsController.searchListContact.value = _addContactsController.contactList.value;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // print("my contact list is ${_smsController.contacts.value.length}");
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
                    child: _addContactsController.contactList.length == 0
                        ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
                        : ListView.builder(
                      itemCount:  _addContactsController.searchListContact.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            onTap: () {
                              // searchListContact.selectedMobileNumber.add(
                              //     _smsController
                              //         .contacts.value[index].displayName);
                              // print(
                              //     "my selected contacts is ${_smsController.selectedMobileNumber}");
                              // setState(() {
                              //   checkedValue = index;
                              // });
                              _addContactsController.nameController.text = _addContactsController.searchListContact[index].displayName;
                              _addContactsController.mobileController.text = _addContactsController.searchListContact[index].phones.first.value.toString();
                              _addContactsController.name.value = _addContactsController.searchListContact[index].displayName;
                              _addContactsController.mobile.value = _addContactsController.searchListContact[index].phones.first.value.toString();
                              print(_addContactsController.name.value);
                              print(_addContactsController.mobile.value);
                              Get.back();
                            },
                            title: Text(_addContactsController.searchListContact[index].displayName),
                            // trailing: checkedValue == index
                            //     ? Container(
                            //   height: 20,
                            //   width: 20,
                            //   child: Center(
                            //     child: Icon(
                            //       Icons.check,
                            //       size: 12,
                            //       color: Colors.blue,
                            //     ),
                            //   ),
                            //   decoration: BoxDecoration(
                            //     color: Colors.blue,
                            //     border: Border.all(),
                            //   ),
                            // )
                            //     : Container(
                            //   height: 20,
                            //   width: 20,
                            //   child: Center(
                            //     child: Icon(
                            //       Icons.check,
                            //       size: 12,
                            //     ),
                            //   ),
                            //   decoration: BoxDecoration(
                            //     border: Border.all(),
                            //   ),
                            // ),
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
      results = _addContactsController.contactList.value;
    } else {
      results = _addContactsController.contactList.value
          .where((item) => item.displayName
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Refresh the UI
    setState(() {
      _addContactsController.searchListContact.value = results;
    });
  }
}
