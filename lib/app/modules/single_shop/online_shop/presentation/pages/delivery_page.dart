import 'package:flutter/material.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/delivery_page_controller.dart';

class DeliveryPage extends GetView<DeliveryPageController> {
  const DeliveryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: size.height * 0.2,
                width: size.width,
                child: Image.asset(
                  "images/topBg.png",
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: DEFAULT_BLACK,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Delivery",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: DEFAULT_BLACK,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 70, left: 15.0, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                          child: Container(
                            height: 80,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 3),
                                  )
                                ]),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: size.width * 0.9,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "You can use any delivery company to deliver your product. we do not handle your delivery directly",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                    child: Text(
                      "Delivery Company Near You",
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: DEFAULT_BLACK,
                      ),
                    ),
                  ),
                  Obx(
                    () => Container(
                      child: controller.deliveryCompanyUrls.length == 0
                          ? InkWell(
                              onTap: () {
                                Utility.launchURL("https://www.oditiya.com/");
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15.0, right: 15),
                                child: Container(
                                  height: 80,
                                  width: size.width * 0.9,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: Offset(0, 3),
                                        )
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "images/shop_features/oditiya_logo.png",
                                      height: 100,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.deliveryCompanyUrls.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Utility.launchURL(
                                        "${controller.deliveryCompanyUrls[index]}");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15.0, right: 15),
                                    child: Container(
                                      width: size.width * 0.9,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: Offset(0, 3),
                                            )
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              "images/shop_features/oditiya_logo.png",
                                              height: 30,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "${controller.deliveryCompanyUrls[index]}",
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: DEFAULT_BLACK,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 15, right: 15),
                    child: Text(
                      "Add Delivery Company You Already Use",
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: DEFAULT_BLACK,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 15.0, right: 15, bottom: 20),
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              addDeliveryDialog(context);
                            },
                            child: Container(
                              child: Image.asset(
                                "images/icons/green_plus.png",
                                height: 60,
                                width: 60,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Add Delivery Company You Use",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  addDeliveryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => KeyboardAwareDialog(
        child: new Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 18.0,
                  left: 10,
                ),
                child: Text(
                  "Delivery Company URL",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: DEFAULT_BLACK,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Form(
                        key: controller.formKey,
                        child: TextFormField(
                          onSaved: (value) {
                            controller.deliveryCompanyUrl.value = value;
                          },
                          decoration: InputDecoration(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Cancel")),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          onPressed: () async {
                            await controller.addDeliveryCompanyUrl();
                          },
                          child: Text("Ok")),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
