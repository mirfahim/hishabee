import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/emi/emi_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/emi/new_emi.dart';
import 'package:hishabee_business_manager_fl/models/emi/utils/bank_model.dart';
import 'package:hishabee_business_manager_fl/models/emi/utils/customer_model.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class BankPopup extends StatefulWidget {
  Shop shop;
  String name, address, phone, emiMoney;
  BankPopup(this.name, this.address, this.phone, this.shop, this.emiMoney);
  @override
  _BankPopupState createState() => _BankPopupState();
}

class _BankPopupState extends State<BankPopup> {
  List<BankModel> _list = <BankModel>[];
  List<BankModel> _foundData = <BankModel>[];
  EmiController _controller = Get.find();
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
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
                  child: Container(
                    height: 50.0,
                    child: TextField(
                      onChanged: (value) => _runFilter(value),
                      style: TextStyle(fontSize: 14.0),
                      decoration: InputDecoration(
                          hintText: 'Search',
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
                    ),
                  )),
              Container(
                width: MediaQuery.of(context).size.width/ 1,
                height: MediaQuery.of(context).size.height - 300,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _foundData.length,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            _controller.bankName.value = _foundData[index].name;
                            Navigator.pop(context);
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (builder) => NewEmi(
                            //         widget.name,
                            //         widget.phone,
                            //         widget.address,
                            //         _foundData[index].name, widget.shop, widget.emiMoney)));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    _foundData[index].name,
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
    );
  }

  void _runFilter(String enteredKeyword) {
    List<BankModel> results = [];
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
    _controller.fetchCustomer(shopId: '${widget.shop.id}').then((value) {
      if (value != null) {
        setState(() {
          _list = Utils.bankList;
          _foundData = _list;
          // checkingDone = true;
        });
      }

      //  isLoading = false;
    });
  }
}
