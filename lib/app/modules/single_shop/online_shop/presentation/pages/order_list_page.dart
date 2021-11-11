import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/_bindings/store_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/online_order_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/order_status.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/order_list_controller.dart';
import 'package:intl/intl.dart';

import 'order_details_page.dart';

class OrderListPage extends GetResponsiveView<OrderListController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_YELLOW_BG,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: Row(
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
                    "Online Order",
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
              padding: const EdgeInsets.only(top: 95.0),
              child: DefaultTabController(
                length: 3,
                initialIndex: 0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
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
                                "New Order",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Tab(
                              icon: Text(
                                "Active",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Tab(
                              icon: Text(
                                "Complete",
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          child: TabBarView(
                            children: <Widget>[
                              Container(
                                height: size.height - 125,
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: DEFAULT_BODY_BG_COLOR,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    )),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: 50,
                                            width: size.width * 0.7,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
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
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.search,
                                                    size: 25,
                                                    color: Colors.grey,
                                                  ),
                                                  Container(
                                                    width: size.width * 0.55,
                                                    child: TextFormField(
                                                      onChanged: (value) {
                                                        controller
                                                            .searchNewOrders(
                                                                value);
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(8),
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        hintText: "search",
                                                        hintStyle: TextStyle(
                                                          color:
                                                              Colors.blueGrey,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "All",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_drop_down_sharp,
                                                  size: 30,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 20, right: 20),
                                        child: Container(
                                          child: Obx(
                                            () => ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: controller
                                                    .filteredNewOrders.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  OnlineOrder order = controller
                                                      .filteredNewOrders[index];

                                                  return InkWell(
                                                    onTap: () {
                                                      Get.to(
                                                        () =>
                                                            OrderDetailsPage(),
                                                        arguments: {
                                                          "order": order
                                                        },
                                                        binding: StoreBinding(),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 3,
                                                              offset: Offset(0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    width: size
                                                                            .width *
                                                                        0.65,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        "${order.code}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                DEFAULT_BLACK,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              8.0,
                                                                          bottom:
                                                                              8,
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          PopupMenuButton(
                                                                        itemBuilder:
                                                                            (context) {
                                                                          return [
                                                                            PopupMenuItem(
                                                                              value: 0,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PENDING || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_ACCEPTED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PROCESSING || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_SHIPPED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_DELIVERED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_CANCELED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              // enabled: order.paymentStatus == OrderStatus.ORDER_PENDING,
                                                                              child: Text(OrderStatus.ORDER_PENDING.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 1,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_ACCEPTED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PROCESSING || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_SHIPPED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_DELIVERED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_CANCELED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              child: Text(OrderStatus.ORDER_ACCEPTED.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 2,
                                                                              enabled: order.paymentStatus == OrderStatus.ORDER_PROCESSING,
                                                                              child: Text(OrderStatus.ORDER_PROCESSING.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 3,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PENDING ||
                                                                                  // order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_ACCEPTED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PROCESSING ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_SHIPPED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_DELIVERED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_CANCELED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              child: Text(OrderStatus.ORDER_SHIPPED.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 4,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PENDING ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_ACCEPTED ||
                                                                                  // order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PROCESSING ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_SHIPPED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_DELIVERED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_CANCELED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              child: Text(OrderStatus.ORDER_DELIVERED.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 5,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              child: Text(OrderStatus.ORDER_CANCELED.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 6,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PENDING ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_ACCEPTED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PROCESSING ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_SHIPPED ||
                                                                                  // order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_DELIVERED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_CANCELED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              child: Text(OrderStatus.ORDER_COMPLETED.toUpperCase()),
                                                                            ),
                                                                          ];
                                                                        },
                                                                        onSelected:
                                                                            (value) async {
                                                                          switch (
                                                                              value) {
                                                                            case 0:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_PENDING);
                                                                              break;
                                                                            case 1:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_ACCEPTED);

                                                                              break;
                                                                            case 2:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_PROCESSING);
                                                                              break;
                                                                            case 3:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_SHIPPED);
                                                                              break;
                                                                            case 4:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_DELIVERED);

                                                                              break;
                                                                            case 5:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_CANCELED);

                                                                              break;
                                                                            case 6:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_COMPLETED);

                                                                              break;
                                                                          }
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              25,
                                                                          width:
                                                                              70,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(4),
                                                                              color: Colors.red),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                size.width * 0.2,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                order.orderDetails.first.deliveryStatus != null ? order.orderDetails.first.deliveryStatus.toUpperCase() : "Not Set Yet",
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(color: Colors.white, fontSize: 11),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Image
                                                                          .asset(
                                                                        "images/icons/profile_placeholder.png",
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            30,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 8,
                                                                        bottom:
                                                                            8),
                                                                    child:
                                                                        Container(
                                                                      width: size
                                                                              .width *
                                                                          0.7,
                                                                      child:
                                                                          Text(
                                                                        "${order.shippingAddress.name}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                DEFAULT_BLACK,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .money_outlined,
                                                                        size:
                                                                            30,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        top:
                                                                            8.0,
                                                                        bottom:
                                                                            8,
                                                                      ),
                                                                      child: Text(
                                                                          "${order.orderDetails.first.price}",
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: DEFAULT_BLACK,
                                                                              fontWeight: FontWeight.normal)),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .shopping_cart_rounded,
                                                                        size:
                                                                            30,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        top:
                                                                            8.0,
                                                                        bottom:
                                                                            8,
                                                                      ),
                                                                      child: Text(
                                                                          "${order.orderDetails.first.quantity} item",
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: DEFAULT_BLACK,
                                                                              fontWeight: FontWeight.normal)),
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0,
                                                                        bottom:
                                                                            8,
                                                                        right:
                                                                            10),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "${DateFormat('dd MMM yyyy').format(order.createdAt)}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                DEFAULT_BLACK,
                                                                            fontWeight:
                                                                                FontWeight.normal),
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
                                                  );
                                                }),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: size.height - 125,
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: DEFAULT_BODY_BG_COLOR,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    )),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: 50,
                                            width: size.width * 0.7,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
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
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.search,
                                                    size: 25,
                                                    color: Colors.grey,
                                                  ),
                                                  Container(
                                                    width: size.width * 0.55,
                                                    child: TextFormField(
                                                      onChanged: (value) {
                                                        controller
                                                            .searchCurrentOrders(
                                                                value);
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(8),
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        hintText: "search",
                                                        hintStyle: TextStyle(
                                                          color:
                                                              Colors.blueGrey,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "All",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_drop_down_sharp,
                                                  size: 30,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 20, right: 20),
                                        child: Container(
                                          child: Obx(
                                            () => ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: controller
                                                    .filteredCurrentOrders
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  OnlineOrder order = controller
                                                          .filteredCurrentOrders[
                                                      index];
                                                  return InkWell(
                                                    onTap: () {
                                                      Get.to(
                                                        () =>
                                                            OrderDetailsPage(),
                                                        arguments: {
                                                          "order": order
                                                        },
                                                        binding: StoreBinding(),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 3,
                                                              offset: Offset(0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    width: size
                                                                            .width *
                                                                        0.65,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        "${order.code}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                DEFAULT_BLACK,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              8.0,
                                                                          bottom:
                                                                              8,
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          PopupMenuButton(
                                                                        itemBuilder:
                                                                            (context) {
                                                                          return [
                                                                            PopupMenuItem(
                                                                              value: 0,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PENDING || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_ACCEPTED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PROCESSING || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_SHIPPED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_DELIVERED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_CANCELED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              // enabled: order.paymentStatus == OrderStatus.ORDER_PENDING,
                                                                              child: Text(OrderStatus.ORDER_PENDING.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 1,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_ACCEPTED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PROCESSING || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_SHIPPED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_DELIVERED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_CANCELED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              child: Text(OrderStatus.ORDER_ACCEPTED.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 2,
                                                                              enabled: order.paymentStatus == OrderStatus.ORDER_PROCESSING,
                                                                              child: Text(OrderStatus.ORDER_PROCESSING.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 3,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PENDING ||
                                                                                  // order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_ACCEPTED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PROCESSING ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_SHIPPED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_DELIVERED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_CANCELED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              child: Text(OrderStatus.ORDER_SHIPPED.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 4,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PENDING ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_ACCEPTED ||
                                                                                  // order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PROCESSING ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_SHIPPED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_DELIVERED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_CANCELED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              child: Text(OrderStatus.ORDER_DELIVERED.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 5,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              child: Text(OrderStatus.ORDER_CANCELED.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 6,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PENDING ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_ACCEPTED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PROCESSING ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_SHIPPED ||
                                                                                  // order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_DELIVERED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_CANCELED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              child: Text(OrderStatus.ORDER_COMPLETED.toUpperCase()),
                                                                            ),
                                                                          ];
                                                                        },
                                                                        onSelected:
                                                                            (value) async {
                                                                          switch (
                                                                              value) {
                                                                            case 0:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_PENDING);
                                                                              break;
                                                                            case 1:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_ACCEPTED);

                                                                              break;
                                                                            case 2:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_PROCESSING);
                                                                              break;
                                                                            case 3:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_SHIPPED);
                                                                              break;
                                                                            case 4:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_DELIVERED);

                                                                              break;
                                                                            case 5:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_CANCELED);

                                                                              break;
                                                                            case 6:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_COMPLETED);

                                                                              break;
                                                                          }
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              25,
                                                                          width:
                                                                              70,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(4),
                                                                              color: Colors.red),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                size.width * 0.2,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                order.orderDetails.first.deliveryStatus != null ? order.orderDetails.first.deliveryStatus.toUpperCase() : "Not Set Yet",
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(color: Colors.white, fontSize: 11),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Image
                                                                          .asset(
                                                                        "images/icons/profile_placeholder.png",
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            30,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 8,
                                                                        bottom:
                                                                            8),
                                                                    child:
                                                                        Container(
                                                                      width: size
                                                                              .width *
                                                                          0.7,
                                                                      child:
                                                                          Text(
                                                                        "${order.shippingAddress.name}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                DEFAULT_BLACK,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .money_outlined,
                                                                        size:
                                                                            30,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        top:
                                                                            8.0,
                                                                        bottom:
                                                                            8,
                                                                      ),
                                                                      child: Text(
                                                                          "${order.orderDetails.first.price}",
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: DEFAULT_BLACK,
                                                                              fontWeight: FontWeight.normal)),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .shopping_cart_rounded,
                                                                        size:
                                                                            30,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        top:
                                                                            8.0,
                                                                        bottom:
                                                                            8,
                                                                      ),
                                                                      child: Text(
                                                                          "${order.orderDetails.first.quantity} item",
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: DEFAULT_BLACK,
                                                                              fontWeight: FontWeight.normal)),
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0,
                                                                        bottom:
                                                                            8,
                                                                        right:
                                                                            10),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "${DateFormat('dd MMM yyyy').format(order.createdAt)}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                DEFAULT_BLACK,
                                                                            fontWeight:
                                                                                FontWeight.normal),
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
                                                  );
                                                }),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: size.height - 125,
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: DEFAULT_BODY_BG_COLOR,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    )),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: 50,
                                            width: size.width * 0.7,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
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
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.search,
                                                    size: 25,
                                                    color: Colors.grey,
                                                  ),
                                                  Container(
                                                    width: size.width * 0.55,
                                                    child: TextFormField(
                                                      onChanged: (value) {
                                                        controller
                                                            .searchCompletedOrders(
                                                                value);
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(8),
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        hintText: "search",
                                                        hintStyle: TextStyle(
                                                          color:
                                                              Colors.blueGrey,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "All",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_drop_down_sharp,
                                                  size: 30,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 20, right: 20),
                                        child: Container(
                                          child: Obx(
                                            () => ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: controller
                                                    .filteredCompletedOrders
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  OnlineOrder order = controller
                                                          .filteredCompletedOrders[
                                                      index];
                                                  return InkWell(
                                                    onTap: () {
                                                      Get.to(
                                                        () =>
                                                            OrderDetailsPage(),
                                                        arguments: {
                                                          "order": order
                                                        },
                                                        binding: StoreBinding(),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 3,
                                                              offset: Offset(0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    width: size
                                                                            .width *
                                                                        0.65,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        "${order.code}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                DEFAULT_BLACK,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              8.0,
                                                                          bottom:
                                                                              8,
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          PopupMenuButton(
                                                                        itemBuilder:
                                                                            (context) {
                                                                          return [
                                                                            PopupMenuItem(
                                                                              value: 0,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PENDING || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_ACCEPTED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PROCESSING || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_SHIPPED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_DELIVERED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_CANCELED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              // enabled: order.paymentStatus == OrderStatus.ORDER_PENDING,
                                                                              child: Text(OrderStatus.ORDER_PENDING.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 1,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_ACCEPTED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PROCESSING || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_SHIPPED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_DELIVERED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_CANCELED || order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              child: Text(OrderStatus.ORDER_ACCEPTED.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 2,
                                                                              enabled: order.paymentStatus == OrderStatus.ORDER_PROCESSING,
                                                                              child: Text(OrderStatus.ORDER_PROCESSING.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 3,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PENDING ||
                                                                                  // order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_ACCEPTED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PROCESSING ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_SHIPPED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_DELIVERED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_CANCELED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              child: Text(OrderStatus.ORDER_SHIPPED.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 4,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PENDING ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_ACCEPTED ||
                                                                                  // order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PROCESSING ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_SHIPPED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_DELIVERED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_CANCELED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              child: Text(OrderStatus.ORDER_DELIVERED.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 5,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              child: Text(OrderStatus.ORDER_CANCELED.toUpperCase()),
                                                                            ),
                                                                            PopupMenuItem(
                                                                              value: 6,
                                                                              enabled: !(order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PENDING ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_ACCEPTED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_PROCESSING ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_SHIPPED ||
                                                                                  // order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_DELIVERED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_CANCELED ||
                                                                                  order.orderDetails.first.deliveryStatus == OrderStatus.ORDER_COMPLETED),
                                                                              child: Text(OrderStatus.ORDER_COMPLETED.toUpperCase()),
                                                                            ),
                                                                          ];
                                                                        },
                                                                        onSelected:
                                                                            (value) async {
                                                                          switch (
                                                                              value) {
                                                                            case 0:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_PENDING);
                                                                              break;
                                                                            case 1:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_ACCEPTED);

                                                                              break;
                                                                            case 2:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_PROCESSING);
                                                                              break;
                                                                            case 3:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_SHIPPED);
                                                                              break;
                                                                            case 4:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_DELIVERED);

                                                                              break;
                                                                            case 5:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_CANCELED);

                                                                              break;
                                                                            case 6:
                                                                              await controller.updateStatus(order.id, OrderStatus.ORDER_COMPLETED);

                                                                              break;
                                                                          }
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              25,
                                                                          width:
                                                                              70,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(4),
                                                                              color: Colors.red),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                size.width * 0.2,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                order.orderDetails.first.deliveryStatus != null ? order.orderDetails.first.deliveryStatus.toUpperCase() : "Not Set Yet",
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(color: Colors.white, fontSize: 11),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Image
                                                                          .asset(
                                                                        "images/icons/profile_placeholder.png",
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            30,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 8,
                                                                        bottom:
                                                                            8),
                                                                    child:
                                                                        Container(
                                                                      width: size
                                                                              .width *
                                                                          0.7,
                                                                      child:
                                                                          Text(
                                                                        "${order.shippingAddress.name}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                DEFAULT_BLACK,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .money_outlined,
                                                                        size:
                                                                            30,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        top:
                                                                            8.0,
                                                                        bottom:
                                                                            8,
                                                                      ),
                                                                      child: Text(
                                                                          "${order.orderDetails.first.price}",
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: DEFAULT_BLACK,
                                                                              fontWeight: FontWeight.normal)),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .shopping_cart_rounded,
                                                                        size:
                                                                            30,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        top:
                                                                            8.0,
                                                                        bottom:
                                                                            8,
                                                                      ),
                                                                      child: Text(
                                                                          "${order.orderDetails.first.quantity} item",
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: DEFAULT_BLACK,
                                                                              fontWeight: FontWeight.normal)),
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0,
                                                                        bottom:
                                                                            8,
                                                                        right:
                                                                            10),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "${DateFormat('dd MMM yyyy').format(order.createdAt)}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                DEFAULT_BLACK,
                                                                            fontWeight:
                                                                                FontWeight.normal),
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
                                                  );
                                                }),
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
