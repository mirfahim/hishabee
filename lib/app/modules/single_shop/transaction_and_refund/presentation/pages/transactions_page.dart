import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/_bindings/transactions_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/manager/transaction_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/pages/transaction_details_screen.dart';
import 'package:intl/intl.dart';
import 'package:number_display/number_display.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:showcaseview/showcaseview.dart';

class TransactionPage extends GetView<TransactionController> {
  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(
          builder: (context) => TransactionsPage(
                controller: controller,
              )),
      // autoPlay: true,
      // autoPlayDelay: Duration(seconds: 3),
      // autoPlayLockEnable: true,
    );
  }
}

class TransactionsPage extends StatefulWidget {
  final TransactionController controller;
  TransactionsPage({
    this.controller,
  });

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  DateTime startDate;
  DateTime endDate;

  @override
  void initState() {
    super.initState();
  }

  final display = createDisplay();
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    int flag = 1;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text(
          'transaction_list'.tr,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: DEFAULT_BLACK,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.contact_support,
                size: 35,
                color: DEFAULT_BLUE,
              ),
              onPressed: () {
                widget.controller.openTrainingVideo(context);
              })
        ],
      ),
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () async {
          final result = await widget.controller.getAllTransaction();
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await widget.controller.getAllTransaction();
          if (result) {
            refreshController.loadComplete();
          } else {
            refreshController.loadFailed();
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                        color: DEFAULT_BLUE,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'total_sell'.tr,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(() => Text(
                                '৳${widget.controller.totalAmount.value.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 24,
                                    color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: TextFormField(
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9]'),
                          ),
                        ],
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xFFC4C4C4),
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xFFC4C4C4),
                              width: 1.5,
                            ),
                          ),
                          counterText: "",
                          hintText: 'search'.tr,
                          hintStyle: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12,
                            color: Color(0xFf707070),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Container(
                                    height: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height *
                                        0.75,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'filter'.tr,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Roboto'),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'select_date_due'.tr,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Roboto'),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GroupButton(
                                            spacing: size.width < 400
                                                ? 10
                                                : size.width > 400 &&
                                                        size.width < 550
                                                    ? 15
                                                    : 25,
                                            isRadio: true,
                                            unselectedBorderColor:
                                                DEFAULT_BLACK,
                                            selectedColor: Colors.black,
                                            unselectedColor: Colors.white,
                                            direction: Axis.horizontal,
                                            unselectedTextStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: DEFAULT_BLUE,
                                            ),
                                            onSelected: (index, isSelected) {
                                              switch (index) {
                                                case 0:
                                                  widget.controller
                                                      .getToDayTransaction();
                                                  break;
                                                case 1:
                                                  widget.controller
                                                      .getYesterdayTransaction();
                                                  break;
                                                case 2:
                                                  widget.controller
                                                      .getSevenDayTransaction();
                                                  break;
                                                case 3:
                                                  widget.controller
                                                      .getMonthTransaction();
                                                  break;
                                              }
                                            },
                                            buttons: [
                                              "today".tr,
                                              "yesterday".tr,
                                              "last_7_days".tr,
                                              "this_month".tr,
                                            ],
                                            selectedButton: 0,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          // Row(
                                          //   children: [
                                          //     Container(
                                          //       height: 40,
                                          //       width: 70,
                                          //       decoration: BoxDecoration(
                                          //         border: Border.all(color: Color(0XFFC4C4C4)),
                                          //         borderRadius: BorderRadius.circular(6),
                                          //       ),
                                          //       child: Center(
                                          //         child: Text(
                                          //           'গত মাস',
                                          //           style: TextStyle(fontSize: 14, color: Colors.black),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     SizedBox(
                                          //       width: 10,
                                          //     ),
                                          //     Container(
                                          //       height: 40,
                                          //       width: 70,
                                          //       decoration: BoxDecoration(
                                          //         border: Border.all(color: Color(0XFFC4C4C4)),
                                          //         borderRadius: BorderRadius.circular(6),
                                          //       ),
                                          //       child: Center(
                                          //         child: Text(
                                          //           'সময় সীমা',
                                          //           style: TextStyle(fontSize: 14, color: Colors.black),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //
                                          //   ],
                                          // ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'start_date'.tr,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: 'Roboto'),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFFF1F1F1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                'images/svg_image/calender.svg'),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                getDialog();
                                                              },
                                                              child: Text(
                                                                startDate !=
                                                                        null
                                                                    ? DateFormat(
                                                                            "dd MMM yyyy")
                                                                        .format(
                                                                            startDate)
                                                                    : "start_date"
                                                                        .tr,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      DEFAULT_BLUE,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'end_date'.tr,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: 'Roboto'),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFFF1F1F1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                'images/svg_image/calender.svg'),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              endDate != null
                                                                  ? DateFormat(
                                                                          "dd MMM yyyy")
                                                                      .format(
                                                                          endDate)
                                                                  : "end_date"
                                                                      .tr,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    DEFAULT_BLUE,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'select_sell_type'.tr,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Roboto'),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Radio(
                                                value: 'all_sell'.tr,
                                                groupValue: 'groupValue',
                                                onChanged: (value) {},
                                                activeColor: Colors.blue,
                                              ),
                                              Text(
                                                'all_sell'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 14),
                                              ),
                                              Radio(
                                                value: 'supplier'.tr,
                                                groupValue: 'groupValue',
                                                onChanged: (value) {},
                                              ),
                                              Text(
                                                'cash_sell'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 14),
                                              ),
                                              Radio(
                                                value: 'employee'.tr,
                                                groupValue: 'groupValue',
                                                onChanged: (value) {},
                                              ),
                                              Text(
                                                'quick_sell'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Radio(
                                                value: 'due'.tr,
                                                groupValue: 'groupValue',
                                                onChanged: (value) {},
                                              ),
                                              Text(
                                                'due'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 14),
                                              ),
                                              Radio(
                                                value: 'online'.tr,
                                                groupValue: 'groupValue',
                                                onChanged: (value) {},
                                              ),
                                              Text(
                                                'online'.tr,
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),

                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Center(
                                              child: Text(
                                                'confirm'.tr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontFamily: 'Roboto'),
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: DEFAULT_BLUE,
                                              fixedSize: Size(size.width, 50),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: SvgPicture.asset('images/svg_image/filter.svg'),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // Obx(() => widget.controller.showCaseTap.value == true
                //       ? Obx(() => OpacityAnimatedWidget.tween(
                //           opacityEnabled: 1, //define start value
                //           opacityDisabled: 0, //and end value
                //           enabled:
                //           widget.controller.showCase.value,
                //           child: Row(
                //             mainAxisAlignment:
                //             MainAxisAlignment.center,
                //             children: [
                //               Container(
                //                 decoration: BoxDecoration(
                //                   color: DEFAULT_BLACK,
                //                   borderRadius:
                //                   BorderRadius.circular(4),
                //                 ),
                //                 child: Padding(
                //                   padding:
                //                   const EdgeInsets.all(
                //                       8.0),
                //                   child: Text(
                //                     "transaction_page_showcase"
                //                         .tr,
                //                     style: TextStyle(
                //                         color: Colors.white,
                //                         fontSize: 16,
                //                         fontWeight:
                //                         FontWeight.bold),
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 child: Icon(
                //                   Icons.play_arrow_sharp,
                //                   size: 30,
                //                   color: DEFAULT_BLACK,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       )
                //       : Container(),
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: InkWell(
                //         onTap: () {
                //           getDialog();
                //         },
                //         child: Container(
                //           width: size.width * 0.4,
                //           height: 45,
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius:
                //             BorderRadius.circular(4),
                //             border: Border.all(
                //                 width: 0.5,
                //                 color: DEFAULT_BLUE),
                //           ),
                //           child: Row(
                //             mainAxisAlignment:
                //             MainAxisAlignment.spaceBetween,
                //             children: [
                //               Padding(
                //                 padding: const EdgeInsets.only(
                //                     left: 15.0),
                //                 child: Text(
                //                   startDate != null
                //                       ? DateFormat(
                //                       "dd MMM yyyy")
                //                       .format(startDate)
                //                       : "start_date".tr,
                //                   style: TextStyle(
                //                     fontFamily: 'Roboto',
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.bold,
                //                     color: DEFAULT_BLUE,
                //                   ),
                //                 ),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.only(
                //                     right: 8.0),
                //                 child: Icon(
                //                   Icons.arrow_drop_down,
                //                   size: 40,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 10,),
                //     Text(
                //       "to",
                //       style: TextStyle(
                //         fontFamily: 'Roboto',
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //         color: DEFAULT_BLACK,
                //       ),
                //     ),
                //     SizedBox(width: 10,),
                //     Expanded(
                //       child: InkWell(
                //         onTap: () async {
                //           CustomDialog.showStringDialog(
                //               "Please select start date first");
                //         },
                //         child: Container(
                //           width: size.width * 0.4,
                //           height: 45,
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius:
                //             BorderRadius.circular(4),
                //             border: Border.all(
                //                 width: 0.5,
                //                 color: DEFAULT_BLUE),
                //           ),
                //           child: Row(
                //             mainAxisAlignment:
                //             MainAxisAlignment.spaceBetween,
                //             children: [
                //               Padding(
                //                 padding: const EdgeInsets.only(
                //                     left: 15.0),
                //                 child: Text(
                //                   endDate != null
                //                       ? DateFormat(
                //                       "dd MMM yyyy")
                //                       .format(endDate)
                //                       : "end_date".tr,
                //                   style: TextStyle(
                //                     fontFamily: 'Rubik',
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.bold,
                //                     color: DEFAULT_BLUE,
                //                   ),
                //                 ),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.only(
                //                     right: 8.0),
                //                 child: Icon(
                //                   Icons.arrow_drop_down,
                //                   size: 40,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 10,
                ),

                Obx(
                  () => Container(
                    height: 350,
                    child: ListView.builder(
                      controller: ScrollController(),
                      scrollDirection: Axis.vertical,
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.controller.filterTransactionList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Transactions transaction =
                            widget.controller.filterTransactionList[index];
                        return InkWell(
                          onTap: () {
                            Get.to(
                                () => TransactionDetailsPage(
                                      shop: widget.controller.shop.value,
                                      transaction: transaction,
                                    ),
                                binding: TransactionsBinding());
                          },
                          child: Container(
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFF1F1F1),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '#${transaction.transactionBarcode.substring(0, 4)}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Roboto',
                                                color: Color(0xFF707070)),
                                          ),
                                          transaction.customerName == null
                                              ? ''
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Text(
                                                    '${transaction.customerName}',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xFF232323)),
                                                  ),
                                                ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              'Total Items: ${transaction.totalItem}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Roboto',
                                                  color: Color(0xFF707070)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${transaction.receivedAmount}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Roboto',
                                                color: Color(0xFF707070)),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    transaction.paymentStatus ==
                                                            'PAID'
                                                        ? Colors.green
                                                        : Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 5),
                                              child: Text(
                                                '${transaction.paymentStatus}'
                                                    .tr,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Roboto',
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 3.0),
                                            child: Text(
                                              '${DateFormat("dd MMM yyyy").format(transaction.createdAt)}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Roboto',
                                                  color: Color(0xFF707070)),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Container(
                //   height: 50,
                //   decoration: BoxDecoration(
                //     color: DEFAULT_BLUE,
                //     borderRadius: BorderRadius.only(
                //       topRight: Radius.circular(10),
                //       topLeft: Radius.circular(10),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getDialog() async {
    await _selectStartDate(context);
    await _selectEndDate(context);
    widget.controller.getRangeTransaction();
  }

  _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      helpText: "start_date".tr,
      context: context,
      initialDate: widget.controller.selectedStartDate.value, // Refer step 1
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
    if (picked != null && picked != widget.controller.selectedStartDate.value) {
      setState(() {
        widget.controller.selectedStartDate.value = picked;
        startDate = picked;
      });
    }
  }

  _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      helpText: "end_date".tr,
      context: context,
      initialDate: widget.controller.selectedEndDate.value, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: DEFAULT_BLACK,
              onPrimary: DEFAULT_BODY_BG_COLOR,
              surface: Colors.redAccent,
              onSurface: DEFAULT_BLACK,
            ),
            dialogBackgroundColor: DEFAULT_BODY_BG_COLOR,
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != widget.controller.selectedEndDate.value) {
      setState(() {
        widget.controller.selectedEndDate.value = picked;
        endDate = picked;
      });
    }
  }
}
