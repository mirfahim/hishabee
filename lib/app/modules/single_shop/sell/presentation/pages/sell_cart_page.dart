import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/_bindings/confirm_payment_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_controller.dart';

import '../../../../../../new_UI/constants.dart';
import '../../_navigation/sell_page_route.dart';
import 'confirm_payment_page.dart';

class SellCartPage extends GetView<SellController>{

  DateTime startDate = DateTime.now();

  DateTime endDate;
  int items = 0;

  _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      helpText: "start_date".tr,
      context: context,
      initialDate: startDate,
      // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: DEFAULT_BLACK,
              onPrimary: DEFAULT_BODY_BG_COLOR,
              surface: Colors.green,
              onSurface: DEFAULT_BLACK,
            ),
            dialogBackgroundColor: DEFAULT_BODY_BG_COLOR,
          ),
          child: child,
        );
      },
    );
    if (picked != null) {
      // widgets.controller.selectedStartDate.value = picked;
      startDate = picked;
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('cart'.tr),
        backgroundColor: DEFAULT_YELLOW_BG,
      ),
      body: SafeArea(
        child: Container(
            height: size.height - 62,
            width: size.width,
            child: Column(children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 8.0),
              //   child: Row(
              //     children: [
              //       IconButton(
              //         icon: Icon(
              //           Icons.arrow_back,
              //           size: 25,
              //           color: DEFAULT_BLUE,
              //         ),
              //         onPressed: () {
              //           Get.back();
              //         },
              //       ),
              //       Text('cart'.tr,style: TextStyle(fontSize: 16,color: DEFAULT_BLUE),),
              //     ],
              //   ),
              // ),
              Expanded(
                child: Container(
                    // height: size.height,
                    child: Obx(() => ListView.builder(
                        itemCount: controller.cart.length,
                        itemBuilder: (context, index) {
                          var item = controller.cart[index];
                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Card(
                                  color: Colors.grey.shade50,
                                  elevation: 10,
                                  child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 10.0),
                                              child: Container(
                                                child: item.imageUrl != null
                                                    ? ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(40),
                                                  child: CachedNetworkImage(
                                                    height: 50,
                                                    width: 50,
                                                    imageUrl: item.imageUrl,
                                                    placeholder: (context, url) =>
                                                        CircularProgressIndicator(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                        Icon(
                                                          Icons.error,
                                                          color: Colors.red,
                                                        ),
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                                    : Center(
                                                  child: Image.asset(
                                                      'images/hishabeeLogo.png',
                                                      height: 50,
                                                      width: 50),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '${item.name}',
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          controller.decreaseCartItem(
                                                              index, item);
                                                        },
                                                        child: Icon(Icons.remove,
                                                            color: Colors.black),
                                                        style: ElevatedButton.styleFrom(
                                                          shape: CircleBorder(),
                                                          padding: EdgeInsets.all(3),
                                                          primary: Colors.white,
                                                          // <-- Button color
                                                          onPrimary: Colors
                                                              .red, // <-- Splash color
                                                        ),
                                                      ),
                                                      Text(
                                                        '${item.unit}',
                                                        style: TextStyle(fontSize: 20),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          controller.increaseCartItem(
                                                              index, item);
                                                        },
                                                        child: Icon(Icons.add,
                                                            color: Colors.black),
                                                        style: ElevatedButton.styleFrom(
                                                          shape: CircleBorder(),
                                                          padding: EdgeInsets.all(3),
                                                          primary: Colors.white,
                                                          // <-- Button color
                                                          onPrimary: Colors
                                                              .red, // <-- Splash color
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '${item.sellingPrice}',
                                                    style: TextStyle(fontSize: 20),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons.delete,color: Colors.red,),
                                                    onPressed: () {
                                                      controller.removeFromCart(item);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))));
                        }))),
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(vertical: 5),
                child: Divider(
                  thickness: 2,
                  color: Colors.grey.withOpacity(.35),
                  indent: 5,
                  endIndent: 5,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: DEFAULT_BLUE),
                    ),
                    Obx(() => Text(
                      '${controller.totalCartProductPrice.value.abs()}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight:
                          FontWeight.bold,
                          color: DEFAULT_BLUE),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey,
                              width: 1.5),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(
                                  6.0))),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceAround,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Discount(%)  |",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight:
                                FontWeight.w600),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.only(
                                  left: 8.0),
                              child: TextFormField(
                                onChanged: (value) {
                                  controller.discount1
                                      .value =
                                      double.parse(
                                          value.isEmpty
                                              ? '0.0'
                                              : value);
                                  controller
                                      .calculateTotalCartPrice();
                                },
                                keyboardType:
                                TextInputType.text,
                                decoration:
                                InputDecoration(
                                  //labelText: " discount",
                                  hintText: " discount",
                                  hintStyle: TextStyle(
                                      fontSize: 14.0),
                                  border:
                                  InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey,
                              width: 1.5),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(
                                  6.0))),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceAround,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Discount(Tk)  |",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight:
                                FontWeight.w600),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.only(
                                  left: 8.0),
                              child: TextFormField(
                                onChanged: (value) {
                                  controller.discount2
                                      .value =
                                      double.parse(
                                          value.isEmpty
                                              ? "0.0"
                                              : value);
                                  controller
                                      .calculateTotalCartPrice();
                                },
                                keyboardType:
                                TextInputType.text,
                                decoration:
                                InputDecoration(
                                  hintText: " discount",
                                  hintStyle: TextStyle(
                                      fontSize: 14.0),
                                  border:
                                  InputBorder.none,
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
              Divider(
                thickness: 2,
                color: Colors.grey.withOpacity(.35),
                indent: 5,
                endIndent: 5,
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: DEFAULT_BLUE),
                    ),
                    Obx(() => Text(
                      '${controller.totalCartPrice.value.abs()}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight:
                          FontWeight.bold,
                          color: DEFAULT_BLUE),
                    ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: Container(
                  height: 50,
                  width: size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(ConfirmPaymentPage(), binding: ConfirmPaymentBinding(),
                      arguments: {
                        'shop':
                        controller
                            .shop
                            .value,
                        'cart':
                        controller
                            .cart,
                        'totalPrice':
                        controller
                            .totalCartPrice
                            .value,
                      }
                      );
                      // Get.toNamed(SellPageRoutes.CONFIRM_PAYMENT_PAGE,
                      //     arguments: {
                      //       'shop':
                      //       controller
                      //           .shop
                      //           .value,
                      //       'cart':
                      //       controller
                      //           .cart,
                      //       'totalPrice':
                      //       controller
                      //           .totalCartPrice
                      //           .value,
                      //     });
                    },
                    child: Center(
                      child: Text(
                        'Payment System',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: DEFAULT_BLUE,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              )
            ])),
      ),
    );
  }
  
}
