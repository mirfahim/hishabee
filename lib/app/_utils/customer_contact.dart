import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/_binding/contact_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/_navigation/contact_pages.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/_navigation/contact_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/contact_type_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/pages/add_contact_page.dart';
import 'package:hishabee_business_manager_fl/controllers/sms/sms_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/sms/addCustomer.dart';
import 'package:hishabee_business_manager_fl/models/sms/sms_package_model.dart';
import 'package:hishabee_business_manager_fl/service/api_service.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class CustomerContact extends StatefulWidget {
  @override
  State<CustomerContact> createState() =>
      _CustomerContactState();
}

class _CustomerContactState
    extends State<CustomerContact> {
  List<Customer> customerContact = [];
  List<Customer> _foundData = [];
  var storageSms = GetStorage('sms');
  ApiService _apiService = ApiService();
  @override
  void initState() {
    String url = '/customer/all?shop_id=${storageSms.read("shop_id")}';
    var list = _apiService.makeApiRequest(
        method: apiMethods.get, url: url, body: null, headers: null);
    list.then((value) {
      setState(() {
        customerContact = getCustomerContactFromModel(value);
        _foundData = getCustomerContactFromModel(value);
      });
    });
    super.initState();
  }

  // SmsController _smsController = Get.find();

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
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Text('Customer Contact List'),
          ),
          SizedBox(
            height: 10,
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
          Expanded(
            flex: 2,
            child: Container(
              // height: 300,
              child: ListView.builder(
                itemCount: _foundData.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      // _smsController.selectedMobileNumber
                      //     .add('\"${_foundData[index].mobile}\"');
                      // print(_smsController.selectedMobileNumber.length);
                      // print(_smsController.selectedMobileNumber);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${_foundData[index].name}(${_foundData[index].mobile})'),
                        Divider(
                          thickness: 2,
                          color: Colors.grey.withOpacity(.35),
                        )
                      ],
                    ),
                  ),
                ),
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
                    onPressed: () {
                      Get.to(CustomerAdd(shopId: '${storageSms.read("shop_id")}',));
                      // Customer customer = new Customer();
                      // Get.toNamed(ContactRoutes.ADD_CONTACT,
                      //     arguments: {
                      //       'shop': Shop,
                      //       "type": ContactType.CUSTOMER,
                      //       "contact": customer,
                      //     }
                      // );
                    },
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

  void _runFilter(String enteredKeyword) {
    List<Customer> results = [];
    if (enteredKeyword.isEmpty) {
      results = customerContact;
    } else {
      results = customerContact
          .where((item) =>
          item.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Refresh the UI
    setState(() {
      _foundData = results;
    });
  }
}
