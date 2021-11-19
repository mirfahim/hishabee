import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/emi/utils/customer_popup.dart';

class NewEmi extends StatefulWidget {
  @override
  _NewEmiState createState() => _NewEmiState();
}

class _NewEmiState extends State<NewEmi> {
  @override
  Widget build(BuildContext context) {
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
                                const EdgeInsets.only(left: 28.0, right: 28.0),
                            child: Column(
                              children: [
                                Text(
                                  "Customer Information",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Name    ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextButton.icon(
                                        onPressed: () => showDialog(
                                            context: context,
                                            builder: (_) {
                                              return CustomerPopup();
                                            }),
                                        icon: Icon(Icons.arrow_drop_down),
                                        label: Text("Type of select Customer"))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )))),
      ),
    );
  }
}
