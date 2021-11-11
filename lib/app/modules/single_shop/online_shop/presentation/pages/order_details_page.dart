import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/order_details_controller.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends GetView<OrderDetailsController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: Stack(
          children: [
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                physics: ScrollPhysics(),
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
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  'Order Details',
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: DEFAULT_BLACK,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 70,
                          left: 15,
                          right: 15,
                        ),
                        child: Text(
                          "Customer information",
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 100,
                          left: 10,
                          right: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10),
                                        child: Container(
                                            child: Image.asset(
                                          "images/icons/profile_placeholder.png",
                                          height: 30,
                                          width: 30,
                                        )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10, top: 10),
                                        child: Container(
                                          width: 150,
                                          child: Obx(
                                            () => Text(
                                              "${controller.order.value.shippingAddress.name}",
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: DEFAULT_BLACK,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10),
                                        child: Container(
                                            child: Icon(
                                          Icons.call,
                                          size: 30,
                                        )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10, top: 10),
                                        child: Container(
                                          child: Obx(
                                            () => Text(
                                              "${controller.order.value.shippingAddress.mobileNumber}",
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: DEFAULT_BLACK,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10, bottom: 10),
                                        child: Container(
                                            child: Icon(
                                          Icons.email_outlined,
                                          size: 30,
                                        )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Obx(
                                          () => Text(
                                            "${controller.order.value.shippingAddress.email}",
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              color: DEFAULT_BLACK,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, bottom: 10),
                              child: Text(
                                "Order information",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                            Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10),
                                        child: Container(
                                            child: Obx(
                                          () => Text(
                                            "${controller.order.value.code}",
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              color: DEFAULT_BLACK,
                                            ),
                                          ),
                                        )),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, top: 10),
                                        child: Container(
                                          child: Text(
                                            "Copy",
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: DEFAULT_BLUE,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10),
                                        child: Container(
                                            child: Icon(
                                          Icons.access_time,
                                          size: 30,
                                        )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10, top: 10),
                                        child: Container(
                                          child: Obx(
                                            () => Text(
                                              "${DateFormat('dd MMM yyyy hh:mm a').format(controller.order.value.createdAt)}",
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: DEFAULT_BLACK,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10),
                                        child: Container(
                                            child: Text(
                                          "Delivery Location",
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLACK,
                                          ),
                                        )),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                          child: Container(
                                            color: DEFAULT_BLACK,
                                            height: 2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10),
                                        child: Container(
                                          child: Icon(
                                            Icons.home,
                                            color: DEFAULT_BLACK,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Obx(
                                              () => Text(
                                                "${controller.order.value.code}",
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                  color: DEFAULT_BLACK,
                                                ),
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10),
                                        child: Container(
                                            child: Text(
                                          "Area :",
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: DEFAULT_BLACK,
                                          ),
                                        )),
                                      ),
                                      Expanded(
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Obx(
                                              () => Text(
                                                "${controller.order.value.shippingAddress.address}",
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                  color: DEFAULT_BLACK,
                                                ),
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: size.width * 0.45,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, top: 10),
                                                child: Container(
                                                    child: Text(
                                                  "Division :",
                                                  style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: DEFAULT_BLACK,
                                                  ),
                                                )),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            top: 10),
                                                    child: Obx(
                                                      () => Text(
                                                        "${controller.order.value.shippingAddress.division}",
                                                        style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: DEFAULT_BLACK,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          )),
                                      SizedBox(
                                        height: 20,
                                        child: VerticalDivider(
                                          color: DEFAULT_BLACK,
                                          thickness: 1,
                                        ),
                                      ),
                                      Container(
                                          width: size.width * 0.45,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, top: 10),
                                                child: Container(
                                                    child: Text(
                                                  "District :",
                                                  style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: DEFAULT_BLACK,
                                                  ),
                                                )),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            top: 10),
                                                    child: Obx(
                                                      () => Text(
                                                        "${controller.order.value.shippingAddress.district}",
                                                        style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: DEFAULT_BLACK,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10),
                                        child: Container(
                                            child: Text(
                                          "Payment Method",
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLACK,
                                          ),
                                        )),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                          child: Container(
                                            color: DEFAULT_BLACK,
                                            height: 2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10),
                                        child: Container(
                                            child: Icon(
                                          Icons.money,
                                          size: 30,
                                        )),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                          child: Obx(
                                            () => Text(
                                              "${controller.order.value.paymentType}",
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 24,
                                                fontWeight: FontWeight.normal,
                                                color: DEFAULT_BLACK,
                                              ),
                                            ),
                                          )),
                                      Spacer(),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                          child: Obx(
                                            () => Text(
                                              "${controller.order.value.orderDetails.first.price}",
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 24,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.red,
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                          bottom: 15),
                                      child: Text(
                                        "[Collect cash when you deliver the product]",
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: DEFAULT_BLACK,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, bottom: 10),
                              child: Text(
                                "Order Product",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                            Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /*  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 45.0, top: 75),
                                        child: Container(
                                          child: Obx(
                                                () => ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: controller.cart.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  var product = controller.order.value.
                                                  return Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                                    child: Container(
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border:
                                                        Border.all(color: Colors.grey, width: 0.5),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black12,
                                                            spreadRadius: 1,
                                                            blurRadius: 3,
                                                            offset: Offset(
                                                                0, 3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.symmetric(horizontal: 10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceAround,
                                                          children: [
                                                            Container(
                                                                height: 50,
                                                                width: 50,
                                                                child: product.imageUrl != null
                                                                    ? ClipRRect(
                                                                  borderRadius:
                                                                  BorderRadius.circular(40),
                                                                  child: CachedNetworkImage(
                                                                    height: 50,
                                                                    width: 50,
                                                                    imageUrl: product.imageUrl,
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
                                                                    width: 50,
                                                                  ),
                                                                )),
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(
                                                                  horizontal: 10.0),
                                                              child: Container(
                                                                height: 70,
                                                                width: 130,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text("${product.name}"),
                                                                    Text("TK ${product.sellingPrice}"),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                "X",
                                                                style: TextStyle(
                                                                    color: DEFAULT_BLACK,
                                                                    fontSize: 24,
                                                                    fontWeight: FontWeight.bold),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                "1",
                                                                style: TextStyle(
                                                                    color: DEFAULT_BLUE,
                                                                    fontSize: 24,
                                                                    fontWeight: FontWeight.bold),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                controller.removeFromCart(product);
                                                              },
                                                              child: Container(
                                                                height: 40,
                                                                width: 40,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.red,
                                                                  borderRadius: BorderRadius.circular(5),
                                                                ),
                                                                child: Center(
                                                                  child: Icon(
                                                                    Icons.delete_forever,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )*/
                                  Divider(
                                    color: DEFAULT_BLACK.withOpacity(0.5),
                                    thickness: 1,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Text(
                                            "Total Price :",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Obx(
                                            () => Text(
                                              "  ${controller.order.value.orderDetails.first.price} Tk",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: DEFAULT_BLACK.withOpacity(0.5),
                                    thickness: 1,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Text(
                                            "(-) Discount :",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Obx(
                                            () => Text(
                                              "  ${controller.order.value.couponDiscount} Tk",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: DEFAULT_BLACK.withOpacity(0.5),
                                    thickness: 1,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Text(
                                            "Total Payable :",
                                            style: TextStyle(
                                                color: DEFAULT_BLACK,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Obx(
                                            () => Text(
                                              "  ${controller.order.value.orderDetails.first.price - controller.order.value.couponDiscount} Tk",
                                              style: TextStyle(
                                                  color: DEFAULT_BLACK,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, bottom: 15),
                              child: Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "images/shop_features/oditiya_logo.png",
                                    height: 100,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, bottom: 10),
                              child: Text(
                                "Receipt",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: DEFAULT_BLACK,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 120),
                              child: Container(
                                width: size.width,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 70,
                                      width: size.width * 0.45,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(Icons.receipt),
                                          Text(
                                            "DOWNLOAD",
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: DEFAULT_BLACK,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 70,
                                      width: size.width * 0.45,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(Icons.share),
                                          Text(
                                            "SHARE",
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: DEFAULT_BLACK,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Obx(
              () => controller.order.value.orderDetails.first.deliveryStatus ==
                      "completed"
                  ? Container()
                  : Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, bottom: 8),
                                  child: InkWell(
                                    onTap: () async {
                                      await controller.reject();
                                    },
                                    child: Container(
                                      height: 50,
                                      width: size.width * 0.45,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(color: Colors.red),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "REJECT",
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => controller.order.value.orderDetails
                                                  .first.deliveryStatus ==
                                              "accepted" ||
                                          controller.order.value.orderDetails
                                                  .first.deliveryStatus ==
                                              "shipped"
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15.0, bottom: 5),
                                          child: InkWell(
                                            onTap: () async {
                                              await controller.accept();
                                            },
                                            child: Container(
                                              height: 50,
                                              width: size.width * 0.45,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Colors.green,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 3,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "SHIPPED",
                                                  style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15.0, bottom: 5),
                                          child: InkWell(
                                            onTap: () async {
                                              await controller.accept();
                                            },
                                            child: Container(
                                              height: 50,
                                              width: size.width * 0.45,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Colors.green,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 3,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Accept",
                                                  style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "if you want accept the order Press the Button",
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: DEFAULT_BLACK,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_upward_rounded,
                                    size: 20,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
