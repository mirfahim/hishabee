import 'dart:async';

import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/help_button_box.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/overlay_youtube_video.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/pages/advance_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/pages/standard_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/_navigation/settings_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/presentation/pages/expenses_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/_binding/shop_features_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/pages/digital_balance_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/widgets/shop_items_list.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/_bindings/transactions_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/pages/transactions_page.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/expense/expense_front.dart';
import 'package:intl/intl.dart';
import 'package:number_display/number_display.dart';
import 'package:showcaseview/showcaseview.dart';

class ShopFeatureShowCase extends StatelessWidget {
  final Shop shop;
  ShopFeatureShowCase({this.shop});

  @override
  Widget build(BuildContext context) {
    final PageController pageViewController = PageController(initialPage: 1);
    return GetBuilder<ShopFeaturesController>(builder: (controller) {
      return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              pageViewController.animateToPage(index,
                  duration: Duration(milliseconds: 20), curve: Curves.easeIn);
            },
            unselectedItemColor: Colors.black,
            // selectedIconTheme: IconThemeData(color: Colors.amber),
            selectedItemColor: Colors.amber,
            showSelectedLabels: true,
            currentIndex: controller.tabIndex,
            showUnselectedLabels: true,

          //  type: BottomNavigationBarType.shifting,
            items: [
              _bottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'images/icons/med.svg',
                ),
                label: 'Standard',
                activeIcon: SvgPicture.asset(
                  'images/icons/med.svg',
                  color: Colors.amber,

                ),
              ),

              _bottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'images/icons/book.svg',
                ),
                label: 'Tally',
                activeIcon: SvgPicture.asset(
                  'images/icons/book.svg',
                  color: Colors.amber,
                ),
              ),
              _bottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'images/icons/tick.svg',
                ),
                label: 'Advanced',
                activeIcon: SvgPicture.asset(
                  'images/icons/tick.svg',
                  color: Colors.amber,
                ),
              )
            ],
          ),
          body: ShowCaseWidget(
            builder: Builder(
                builder: (context) => PageView(
                      controller: pageViewController,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (page) {
                        controller.changeTabIndex(page);
                      },
                      children: [
                        StandardPage(
                          shop: shop,
                        ),
                        ShopFeaturesPage(
                          shop: shop,
                        ),
                        AdvancePage(
                          shop: shop,
                        )
                      ],
                    )),
            // autoPlay: true,
            // autoPlayDelay: Duration(seconds: 3),
            // autoPlayLockEnable: true,
          ));
    });
  }

  _bottomNavigationBarItem({Widget icon, String label, Widget activeIcon, }) {
    return BottomNavigationBarItem(
        icon: icon, label: label, activeIcon: activeIcon);
  }
}

class ShopFeaturesPage extends StatefulWidget {
  final Shop shop;

  ShopFeaturesPage({
    this.shop,
  });

  @override
  _ShopFeaturesPageState createState() => _ShopFeaturesPageState();
}

