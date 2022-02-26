import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/emi/emi_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/emi/emi_details.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/emi/utils/bank_popup.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/emi/utils/customer_popup.dart';
import 'package:hishabee_business_manager_fl/models/emi/utils/bank_model.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class NewEmi extends StatefulWidget {
  String name = "testing";
  String mobile;
  String address;
  String bank;
  String emiMoney;
  Shop shop;
  NewEmi(this.name, this.mobile, this.address, this.bank,this.shop, this.emiMoney);

  @override
  _NewEmiState createState() => _NewEmiState();
}

class _NewEmiState extends State<NewEmi> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emiController = TextEditingController();
  Shop shop = Get.arguments;
  var selectedBank = "";
  EmiController _emiMainController = Get.find();
  @override
  Widget build(BuildContext context) {
    print("name: " + widget.name);
    checkArguments();
    var storage = GetStorage();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
            ),
            onPressed: (){
              _emiMainController.nameController.clear();
              _emiMainController.addressController.clear();
              _emiMainController.mobileController.clear();
              _emiMainController.emiMoney.clear();
              _emiMainController.bankName.value = '';
              print(_emiMainController.bankName.value);
              Get.back();
            },
          ),
          title: Text(
            'emi'.tr,
          ),
          titleSpacing: 0,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "customer_information".tr,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      decoration: Utils.getBoxShape(),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "name|".tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0),
                              child: TextFormField(
                                controller: _emiMainController.nameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "name".tr,
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
                                  return CustomerPopup(shop: widget.shop,emiMoney: widget.emiMoney,);
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
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      decoration: Utils.getBoxShape(),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "mobile|".tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0),
                              child: TextFormField(
                                controller: _emiMainController.mobileController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]'),
                                  ),
                                ],
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "mobile_number".tr,
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
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      decoration: Utils.getBoxShape(),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "address|".tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0),
                              child: TextFormField(
                                controller: _emiMainController.addressController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "address".tr,
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
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "emi_information".tr,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                        decoration: Utils.getBoxShape(),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            controller: _emiMainController.emiMoney,
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp('[0-9]'),
                              ),
                            ],
                            decoration: InputDecoration(
                              hintText: "emi_amount".tr,
                              hintStyle:
                                  TextStyle(fontSize: 14.0),
                              border: InputBorder.none,

                            ),
                          ),
                        )),
                    Text(
                      '[amount_must_be_greater_than_5000]'.tr,
                      style: TextStyle(fontSize: 10),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "bank_information".tr,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      decoration: Utils.getBoxShape(),
                      child: InkWell(
                        onTap: () => showDialog(
                            context: context,
                            builder: (_) {
                              return BankPopup(widget.name, widget.address, widget.mobile, widget.shop, widget.emiMoney);
                            }),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(()=>
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _emiMainController.bankName.value == "" ?"select_bank".tr: _emiMainController.bankName.value,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14.0,
                                        color: Colors.black),
                                  ),
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
                          onTap: () {
                            print('money feild of EMI ${_emiMainController.nameController.value}');
                            if (checkValidation(_emiMainController.nameController.text) ||
                                checkValidation(_emiMainController.mobileController.text) ||
                                _emiMainController.emiMoney == null ||
                                _emiMainController.emiMoney.text == '' ||
                            checkValidation(_emiMainController.addressController.text) ||
                                (_emiMainController.bankName.value != "")) {
                              if (double.parse(
                                  _emiMainController.emiMoney.text) >=
                                  5000.00) {
                                Get.to(EmiDetails(), arguments: [
                                  storage.read(
                                      "shop_id"), //shop info 0
                                  _emiMainController.nameController.text, //name 1
                                  _emiMainController.mobileController.text, //phone 2
                                  _emiMainController.addressController.text, //address 3
                                  _emiMainController.emiMoney.text, //amount 4
                                  getBankName(
                                      _emiMainController.bankName.value) ,//bank info 5
                                  widget.shop //6
                                ]);
                              } else {
                                Utils.showToast(
                                    "enter_amount_more_than_5000".tr);
                              }
                            } else {
                              Utils.showToast(
                                  "please_fill_all_the_fields".tr);
                            }
                            //Get.to(EmiDetails());
                          },
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
                                    'next'.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14.0,
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
                ))),
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
        selectedBank = _emiMainController.bankName.value;
      });
    }
    if(widget.emiMoney != null){
      setState(() {
        widget.emiMoney = _emiController.text;
      });
    }
  }

  bool checkValidation(String text) {
    if (text != "" || text != null) {
      return true;
    } else {
      return false;
    }
  }

  BankModel getBankName(String selectedBank) =>
      Utils.bankList.firstWhere((element) => element.name == selectedBank);
}
