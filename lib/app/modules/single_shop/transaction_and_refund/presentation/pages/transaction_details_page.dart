import 'package:cached_network_image/cached_network_image.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/_bindings/transactions_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/pages/exchange_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/pages/widgets/transaction_receipt.dart';
import 'package:intl/intl.dart';
import 'package:number_display/number_display.dart';

class TransactionDetailsPage extends StatelessWidget {
  final Transactions transaction;
  final Shop shop;

  const TransactionDetailsPage({Key key, this.transaction, this.shop})
      : super(key: key);

  List<TransactionItem> getUniqueItems() {
    List res = transaction.transactionItems.distinct((el) => el.id).toList();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final itemList = getUniqueItems();
    final display = createDisplay();
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      appBar: AppBar(
        title: Text(
          'transaction_details'.tr,
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: DEFAULT_BLACK,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 15,
                right: 15,
              ),
              child: Text(
                "${shop.name}",
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: DEFAULT_BLACK,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0, left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    height: size.height < 570
                        ? size.height * 0.5
                        : size.height * 0.62,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: itemList.length,
                        itemBuilder: (BuildContext context, int index) {
                          TransactionItem item = itemList[index];
                          final display = createDisplay();
                          return Container(
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.grey),
                              ),
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
                            child: Container(
                              margin: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                        width: 50,
                                        height: 50,
                                        color: Colors.transparent,
                                        child: item.imageSrc != null
                                            ? CachedNetworkImage(
                                                imageUrl: item.imageSrc,
                                                fit: BoxFit.cover,
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              )
                                            : Image.asset(
                                                "images/hishabeeLogo.png",
                                                height: 50,
                                                width: 50,
                                              )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Center(
                                      child: Container(
                                        width: size.width * 0.3,
                                        child: item.id == null
                                            ? Column(
                                                children: [
                                                  Container(
                                                    color: Colors.grey,
                                                    child: Text(
                                                      item.name,
                                                      style: TextStyle(
                                                        fontFamily: 'Rubik',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DEFAULT_BLACK,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    width: size.width * 0.3,
                                                    color: Colors.grey,
                                                    child: Text(
                                                      "${item.subCategory}",
                                                      style: TextStyle(
                                                        fontFamily: 'Rubik',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: DEFAULT_BLACK,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Text(
                                                "[Quick Sell]",
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: DEFAULT_BLACK,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Container(
                                      width: size.width * 0.15,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              "X",
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: DEFAULT_BLACK,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            child: Text(
                                              "${item.quantity}",
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: DEFAULT_BLACK,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0.0, right: 5),
                                    child: Container(
                                      width: size.width * 0.2,
                                      child: Text(
                                        "tk".tr + " ${display(item.price)}",
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLUE,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Container(
                  child: Column(
                    children: [
                      Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.5,
                            child: Row(
                              children: [
                                Text(
                                  "total_item".tr,
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: DEFAULT_BLACK,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${transaction.totalItem}",
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: DEFAULT_BLACK,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Container(
                              width: size.width * 0.4,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "${display(transaction.totalPrice)} " +
                                      "tk".tr,
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: DEFAULT_BLUE,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.6,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "payment_method".tr,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: DEFAULT_BLACK,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      transaction.paymentMethod == 1
                                          ? "Cash"
                                          : "Digital",
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: DEFAULT_BLACK,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "customer_name_colon".tr,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: DEFAULT_BLACK,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      transaction.customerName != null
                                          ? "${transaction.customerName}"
                                          : "not_given".tr,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: DEFAULT_BLACK,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: size.width * 0.2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                DateFormat('dd MMM yyyy kk:mm a')
                                    .format(transaction.createdAt),
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: DEFAULT_BLUE,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.15,
                            child: Text(
                              "note_colon".tr,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: DEFAULT_BLACK,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: size.width * 0.5,
                            child: Text(
                              transaction.note != null
                                  ? "${transaction.note}"
                                  : "not_given".tr,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: DEFAULT_BLUE,
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                              ),
                              child: InkWell(
                                onTap: () async {
                                  Get.to(() => TransactionReceiptPage(
                                        shop: shop,
                                        transaction: transaction,
                                      ));
                                },
                                child: Container(
                                  width: size.width * 0.35,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: DEFAULT_YELLOW_BG,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "view_receipt".tr,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK,
                                        fontSize: 14,
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
                                  Get.to(() => TransactionReceiptPage(
                                        shop: shop,
                                        transaction: transaction,
                                      ));
                                },
                                child: Container(
                                  width: size.width * 0.35,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: DEFAULT_YELLOW_BG,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "share_receipt".tr,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => ExchangePage(),
                              arguments: {
                                "transaction": transaction,
                                "shop": shop,
                              },
                              binding: TransactionsBinding());
                        },
                        child: Container(
                          height: 40,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: DEFAULT_BLACK,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              "edit".tr,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
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
