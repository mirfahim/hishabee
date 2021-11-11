import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/overlay_youtube_video.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/store_dashboard_controller.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:share_plus/share_plus.dart';

class StoreHeader extends GetView<OnlineStoreDashboardController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    color: DEFAULT_BLACK,
                    size: 25,
                  ),
                  onPressed: () {
                    navigator.pop();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Obx(
                  () => Text(
                    "${controller.onlineShopInfoResponse.value.shop.name}",
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 18,
                      color: DEFAULT_BLACK,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: IconButton(
                    icon: Icon(
                      Icons.contact_support,
                      size: 35,
                      color: DEFAULT_BLUE,
                    ),
                    onPressed: () {
                      final String url = "https://youtu.be/Wbk83HfsJ4w";
                      final String title = "use_showcase".tr;
                      Navigator.of(context).push(TutorialOverlay(url, title));
                    }),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: InkWell(
                  onTap: () {
                    String url =
                        "http://hishabee.market/shop/${controller.onlineShopInfoResponse.value.shop.slug}";
                    Utility.launchURL(url);
                  },
                  child: Container(
                    height: 40,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.transparent,
                        border: Border.all(color: DEFAULT_BLACK, width: 1.5)),
                    child: Center(
                      child: Text(
                        "Visit Site",
                        style: TextStyle(
                          fontSize: 14,
                          color: DEFAULT_BLACK,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: InkWell(
                  onTap: () {
                    String shopUrl =
                        "http://hishabee.market/shop/${controller.onlineShopInfoResponse.value.shop.slug}";
                    Share.share('Check out our website $shopUrl');
                  },
                  child: Container(
                    height: 40,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: DEFAULT_BLACK,
                        border: Border.all(color: DEFAULT_BLACK, width: 1.5)),
                    child: Center(
                      child: Text(
                        "Share Link",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
