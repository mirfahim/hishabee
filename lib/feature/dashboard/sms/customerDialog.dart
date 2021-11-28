import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/controllers/sms/sms_controller.dart';
import 'package:hishabee_business_manager_fl/models/sms/sms_package_model.dart';

class SmsCustomCustomerDialogContacts extends StatefulWidget {
  @override
  State<SmsCustomCustomerDialogContacts> createState() =>
      _SmsCustomCustomerDialogContactsState();
}

class _SmsCustomCustomerDialogContactsState
    extends State<SmsCustomCustomerDialogContacts> {
  List<Customer> customerContact = [];
  var storageSms = GetStorage('sms');
  @override
  void initState() {
    _smsController
        .getAllCustomerContact('${storageSms.read("shop_id")}')
        .then((value) {
      setState(() {
        customerContact = getCustomerContactFromModel(value);
      });
    });
    super.initState();
  }

  SmsController _smsController = Get.find();

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.white,
      child: _buildChild(context, height, width),
    );
  }

  _buildChild(BuildContext context, double height, double width) => Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Text('Contact List'),
              ),
              SizedBox(
                height: 10,
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
              Container(
                height: height - 300,
                child: ListView.builder(
                  itemCount: customerContact.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, index) => Container(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        _smsController.selectedMobileNumber
                            .add('\"${customerContact[index].mobile}\"');
                        print('customer number');
                        print(_smsController.selectedMobileNumber);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${customerContact[index].name}(${customerContact[index].mobile})'),
                          Divider(
                            thickness: 2,
                            color: Colors.grey.withOpacity(.35),
                          )
                        ],
                      ),
                    ),
                  )),
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
                          // Get.back();
                          Navigator.pop(context);
                          // Future.delayed(Duration.zero, () async {
                          //   Navigator.pop(context);
                          // });
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
      );
}
