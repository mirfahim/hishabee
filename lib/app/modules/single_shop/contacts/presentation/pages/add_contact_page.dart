import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/page_background.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/contact_type_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/manager/add_contact_controller.dart';

class AddContactPage extends GetResponsiveView<AddContactsController> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget builder() {
    Size size = MediaQuery.of(screen.context).size;
    return Scaffold(
        backgroundColor: DEFAULT_BODY_BG_COLOR,
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Obx(
              () => MediaQuery.removePadding(
                context: screen.context,
                removeTop: true,
                child: ListView(
                  children: [
                    Stack(
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
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 25,
                                ),
                                onPressed: () {
                                  Navigator.pop(screen.context);
                                },
                              ),
                              Text(
                                controller.contactType.value.toLowerCase() ==
                                        "employee"
                                    ? "add_employee".tr
                                    : controller.contactType.value
                                                .toLowerCase() ==
                                            "customer"
                                        ? "add_customer".tr
                                        : "add_supplier".tr,
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 70.0,
                            left: 15,
                          ),
                          child: Obx(
                            () => Text(
                              controller.shop.value.name,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 120.0),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                _showPictureOptionDialogue();
                              },
                              child: Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: Colors.yellow, width: 1),
                                  color: Colors.white,
                                ),
                                child: Obx(
                                  () => controller.image.value == null
                                      ? Image.asset(
                                          'images/icons/profile_placeholder.png',
                                          height: 60,
                                          width: 60,
                                        )
                                      : Container(
                                          height: 60,
                                          width: 60,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            child: Image.file(
                                              controller.image.value,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              controller.contactType.value.toLowerCase() ==
                                      "employee"
                                  ? "employee_name".tr
                                  : controller.contactType.value
                                              .toLowerCase() ==
                                          "customer"
                                      ? "customer_name".tr
                                      : "supplier_name".tr,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8),
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter ${controller.contactType.value} name';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    controller.name.value = value;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText:
                                        "${controller.contactType.value} Name",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Rubik',
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 10),
                    controller.contactType.value == ContactType.EMPLOYEE
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: size.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Text(
                                        "position".tr,
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 8),
                                      child: Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              width: 1, color: Colors.grey),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please enter employee position';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              controller.position.value = value;

                                              print(controller.position);
                                            },
                                            // keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              hintText: "Position",
                                              hintStyle: TextStyle(
                                                fontFamily: 'Rubik',
                                                color: Colors.blueGrey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(height: 10),
                              Container(
                                width: size.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Text(
                                        "employee_id_if_any".tr,
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 8),
                                      child: Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              width: 1, color: Colors.grey),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: TextFormField(
                                            onSaved: (value) {
                                              controller.employeeId.value =
                                                  value;
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              hintText: "Employee ID",
                                              hintStyle: TextStyle(
                                                fontFamily: 'Rubik',
                                                color: Colors.blueGrey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(height: 10),
                            ],
                          )
                        : Container(),
                    Container(
                      width: size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "address".tr,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8),
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter employee address';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    controller.address.value = value;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: "Address",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Rubik',
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 10),
                    Container(
                      width: size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "mobile_no".tr,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8),
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter mobile number';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    controller.mobile.value = value;
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  maxLength: 11,
                                  decoration: InputDecoration(
                                    prefix: Text(
                                      "+88 ",
                                      style: TextStyle(
                                          color:
                                              DEFAULT_BLACK.withOpacity(0.7)),
                                    ),
                                    counterText: "",
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: "Mobile Number",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Rubik',
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 10),
                    Container(
                      width: size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "email_optional".tr,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8),
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: TextFormField(
                                  onSaved: (value) {
                                    controller.email.value = value;
                                  },
                                  // keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: "Email (Optional)",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Rubik',
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    controller.contactType.value == ContactType.EMPLOYEE
                        ? Container(
                            width: size.width / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text(
                                    "monthly_salary".tr,
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: DEFAULT_BLACK,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 8),
                                  child: Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter employee salary';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          controller.salary.value =
                                              int.parse(value);
                                        },
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          hintText: "Monthly Salary",
                                          hintStyle: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    controller.contactType.value == ContactType.SUPPLIER
                        ? Container(
                            width: size.width / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 8),
                                  child: Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter Supplied items';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          controller.suppliedItems.value =
                                              value;
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          hintText: "Supplied Items",
                                          hintStyle: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8),
                      child: getDefaultBlueButton(
                        screen.context,
                        "SAVE",
                        () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            if (controller.contactType.value ==
                                ContactType.EMPLOYEE) {
                              controller.addNewEmployee();
                            } else if (controller.contactType.value ==
                                ContactType.CUSTOMER) {
                              controller.addNewCustomer();
                            } else {
                              controller.addNewSupplier();
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  _showPictureOptionDialogue() {
    final AddContactsController controller = Get.find();

    try {
      if (Platform.isIOS) {
        showDialog(
            context: screen.context,
            builder: (_) => CupertinoAlertDialog(
                  title: Text("Picture option"),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          ImageHelper.getImageFromCamera().then((value) {
                            controller.image.value = value;
                            navigator.pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                  height: 80,
                                  image: AssetImage('images/icons/camera.png'),
                                ),
                                Text("Camera")
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //getImageFromGallery(option);
                          ImageHelper.getImageFromGallery().then((value) {
                            controller.image.value = value;
                            navigator.pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                  height: 80,
                                  image: AssetImage('images/icons/gallery.png'),
                                ),
                                Text("Gallery")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Close'),
                      onPressed: () {
                        navigator.pop();
                      },
                    )
                  ],
                ));
      } else {
        showDialog(
            context: screen.context,
            builder: (_) => AlertDialog(
                  title: Text("Picture option"),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          ImageHelper.getImageFromCamera().then((value) {
                            controller.image.value = value;
                            navigator.pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                  height: 80,
                                  image: AssetImage('images/icons/camera.png'),
                                ),
                                Text("Camera")
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //getImageFromGallery(option);
                          ImageHelper.getImageFromGallery().then((value) {
                            controller.image.value = value;
                            navigator.pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                  height: 80,
                                  image: AssetImage('images/icons/gallery.png'),
                                ),
                                Text("Gallery")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Close'),
                      onPressed: () {
                        navigator.pop();
                      },
                    )
                  ],
                ));
      }
    } catch (e) {}
  }
}
