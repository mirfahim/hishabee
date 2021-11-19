import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/controllers/emi/emi_controller.dart';
import 'package:hishabee_business_manager_fl/models/emi/utils/customer_model.dart';

class CustomerPopup extends StatefulWidget {
  @override
  _CustomerPopupState createState() => _CustomerPopupState();
}

class _CustomerPopupState extends State<CustomerPopup> {
  List<CustomerModel> _list = <CustomerModel>[];
  List<CustomerModel> _foundData = <CustomerModel>[];
  EmiController controller = Get.find();
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
      content: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 4.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding:
                                const EdgeInsets.only(bottom: 12.0, top: 12.0),
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
                                        borderRadius:
                                            BorderRadius.circular(6.0),
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
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: _foundData.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
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
                                ))

                        ////,
                        ,
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<CustomerModel> results = [];
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
    controller.fetchCustomer(shopId: "").then((value) {
      if (value != null) {
        setState(() {
          _list = customerModelFromJson(value);
          _foundData = _list;
          // checkingDone = true;
        });
      }

      //  isLoading = false;
    });
  }
}
