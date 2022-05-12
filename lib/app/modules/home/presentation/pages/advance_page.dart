import 'dart:async';

import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/help_button_box.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/overlay_youtube_video.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/_navigation/settings_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/_binding/shop_features_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/pages/digital_balance_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/widgets/advance_items_list.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/_bindings/transactions_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/pages/transactions_page.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/expense/expense_front.dart';
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
        body: Column(
          children: [
            AdvanceItemsList(shop: widget.shop),
          ],
        ),
      ),
    );
  }

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
