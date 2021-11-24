import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/controllers/business_overview/bo_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/emi/digital_payment.dart';
import 'package:hishabee_business_manager_fl/models/business_overview/product_report.dart';
import 'package:hishabee_business_manager_fl/utility/utils.dart';

class Newlink extends StatefulWidget {
  @override
  State<Newlink> createState() => _NewlinkState();
}

class _NewlinkState extends State<Newlink> {
  List<ProductReportModel> _list = <ProductReportModel>[];

  BoController controller = Get.find();

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
            onPressed: () => Get.to(DigitalPayment(),
                arguments:
                    "https://dev.hishabee.business/pay/619e07347a762105"), //for the share option
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "DONE",
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(children: [
                SizedBox(
                  height: size.height * 0.2,
                  width: size.width,
                  child: Image.asset(
                    "images/topBg.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 14),
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
                      padding: EdgeInsets.only(top: 27.0, right: 55, left: 25),
                      child: Text(
                        'Digital Payment',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    top: 60,
                    left: 10,
                    right: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Amount",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Container(
                            decoration: Utils.getBoxShape(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Payable Amount',
                                    hintStyle: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.grey[500])),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),

////,
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void getData() {
    controller
        .fetchProductWiseReport(shopId: "", statDate: "", endDate: "")
        .then((value) {
      if (value != null) {
        setState(() {
          _list = productReportModelFromJson(value);
          //    _foundData = _list;
          // checkingDone = true;
        });
      }

      //  isLoading = false;
    });
  }
}
