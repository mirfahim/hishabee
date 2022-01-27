import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/manager/transaction_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/pages/transaction_details_page.dart';
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
      autoPlay: true,
      autoPlayDelay: Duration(seconds: 3),
      autoPlayLockEnable: true,
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

  final desplay = createDisplay();
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
          child: Container(
            height: size.height - 50,
            width: size.width,
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
                              right: 15,
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
                                    'transaction_list'.tr,
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: DEFAULT_BLACK,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.contact_support,
                                      size: 35,
                                      color: DEFAULT_BLUE,
                                    ),
                                    onPressed: () {
                                      widget.controller
                                          .openTrainingVideo(context);
                                    })
                              ],
                            ),
                          ),
                          Obx(
                            () => widget.controller.showCaseTap.value == true
                                ? Positioned(
                                    right: 50,
                                    top: 21,
                                    child: Obx(
                                      () => OpacityAnimatedWidget.tween(
                                        opacityEnabled: 1, //define start value
                                        opacityDisabled: 0, //and end value
                                        enabled:
                                            widget.controller.showCase.value,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: DEFAULT_BLACK,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "transaction_page_showcase"
                                                          .tr,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Icon(
                                                Icons.play_arrow_sharp,
                                                size: 30,
                                                color: DEFAULT_BLACK,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 70.0,
                              left: 15,
                              right: 10,
                            ),
                            child: Text(
                              widget.controller.shop.value.name,
                              style: TextStyle(
                                fontFamily: 'Rubik-VariableFont_wght',
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: DEFAULT_BLUE,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 110.0, right: 10, left: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: size.width,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          getDialog();
                                        },
                                        child: Container(
                                          width: size.width * 0.4,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                width: 0.5,
                                                color: DEFAULT_BLUE),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: Text(
                                                  startDate != null
                                                      ? DateFormat(
                                                              "dd MMM yyyy")
                                                          .format(startDate)
                                                      : "start_date".tr,
                                                  style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: DEFAULT_BLUE,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 40,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "to",
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () async {
                                          CustomDialog.showStringDialog(
                                              "Please select start date first");
                                        },
                                        child: Container(
                                          width: size.width * 0.4,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                width: 0.5,
                                                color: DEFAULT_BLUE),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: Text(
                                                  endDate != null
                                                      ? DateFormat(
                                                              "dd MMM yyyy")
                                                          .format(endDate)
                                                      : "end_date".tr,
                                                  style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: DEFAULT_BLUE,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 40,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                  ),
                                  child: Container(
                                    width: size.width,
                                    child: GroupButton(
                                      spacing: size.width < 400
                                          ? 10
                                          : size.width > 400 && size.width < 550
                                              ? 15
                                              : 25,
                                      isRadio: true,
                                      unselectedBorderColor: DEFAULT_BLACK,
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
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 50),
                                  child: Obx(
                                    () => MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: widget.controller
                                            .filterTransactionList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Transactions transaction = widget
                                              .controller
                                              .filterTransactionList[index];
                                          return InkWell(
                                            onTap: () {
                                              Get.to(() =>
                                                  TransactionDetailsPage(
                                                    shop: widget
                                                        .controller.shop.value,
                                                    transaction: transaction,
                                                  ));
                                            },
                                            child: Container(
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
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: size.width * 0.37,
                                                      child: Text(
                                                        "${DateFormat('dd MMM yyyy | kk:mm a').format(transaction.createdAt)}",
                                                        style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: DEFAULT_BLUE,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        width:
                                                            size.width * 0.54,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      bottom:
                                                                          3),
                                                              child: Text(
                                                                "${transaction.totalItem} ",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Rubik',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      DEFAULT_BLACK,
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              "item".tr,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Rubik',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color:
                                                                    DEFAULT_BLACK,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          15.0),
                                                              child: Container(
                                                                height: 40,
                                                                child: Center(
                                                                  child: Text(
                                                                    "${desplay(transaction.totalPrice)} /=",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Rubik',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .teal,
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  ),
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
                                            ),
                                          );
                                        },
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
                    height: 50,
                    decoration: BoxDecoration(
                      color: DEFAULT_BLUE,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            "total_colon".tr,
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Obx(
                            () => Text(
                              "tk".tr +
                                  " ${widget.controller.totalAmount.value} /=",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
