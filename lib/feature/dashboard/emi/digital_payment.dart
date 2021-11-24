import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DigitalPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () => Get.to(DigitalPayment(),
                      arguments:
                          "https://dev.hishabee.business/pay/619e07347a762105"), //for the share option
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black87),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "SHARE  LINK",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () => Get.to(DigitalPayment(),
                      arguments:
                          "https://dev.hishabee.business/pay/619e07347a762105"), //for the share option
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black87),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
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
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                "Digital Payment",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "20tk",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.blue[900]),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.yellow.shade100,
                    border: Border.all(color: Colors.grey, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    Get.arguments,
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
              ),
              Text(
                "[Share this url with your customer to receive payment]",
                style: TextStyle(fontSize: 11.0, color: Colors.grey[500]),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlineButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.open_in_browser_outlined,
                                color: Colors.blue.shade600,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Visit URL',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.blue.shade600,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        highlightedBorderColor: Colors.orange,
                        color: Colors.grey.shade400,
                        borderSide: new BorderSide(color: Colors.grey.shade400),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0))),
                    OutlineButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.copy,
                                color: Colors.blue.shade600,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Copy URL',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.blue.shade600,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        highlightedBorderColor: Colors.orange,
                        color: Colors.grey.shade400,
                        borderSide: new BorderSide(color: Colors.grey.shade400),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