class _ShopFeaturesPageState extends State<ShopFeaturesPage> {
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.shop.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      color: DEFAULT_BLUE_DARK,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          child: Icon(
                            Icons.contact_support,
                            size: 30,
                            color: DEFAULT_BLUE,
                          ),
                          onTap: () {
                            final String url = "https://youtu.be/Wbk83HfsJ4w";
                            final String title = "use_showcase".tr;
                            HelpButton.setBox(ButtonKey.dashKey);
                            Navigator.of(context)
                                .push(TutorialOverlay(url, title));
                          }),
                      SizedBox(width: 10,),
                      GestureDetector(

                          onTap: (){
                            Get.toNamed(
                              SettingsRoutes.SETTINGS,
                              arguments: {
                                "shop": widget.shop,
                              },
                            );
                          }, child: Icon(Icons.settings, color: DEFAULT_BLUE, size: 30,))
                    ],
                  )
                ],
              ),
              Text(
                _timeString,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: DEFAULT_BLUE,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            _showHeader(),
            ShopItemsList(shop: widget.shop),
          ],
        ),
      ),
    );
  }

  _showHeader() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Row(
      //   children: [
      //     Padding(
      //       padding:
      //           const EdgeInsets.only(top: 5.0, left: 20, right: 20),
      //       child: Text(
      //         widget.shop.name,
      //         style: TextStyle(
      //           fontSize: 24,
      //           fontWeight: FontWeight.bold,
      //           fontFamily: 'Roboto',
      //           color: DEFAULT_BLUE_DARK,
      //         ),
      //       ),
      //     ),
      //     Spacer(),
      //     Padding(
      //       padding: const EdgeInsets.only(top: 14, right: 15.0),
      //       child: IconButton(
      //           icon: Icon(
      //             Icons.contact_support,
      //             size: 35,
      //             color: DEFAULT_BLUE,
      //           ),
      //           onPressed: () {
      //             final String url = "https://youtu.be/Wbk83HfsJ4w";
      //             final String title = "use_showcase".tr;
      //             HelpButton.setBox(ButtonKey.dashKey);
      //             Navigator.of(context)
      //                 .push(TutorialOverlay(url, title));
      //           }),
      //     )
      //   ],
      // ),
      // Padding(
      //   padding: const EdgeInsets.only(top: 0.0, left: 20, right: 20),
      //   child: Text(
      //     _timeString,
      //     style: TextStyle(
      //       fontFamily: 'Roboto',
      //       fontSize: 13,
      //       fontWeight: FontWeight.normal,
      //       color: DEFAULT_BLUE,
      //     ),
      //   ),
      // ),
      // showCaseTap == true
      //     ? OpacityAnimatedWidget.tween(
      //       opacityEnabled: 1, //define start value
      //       opacityDisabled: 0, //and end value
      //       enabled: showCase,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: [
      //           Container(
      //             decoration: BoxDecoration(
      //               color: DEFAULT_BLACK,
      //               borderRadius: BorderRadius.circular(4),
      //             ),
      //             child: Row(
      //               children: [
      //                 Container(
      //                   height: 40,
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Text(
      //                     "use_showcase".tr,
      //                     style: TextStyle(
      //                         color: Colors.white, fontSize: 16),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           Container(
      //             child: Icon(
      //               Icons.play_arrow_sharp,
      //               size: 30,
      //               color: DEFAULT_BLACK,
      //             ),
      //           ),
      //         ],
      //       ),
      //     )
      //     : Container(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6)
            ),
            // margin: EdgeInsets.only(left: 15, right: 15),
            child: Card(
              elevation: 6.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight:Radius.circular(6)),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Text(
                              'today_s_sale'.tr,
                              style: TextStyle(
                                fontFamily: 'Roboto',
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
                                  "".tr,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: DEFAULT_BLUE,
                                  ),
                                ),
                                Obx(
                                      () => Text(
                                    '৳${display(Get.find<ShopFeaturesController>().todaysSale.value)}',
                                    style: TextStyle(
                                      fontFamily:
                                      'Roboto',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: DEFAULT_BLUE,
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6), bottomRight:Radius.circular(6)),
                      color: Colors.amber[50],
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () {
                              Get.to(
                                    () => ExpenseList(

                                ),
                                arguments:

                                widget.shop,

                              );
                            },
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'todays_expense'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: DEFAULT_BLACK,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    '৳${ExpenseController().totalFixedExpense.value}',
                                    style: TextStyle(
                                      fontFamily:
                                      'Roboto',
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
                                  'todays_due'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: DEFAULT_BLACK,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    '৳${widget.shop.walletBalance}',
                                    style: TextStyle(
                                      fontFamily:
                                      'Roboto',
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
                                  'digital_balance'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: DEFAULT_BLACK,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    '৳${widget.shop.walletBalance}',
                                    style: TextStyle(
                                      fontFamily:
                                      'Roboto',
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
