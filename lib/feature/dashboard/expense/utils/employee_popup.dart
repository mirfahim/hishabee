import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/emi/emi_controller.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/emi/new_emi.dart';
import 'package:hishabee_business_manager_fl/models/emi/utils/customer_model.dart';
import 'package:hishabee_business_manager_fl/models/expense/employeModel.dart';

class EmployeePopup extends StatefulWidget {
  Shop shop;

  EmployeePopup({this.shop,});
  @override
  _EmployeePopupState createState() => _EmployeePopupState();
}

class _EmployeePopupState extends State<EmployeePopup> {
  List<EmployeeModel> _list = <EmployeeModel>[];
  List<EmployeeModel> _foundData = <EmployeeModel>[];
  ExpenseController _controller = Get.find();
  // Shop shop = Get.arguments;
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int flag = 1;
    return SingleChildScrollView(
      child: AlertDialog(
        content: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
                    child: TextField(
                      onChanged: (value) => _runFilter(value),
                      style: TextStyle(fontSize: 14.0),
                      decoration: InputDecoration(
                          hintText: 'search'.tr,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Colors.blue[900])),
                          hintStyle: TextStyle(fontSize: 12.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.blue[900])),
                          filled: true,
                          fillColor: Colors.grey[100],
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.blue[900],
                            size: 30,
                          )),
                    )),
                Container(
                  width: MediaQuery.of(context).size.width/ 1,
                  height: MediaQuery.of(context).size.height - 300,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _foundData.length,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          // _controller.nameController.text = _foundData[index].name.toString();
                          _controller.employeeNameController.text = _foundData[index].name.toString();
                          Navigator.pop(context);
                        },


                        // Get.to(NewEmi(
                        // _foundData[index].name.toString(),
                        // _foundData[index].mobile.toString(),
                        // _foundData[index].address.toString(),
                        // ""), arguments: shop),
                        // Navigator.of(context).pushReplacement(
                        //     MaterialPageRoute(
                        //     builder: (builder) => NewEmi(
                        //         _foundData[index].name.toString(),
                        //         _foundData[index].mobile.toString(),
                        //         _foundData[index].address.toString(),
                        //         "",widget.shop, widget.emiMoney)),
                        // ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  _foundData[index].name +
                                      "(" +
                                      _foundData[index].mobile +
                                      ")",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0),
                                )),
                            Divider()
                          ],
                        ),
                      )),
                )

                ////,
                ,
              ]),
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<EmployeeModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = _list;
    } else {
      results = _list
          .where((item) =>
          item.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Refresh the UI
    setState(() {
      _foundData = results;
    });
  }

  void getData() {
    _controller.fetchEmployee(shopId: '${widget.shop.id}').then((value) {
      if (value != null) {
        setState(() {
          _list = employeeModelFromJson(value);
          _foundData = _list;
          // checkingDone = true;
        });
      }

      //  isLoading = false;
    });
  }
}
