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
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_model.dart';
import 'package:hishabee_business_manager_fl/controllers/sms/sms_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/sms/create_sms.dart';
import 'package:hishabee_business_manager_fl/new_UI/sms/sms_front.dart';

class EmployeeDetailsPage extends StatelessWidget {
  final Employee employee;
  final Shop shop;
   EmployeeDetailsPage({Key key, this.employee, this.shop})
      : super(key: key);

  SmsController _smsController = SmsController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("empl: ${employee.monthlySalary}");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: buildContactDetailsPageHeader(
            'employee_details'.tr,
            shop.name,
            InkWell(
              onTap: () {
                Get.toNamed(ContactRoutes.EDIT_CONTACT, arguments: {
                  'shop': shop,
                  "type": ContactType.EMPLOYEE,
                  "contact": employee,
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.amber, width: 3),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: employee.imageSrc != null
                              ? Image.network(
                            employee.imageSrc,
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
                  "employee_name".tr,
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
                    employee.name,
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
                    "${employee.address ?? ""}",
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
                padding: const EdgeInsets.only(top: 15.0, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "position".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                        Container(
                          width: size.width * 0.3,
                          child: Text(
                            employee.position ?? "No data",
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "employee_id".tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                        Container(
                          width: size.width * 0.3,
                          child: Text(
                            employee.employeeId ?? '',
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
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
                            employee.mobile,
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
                                  if (employee.mobile != null) {
                                    String number =
                                        "sms:${employee.mobile}";
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
                                  if (employee.mobile != null) {
                                    // String number =
                                    //     "sms:${employee.mobile}";
                                    // Utility.launchURL(number);
                                    _smsController.mobileNumbers.value = employee.mobile;
                                    Get.to(
                                          () => SmsCreatePage(),
                                      arguments: shop,
                                      // binding: SMSBindings(),
                                    );
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
                            employee.email ?? '',
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
                            onPressed: () {
                              if (employee.email != null) {
                                String number = "mailto:${employee.email}";
                                Utility.launchURL(number);
                              } else {
                                CustomDialog.showStringDialog(
                                    "Email ID not found");
                              }
                            },
                            icon: AvdPicture.asset(
                                'images/xml_icon/ic_gmail.xml'))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15),
                child: Text(
                  "salary".tr,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: DEFAULT_BLACK,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 5),
                child: Container(
                  width: size.width * 0.5,
                  child: Text(
                    "${employee.monthlySalary}",
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
                padding: const EdgeInsets.only(left: 15.0, top: 8),
                child: Text(
                  "Sale History",
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: DEFAULT_BLACK,
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
