import 'dart:async';

import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/help_button_box.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/overlay_youtube_video.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/_binding/shop_features_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/pages/digital_balance_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/widgets/advance_items_list.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/_bindings/transactions_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/pages/transactions_page.dart';
import 'package:intl/intl.dart';
import 'package:number_display/number_display.dart';
import 'package:showcaseview/showcaseview.dart';

class AdvancePage extends StatefulWidget {
  final Shop shop;

  AdvancePage({
    this.shop,
  });

  @override
  _AdvancePageState createState() => _AdvancePageState();
}

class _AdvancePageState extends State<AdvancePage> {
  GlobalKey one = GlobalKey();
  GlobalKey two = GlobalKey();
  GlobalKey three = GlobalKey();

  String _timeString;
  Timer _timer;

  bool showCase = true;

  var showCaseTap;

  final display = createDisplay();

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    _timer = new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        _getTime();
      },
    );
    getBox();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([one, two, three]));
    Future.delayed(const Duration(seconds: 5), () {
      showCase = false;
    });
    super.initState();
  }

  getBox() {
    HelpButton.getBox(ButtonKey.dashKey).then((value) => {
          setState(() {
            showCaseTap = value;
          })
        });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: DEFAULT_BODY_BG_COLOR,
        body: Stack(
          children: [
            ListView(
              children: [
                _showHeader(),
                AdvanceItemsList(shop: widget.shop),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showHeader() => Column(
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
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 5.0, left: 20, right: 20),
                    child: Text(
                      widget.shop.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik-VariableFont_wght',
                        color: DEFAULT_BLUE_DARK,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 14, right: 15.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.contact_support,
                          size: 35,
                          color: DEFAULT_BLUE,
                        ),
                        onPressed: () {
                          final String url = "https://youtu.be/Wbk83HfsJ4w";
                          final String title = "use_showcase".tr;
                          HelpButton.setBox(ButtonKey.dashKey);
                          Navigator.of(context)
                              .push(TutorialOverlay(url, title));
                        }),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 45.0, left: 20, right: 20),
                child: Text(
                  _timeString,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: DEFAULT_BLUE,
                  ),
                ),
              ),
              showCaseTap == true
                  ? Positioned(
                      right: 60,
                      top: 22,
                      child: OpacityAnimatedWidget.tween(
                        opacityEnabled: 1, //define start value
                        opacityDisabled: 0, //and end value
                        enabled: showCase,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: DEFAULT_BLACK,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "use_showcase".tr,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
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
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(
                  top: 80.0,
                ),
                child: Container(
                    height: 135,
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Card(
                      elevation: 6.0,
                      child: Column(
                        children: [
                          Container(
                            color: Theme.of(context).primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Text(
                                      'today_s_sale'.tr,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal,
                                        color: DEFAULT_BLACK,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "tk".tr,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: DEFAULT_BLUE,
                                          ),
                                        ),
                                        Obx(
                                          () => Text(
                                            ' ${display(Get.find<ShopFeaturesController>().todaysSale.value)}',
                                            style: TextStyle(
                                              fontFamily:
                                                  'Rubik-VariableFont_wght',
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: DEFAULT_BLUE,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '/=',
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: DEFAULT_BLUE,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.amber[50],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                    onTap: () {
                                      // Get.to(() => ExpensesPage(),
                                      //     binding: ShopFeaturesBinding(),
                                      //     arguments: widget.shop);
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Today\'s Expense',
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            ' ${widget.shop.walletBalance}',
                                            style: TextStyle(
                                              fontFamily:
                                                  'Rubik-VariableFont_wght',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: Colors.grey[300],
                                    height: 40,
                                    width: 2,
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      // Get.to(
                                      //   () =>
                                      //       DigitalBalancePage(widget.shop),
                                      //   binding: ShopFeaturesBinding(),
                                      // );
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Today\'s Due',
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            ' ${widget.shop.walletBalance}',
                                            style: TextStyle(
                                              fontFamily:
                                                  'Rubik-VariableFont_wght',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: DEFAULT_BLUE,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: Colors.grey[300],
                                    height: 40,
                                    width: 2,
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => DigitalBalancePage(widget.shop),
                                        binding: ShopFeaturesBinding(),
                                      );
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Digital Balance',
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            ' ${widget.shop.walletBalance}',
                                            style: TextStyle(
                                              fontFamily:
                                                  'Rubik-VariableFont_wght',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
        ],
      );
  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy | hh:mm a').format(dateTime);
  }
}
