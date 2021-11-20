import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';

class NotificationPage extends GetResponsiveView<ShopFeaturesController> {
  final Shop shop;

  NotificationPage({this.shop});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: size.height * 0.2,
              width: size.width,
              child: Image.asset(
                "images/topBg.png",
                fit: BoxFit.fill,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                        const Padding(
                          padding: EdgeInsets.only(top: 5.0, left: 20, right: 20),
                          child: Text(
                            'Notification',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rubik-VariableFont_wght',
                              color: DEFAULT_BLUE_DARK,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Clear All',
                          style: TextStyle(color: Colors.red),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                      ),
                    )
                  ],
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 17.0, right: 10, top: 10),
                      child: Text(
                        shop.name,
                        style: TextStyle(color: DEFAULT_BLUE, fontSize: 18),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
