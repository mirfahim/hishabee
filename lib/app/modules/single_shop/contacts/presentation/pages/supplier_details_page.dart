import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/page_background.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/page_header.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/_navigation/contact_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/contact_type_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/supplier_model.dart';

class SupplierDetailsPage extends StatelessWidget {
  final Supplier supplier;
  final Shop shop;
  const SupplierDetailsPage({Key key, this.shop, this.supplier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var tr;
    return Scaffold(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildContactDetailsPageHeader(
                      'supplier_details'.tr,
                      shop.name,
                      InkWell(
                        onTap: () {
                          Get.toNamed(ContactRoutes.EDIT_CONTACT, arguments: {
                            'shop': shop,
                            "type": ContactType.SUPPLIER,
                            "contact": supplier,
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: DEFAULT_BLUE,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.yellow, width: 1),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: supplier.imageSrc != null
                                  ? Image.network(
                                      supplier.imageSrc,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      "images/icons/profile_placeholder.png",
                                      fit: BoxFit.fill,
                                    ))),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 8),
                    child: Text(
                      "supplier_name".tr,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: DEFAULT_BLACK,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, top: 5, right: 15),
                    child: Container(
                      width: size.width,
                      child: Text(
                        supplier.name,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 15),
                    child: Text(
                      "address".tr,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: DEFAULT_BLACK,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, top: 5, right: 15),
                    child: Container(
                      width: size.width,
                      child: Text(
                        supplier.address,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "mobile".tr,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                            Container(
                              width: size.width * 0.5,
                              child: Text(
                                supplier.mobile,
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: IconButton(
                                    icon: AvdPicture.asset(
                                        'images/xml_icon/ic_phones.xml'),
                                    onPressed: () {
                                      if (supplier.mobile != null) {
                                        String number =
                                            "tel:${supplier.mobile}";
                                        Utility.launchURL(number);
                                      } else {
                                        CustomDialog.showStringDialog(
                                            "Number not found");
                                      }
                                    })),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: IconButton(
                                    icon: Icon(Icons.message),
                                    onPressed: () {
                                      if (supplier.mobile != null) {
                                        String number =
                                            "sms:${supplier.mobile}";
                                        Utility.launchURL(number);
                                      } else {
                                        CustomDialog.showStringDialog(
                                            "Number not found");
                                      }
                                    })),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "email".tr,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                            Container(
                              width: size.width * 0.5,
                              child: Text(
                                supplier.email ?? '',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: IconButton(
                                icon: AvdPicture.asset(
                                    'images/xml_icon/ic_gmail.xml'),
                                onPressed: () {
                                  if (supplier.email != null) {
                                    String number = "mailto:${supplier.email}";
                                    Utility.launchURL(number);
                                  } else {
                                    CustomDialog.showStringDialog(
                                        "Email ID not found");
                                  }
                                })),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 8),
                    child: Text(
                      "supplied_items".tr,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: DEFAULT_BLACK,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 8),
                    child: Container(
                      width: size.width * 0.5,
                      child: Text(
                        supplier.suppliedItems ?? '',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
