import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/_navigation/contact_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/contact_type_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/supplier_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/manager/contact_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/pages/supplier_details_page.dart';

import 'customer_details_page.dart';
import 'employee_details_page.dart';

class ContactsPage extends GetResponsiveView<ContactController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: DEFAULT_BLACK,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'contacts'.tr,
          style: TextStyle(
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(
          //     top: 10.0,
          //     left: 15,
          //   ),
          //   child: Obx(
          //     () => Text(
          //       controller.shop.value.name,
          //       style: TextStyle(
          //         fontFamily: 'Roboto',
          //         fontSize: 18,
          //         fontWeight: FontWeight.w600,
          //         color: Colors.black,
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 5, right: 5),
              child: Obx(
                () => DefaultTabController(
                  length: 3,
                  initialIndex: controller.tabIndex.value,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8, left: 5, right: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: TabBar(
                            indicatorColor: DEFAULT_BLACK,
                            tabs: [
                              Tab(
                                icon: Text(
                                  "employee".tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Tab(
                                icon: Text(
                                  "customer".tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Tab(
                                icon: Text(
                                  "supplier".tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: TabBarView(
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: [

                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //     top: 8.0,
                                    //     left: 5.0,
                                    //     right: 5.0,
                                    //   ),
                                    //   child: Container(
                                    //     width:
                                    //         MediaQuery.of(context).size.width,
                                    //     height: 45,
                                    //     decoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(4),
                                    //     ),
                                    //     child: ElevatedButton(
                                    //       style: ElevatedButton.styleFrom(
                                    //         primary: Colors.black,
                                    //         onPrimary: DEFAULT_BLUE,
                                    //       ),
                                    //       onPressed: () {
                                    //         Get.toNamed(
                                    //           ContactRoutes.SALARY_REPORT,
                                    //           arguments: {
                                    //             "shop": controller.shop.value
                                    //           },
                                    //         );
                                    //       },
                                    //       child: Text(
                                    //         "salary_report".tr,
                                    //         style: TextStyle(
                                    //           color: Colors.white,
                                    //           fontFamily: 'Rubik',
                                    //           fontWeight: FontWeight.normal,
                                    //           fontSize: 16,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(height: 10,),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.0,
                                            bottom: 8.0,
                                            left: 5,
                                            right: 5),
                                        child: Container(
                                          height: size.height <= 650 &&
                                                  size.height > 550
                                              ? size.height * 0.5
                                              : size.height * 0.65,
                                          child: Obx(
                                            () => MediaQuery.removePadding(
                                              context: context,
                                              removeTop: true,
                                              child: ListView.builder(
                                                itemCount: controller
                                                    .employeeList.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  Employee employee = controller
                                                      .employeeList[index];

                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            width: 1.0,
                                                            color: Colors.grey),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black12,
                                                          spreadRadius: 1,
                                                          blurRadius: 3,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary:
                                                                  Colors.white),
                                                      onPressed: () {
                                                        Get.to(() =>
                                                            EmployeeDetailsPage(
                                                              employee:
                                                                  employee,
                                                              shop: controller
                                                                  .shop.value,
                                                            ));
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 8, bottom: 8),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              child: Container(
                                                                  child: employee
                                                                              .imageSrc ==
                                                                          null
                                                                      ? Image
                                                                          .asset(
                                                                          "images/icons/profile_placeholder.png",
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                        )
                                                                      : Container(
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            imageUrl:
                                                                                employee.imageSrc,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                        )),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    width:
                                                                        size.width *
                                                                            0.3,
                                                                    child: Text(
                                                                      employee
                                                                          .name,
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 4,
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        size.width *
                                                                            0.3,
                                                                    child: Text(
                                                                      employee
                                                                          .position ?? "No Data",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            Container(
                                                              width:
                                                                  size.width *
                                                                      0.24,
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                  employee
                                                                      .mobile,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .teal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_forward,
                                                                color: Colors
                                                                    .black,
                                                                size: 25,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        width:
                                        MediaQuery.of(context).size.width,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(4),
                                        ),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.black,
                                            onPrimary: DEFAULT_BLUE,
                                          ),
                                          onPressed: () {
                                            Employee employee = new Employee();
                                            Get.toNamed(
                                                ContactRoutes.ADD_CONTACT,
                                                arguments: {
                                                  'shop': controller.shop.value,
                                                  "type": ContactType.EMPLOYEE,
                                                  "contact": employee,
                                                });
                                          },
                                          child: Text(
                                            "add_new_employee".tr,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: size.height <= 650 &&
                                                  size.height > 550
                                              ? size.height * 0.58
                                              : size.height * 0.7,
                                          child: Obx(
                                            () => MediaQuery.removePadding(
                                              context: context,
                                              removeTop: true,
                                              child: ListView.builder(
                                                itemCount: controller
                                                    .customerList.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  Customer customer = controller
                                                      .customerList[index];
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            width: 1.0,
                                                            color: Colors.grey),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black12,
                                                          spreadRadius: 1,
                                                          blurRadius: 3,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary:
                                                                  Colors.white),
                                                      onPressed: () {
                                                        Get.to(() =>
                                                            CustomerDetailsPage(
                                                              customer:
                                                                  customer,
                                                              shop: controller
                                                                  .shop.value,
                                                            ));
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 8, bottom: 8),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              child: Container(
                                                                  child: customer
                                                                              .imageSrc ==
                                                                          null
                                                                      ? Image
                                                                          .asset(
                                                                          "images/icons/profile_placeholder.png",
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                        )
                                                                      : Container(
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            imageUrl:
                                                                                customer.imageSrc,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                        )),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                width:
                                                                    size.width *
                                                                        0.3,
                                                                child: Text(
                                                                  customer.name,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            Container(
                                                              width:
                                                                  size.width *
                                                                      0.25,
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                  customer
                                                                      .mobile,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .teal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .arrow_forward,
                                                              color:
                                                                  Colors.black,
                                                              size: 25,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        width:
                                        MediaQuery.of(context).size.width,
                                        height: 45,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(4)),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.black),
                                          onPressed: () {
                                            Customer customer = new Customer();
                                            Get.toNamed(
                                                ContactRoutes.ADD_CONTACT,
                                                arguments: {
                                                  'shop': controller.shop.value,
                                                  "type": ContactType.CUSTOMER,
                                                  "contact": customer,
                                                });
                                          },
                                          child: Text(
                                            "add_new_customer".tr,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    TextField(
                                      onChanged: (value) => controller.runFilter(value),
                                      style: TextStyle(fontSize: 14.0),
                                      decoration: InputDecoration(
                                          hintText: 'Search',
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: Colors.blue[900])),
                                          hintStyle: TextStyle(fontSize: 12.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(6.0),
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: Colors.blue[900])),
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: Colors.blue[900],
                                            size: 30,
                                          )),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 5, right: 5),
                                        child: Container(
                                          height: size.height <= 650 &&
                                                  size.height > 550
                                              ? size.height * 0.58
                                              : size.height * 0.7,
                                          child: Obx(
                                            () => MediaQuery.removePadding(
                                              context: context,
                                              removeTop: true,
                                              child: ListView.builder(
                                                itemCount: controller
                                                    .supplierFoundData.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  Supplier supplier = controller
                                                      .supplierFoundData[index];
                                                  print(supplier);
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            width: 1.0,
                                                            color: Colors.grey),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black12,
                                                          spreadRadius: 1,
                                                          blurRadius: 3,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary:
                                                                  Colors.white),
                                                      onPressed: () {
                                                        Get.to(() =>
                                                            SupplierDetailsPage(
                                                              supplier:
                                                                  supplier,
                                                              shop: controller
                                                                  .shop.value,
                                                            ));
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 8, bottom: 8),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              child: Container(
                                                                  child: supplier
                                                                              .imageSrc ==
                                                                          null
                                                                      ? Image
                                                                          .asset(
                                                                          "images/icons/profile_placeholder.png",
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                        )
                                                                      : Container(
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            imageUrl:
                                                                                supplier.imageSrc,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                        )),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    width:
                                                                        size.width *
                                                                            0.3,
                                                                    child: Text(
                                                                      supplier.name ??
                                                                          '',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        size.width *
                                                                            0.3,
                                                                    child: Text(
                                                                      supplier.email ??
                                                                          '',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        size.width *
                                                                            0.3,
                                                                    child: Text(
                                                                      supplier
                                                                          .address ==null ? '' : supplier
                                                                          .address,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        size.width *
                                                                            0.3,
                                                                    child: Text(
                                                                      supplier
                                                                          .suppliedItems == null ? '': supplier
                                                                          .suppliedItems ,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            Container(
                                                              width:
                                                                  size.width *
                                                                      0.25,
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                  supplier
                                                                      .mobile,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .teal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .arrow_forward,
                                                              color:
                                                                  Colors.black,
                                                              size: 25,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        width:
                                        MediaQuery.of(context).size.width,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(4),
                                        ),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.black),
                                          onPressed: () {
                                            Supplier supplier = new Supplier();
                                            Get.toNamed(
                                                ContactRoutes.ADD_CONTACT,
                                                arguments: {
                                                  'shop': controller.shop.value,
                                                  "type": ContactType.SUPPLIER,
                                                  "contact": supplier,
                                                });
                                          },
                                          child: Text(
                                            "add_new_supplier".tr,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getQRCodeScreenBody(int index, Size size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(),
        ],
      ),
    );
  }
}
