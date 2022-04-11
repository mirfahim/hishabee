import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/pages/contact_dialogBox.dart';
import 'package:hishabee_business_manager_fl/controllers/sms/sms_controller.dart';
import 'package:hishabee_business_manager_fl/new_UI/select_shop/select_shop.dart';
class CustomerAdd extends StatelessWidget {

  String shopId;

  CustomerAdd({this.shopId});
  final formKey = GlobalKey<FormState>();
  SmsController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final contact = controller.contacts.value;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "add_customer".tr,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: DEFAULT_BLACK,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              children: [
                SizedBox(height: 10,),
                // Padding(
                //   padding: EdgeInsets.only(left: 10, right: 10),
                //   child: ElevatedButton(
                //     onPressed: () async {
                //       Get.dialog(ContactBox(),);
                //       // await controller.getAllContacts().then(
                //       //     Navigator.of(context).push(PageRouteBuilder(
                //       //         pageBuilder: (context, _, __) =>
                //       //             SmsCustomDialogContacts(),
                //       //         opaque: false)));
                //     },
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: const [
                //         Icon(
                //           Icons.contacts,
                //           color: Colors.black,
                //         ),
                //         SizedBox(
                //           width: 4,
                //         ),
                //         Text(
                //           'Import from contacts',
                //           style: TextStyle(color: Colors.black, fontSize: 12),
                //         )
                //       ],
                //     ),
                //     style: ElevatedButton.styleFrom(
                //       side: const BorderSide(width: 1, color: Colors.black),
                //       primary: Colors.white,
                //       fixedSize: Size(size.width, 20),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(2),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        _showPictureOptionDialogue(context);
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
                Container(
                  width: size.width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "customer_name".tr,
                          style: TextStyle(
                            fontFamily: 'Roboto',
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
                              controller: controller.nameController,
                              // initialValue: controller.name.value,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter customer name';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                controller.nameForContact.value = value;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText:
                                "Customer Name",
                                hintStyle: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      ,
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
                          "address".tr,
                          style: TextStyle(
                            fontFamily: 'Roboto',
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
                            fontFamily: 'Roboto',
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
                                controller: controller.mobileController,
                                // initialValue: controller.mobile.value,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter mobile number';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  controller.contactMobileNumber.value = value;
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
                                    fontFamily: 'Roboto',
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              )
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
                                  fontFamily: 'Roboto',
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 8),
                  child: getDefaultBlueButton(
                    context,
                    "SAVE",
                        () {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();

                        controller.addNewCustomer(
                          shopId: shopId,
                          name: controller.nameForContact.value,
                          address: controller.address.value,
                          mobile: controller.contactMobileNumber.value,
                          emailId: controller.email.value,
                          imageUrl: controller.image.value.path,
                          // id: contact.id
                        );
                        controller.nameForContact.value = null;
                        controller.contactMobileNumber.value = null;
                        controller.email.value =null;
                        controller.image.value = null;
                        if (Get.isDialogOpen) {
                          Get.back();
                          Future.delayed(Duration(seconds: 5), () {
                            CustomDialog.showStringDialog('Contact added successfully');
                            Get.back();
                            Get.back();
                            Get.back();
                          });
                        }
                        // Get.back();
                        // Get.back();
                        // Get.back();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _showPictureOptionDialogue(context) {
    // final AddContactsController controller = Get.find();

    try {
      if (Platform.isIOS) {
        showDialog(
            context: context,
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
            context: context,
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
