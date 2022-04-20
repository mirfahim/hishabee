import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/_bindings/transactions_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/new_transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/manager/exchange_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/manager/transaction_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/pages/exchange_payment_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/pages/exchange_sell_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/pages/transaction_sell_page.dart';

class ExchangePage extends StatefulWidget {
  String uniqueID;
  List itemList;
  ExchangePage({this.uniqueID, this.itemList});
//  final SellController sc = Get.find();
  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  List<TransactionItem> _list = <TransactionItem>[];
  List<TransactionItem> _foundData = <TransactionItem>[];
  ExchangeController controller = Get.find();
  getData() {
    print("my unique id is ${widget.uniqueID}");
    controller
        .getALlTransactionItemByUniqueID(uniqueID: widget.uniqueID)
        .then((value) {
      if (value != null) {
        _list = transactionModelFromJson(value);
        _foundData = _list;
        print("my list is +++++++++$_foundData");
        print(_foundData.length);
        // checkingDone = true;

      }

      //  isLoading = false;
    });
    return _foundData;
  }

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
                          top: 20.0,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                size: 25,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Expanded(
                              child: Text(
                                'exchange'.tr,
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
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 70.0,
                          left: 10,
                          right: 10,
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: size.width,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(width: 0.5, color: Colors.black),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: size.width * 0.42,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.delete_forever,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          'indicates'.tr,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          'refund'.tr,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: VerticalDivider(
                                      color: DEFAULT_BLACK,
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.42,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.compare_arrows,
                                          color: Colors.green,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          'indicates'.tr,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          'exchange'.tr,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                height: size.height < 570
                                    ? size.height * 0.5
                                    : size.height * 0.62,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Obx(
                                  () => MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: ListView.builder(
                                      itemCount:
                                          //   sc.cart.l
                                          widget.itemList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        TransactionItem item =
                                            widget.itemList[index];
                                        return Container(
                                          height: 80,
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
                                          child: Row(
                                            children: [
                                              Container(
                                                width: size.width * 0.44,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                          ),
                                                          child: item.imageSrc !=
                                                                  null
                                                              ? CachedNetworkImage(
                                                                  imageUrl: item
                                                                      .imageSrc,
                                                                  progressIndicatorBuilder: (context,
                                                                          url,
                                                                          downloadProgress) =>
                                                                      CircularProgressIndicator(
                                                                          value:
                                                                              downloadProgress.progress),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
                                                                )
                                                              : Image.asset(
                                                                  "images/hishabeeLogo.png")),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      width: 95,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              item.name ??
                                                                  "Name Not Found",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Rubik',
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    DEFAULT_BLACK,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            width: 100,
                                                            child: Text(
                                                              "tk".tr +
                                                                  " ${item.price}",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Rubik',
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    DEFAULT_BLACK,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: size.width * 0.5,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        "X",
                                                        style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.grey,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        "${item.quantity}",
                                                        style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: DEFAULT_BLUE,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          controller
                                                              .removeItem(item);
                                                          Get.snackbar(
                                                              "Item Refunded",
                                                              "${item.name}",
                                                              backgroundColor:
                                                                  Colors.white,
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          3),
                                                              mainButton:
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        controller
                                                                            .addItemToCartAgain();
                                                                      },
                                                                      child: Text(
                                                                          "Add to cart again")));
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.5),
                                                                spreadRadius: 2,
                                                                blurRadius: 7,
                                                                offset: Offset(
                                                                    0,
                                                                    3), // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .delete_forever,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0,
                                                              right: 15),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          var result = await Get.to(
                                                              () =>
                                                                  ExchangeSellPage(),
                                                              arguments: {
                                                                "shop":
                                                                    controller
                                                                        .shop
                                                                        .value,
                                                                "transaction":
                                                                    controller
                                                                        .transaction
                                                                        .value,
                                                                "item": item,
                                                              },
                                                              binding:
                                                                  TransactionsBinding());
                                                          controller.transaction
                                                                  .value =
                                                              result
                                                                  as Transactions;
                                                          print(
                                                              "TP : ${controller.transaction.value.totalPrice}");
                                                          controller.initData();
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.5),
                                                                spreadRadius: 2,
                                                                blurRadius: 7,
                                                                offset: Offset(
                                                                    0,
                                                                    3), // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .compare_arrows,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
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
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    //topLeft: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "total".tr,
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: DEFAULT_BLACK,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Obx(
                            () => Text(
                              "tk".tr + "  ${controller.totalPrice.value} /=",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: DEFAULT_BLUE,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                          ),
                          child: InkWell(
                            onTap: () async {
                              var result =
                                  await Get.to(() => TransactionSellPage(),
                                      arguments: {
                                        "shop": controller.shop.value,
                                        "transaction":
                                            controller.transaction.value,
                                      },
                                      binding: TransactionsBinding());
                              controller.transaction.value =
                                  result as Transactions;
                              controller.initData();
                            },
                            child: Container(
                              width: size.width * 0.45,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: DEFAULT_YELLOW_BG,
                              ),
                              child: Center(
                                child: Text(
                                  "add_product".tr,
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.bold,
                                    color: DEFAULT_BLACK,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: InkWell(
                            onTap: () {
                              Get.to(() => ExchangePaymentPage(),
                                  arguments: {
                                    "shop": controller.shop.value,
                                    "transaction": controller.transaction.value,
                                    "previousPrice":
                                        controller.beforeTotalPrice.value,
                                    "transactionItem":
                                        controller.transactionItemList,
                                    "transactionOldItem":
                                        controller.transactionItemOldList,
                                  },
                                  binding: TransactionsBinding());
                            },
                            child: Container(
                              width: size.width * 0.45,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: DEFAULT_BLACK,
                              ),
                              child: Center(
                                child: Text(
                                  "confirm".tr,
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
                      ],
                    ),
                    Spacer(),
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
