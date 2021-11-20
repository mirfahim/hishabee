import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/emi/utils/customer_popup.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class NewEmi extends StatefulWidget {
  String name = "testing";
  String mobile;
  String address;
  String bank;
  NewEmi(this.name, this.mobile, this.address, this.bank);

  @override
  _NewEmiState createState() => _NewEmiState();
}

class _NewEmiState extends State<NewEmi> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emiController = TextEditingController();
  var _emiAmount;
  var selectedBank = "";

  @override
  Widget build(BuildContext context) {
    print("name: " + widget.name);
    checkArguments();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: size.height * 0.2,
                          width: size.width,
                          child: Image.asset(
                            "images/topBg.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 14, right: 15.0),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_rounded,
                                  size: 25,
                                  color: Colors.black,
                                ),
                                onPressed: () => Get.back(),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 14.0, left: 10, right: 15),
                              child: Text(
                                'EMI',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 75,
                          left: 10,
                          right: 10,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "  Customer Information",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 9.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, bottom: 8.0),
                                  child: Container(
                                    decoration: Utils.getBoxShape(),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Name  |",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: TextFormField(
                                              controller: _nameController,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                hintText: " Name",
                                                hintStyle:
                                                    TextStyle(fontSize: 14.0),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => showDialog(
                                              context: context,
                                              builder: (_) {
                                                return CustomerPopup();
                                              }),
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black,
                                            size: 35,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, bottom: 8.0),
                                  child: Container(
                                    decoration: Utils.getBoxShape(),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Mobile  |",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: TextFormField(
                                              controller: _mobileController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: " Mobile Number",
                                                hintStyle:
                                                    TextStyle(fontSize: 14.0),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, bottom: 8.0),
                                  child: Container(
                                    decoration: Utils.getBoxShape(),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Address  |",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: TextFormField(
                                              controller: _addressController,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                hintText: " Address",
                                                hintStyle:
                                                    TextStyle(fontSize: 14.0),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    "  Emi Information",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, bottom: 0.0),
                                  child: Container(
                                      decoration: Utils.getBoxShape(),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: TextFormField(
                                          controller: _emiController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: "  Emi Amount",
                                            hintStyle:
                                                TextStyle(fontSize: 14.0),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      )),
                                ),
                                Text(
                                  '   [Amount must be greater than 5000]',
                                  style: TextStyle(fontSize: 10),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    "  Bank Information",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, bottom: 8.0),
                                  child: Container(
                                    width: double.maxFinite,
                                    decoration: Utils.getBoxShape(),
                                    child: InkWell(
                                      onTap: () => showDialog(
                                          context: context,
                                          builder: (_) {
                                            return CustomerPopup();
                                          }),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              selectedBank != ""
                                                  ? selectedBank
                                                  : "--Select Bank-- ",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black,
                                              size: 35,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, bottom: 8.0),
                                  child: Container(
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6.0))),
                                    child: InkWell(
                                      onTap: () => showDialog(
                                          context: context,
                                          builder: (_) {
                                            return CustomerPopup();
                                          }),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 35.0,
                                                  top: 14.0,
                                                  bottom: 14.0),
                                              child: Text(
                                                "NEXT",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Icon(
                                              Icons.arrow_forward_ios_sharp,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )))),
      ),
    );
  }

  void checkArguments() {
    if (widget.name != null) {
      setState(() {
        _nameController.text = widget.name;
        _mobileController.text = widget.mobile;
        _addressController.text = widget.address;
      });
    }
    if (widget.bank != null) {
      setState(() {
        selectedBank = widget.bank;
      });
    }
  }
}
