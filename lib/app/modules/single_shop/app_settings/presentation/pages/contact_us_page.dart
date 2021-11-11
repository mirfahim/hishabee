import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/local/models/contact_us_model.dart';

class ContactUsPage extends StatelessWidget {
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
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            size: 25,
                            color: DEFAULT_BLACK,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          "contact_us".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 10.0,
                      ),
                      child: Text(
                        "app_name".tr,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: DEFAULT_BLUE,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 115,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 160,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeLeft: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: contactUsInfoData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Utility.launchURL(
                                    contactUsInfoData[index].data);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: contactUsInfoData[index].color,
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(
                                          0,
                                          2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20),
                                      contactUsInfoData[index].icon,
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          contactUsInfoData[index].name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Utility.launchURL("tel:+88 09613829088");
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                          right: 15.0,
                          top: 20,
                        ),
                        child: Container(
                          height: 100,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Icon(
                                  FontAwesomeIcons.phoneAlt,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "call_us_for_emergency_support".tr,
                                    style: TextStyle(
                                      color: Colors.black38,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "+88 09613829088",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(
                                  0,
                                  2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 5.0,
                        right: 15.0,
                        top: 20,
                      ),
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Utility.launchURL(
                            "https://www.messenger.com/t/HishaBee");
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                          right: 15.0,
                          top: 20,
                        ),
                        child: Container(
                          height: 100,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                //backgroundColor: Colors.pink[200],
                                child: Image.asset(
                                  "images/icons/chat.png",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "live_support".tr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.4,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(
                                  0,
                                  2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 5.0,
                        right: 15.0,
                        top: 20,
                      ),
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
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
