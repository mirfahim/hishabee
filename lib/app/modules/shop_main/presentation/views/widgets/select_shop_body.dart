import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/manager/select_shop_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/_binding/shop_features_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/pages/shop_features_page.dart';

class SelectShopBody extends GetResponsiveView<SelectShopController> {
  SelectShopBody({
    @required this.screen,
  });

  final ResponsiveScreen screen;

  @override
  Widget builder() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: DEFAULT_BODY_BG_COLOR,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              30,
            ),
            topRight: Radius.circular(
              30,
            ),
          ),
        ),
        height: screen.context.height,
        width: screen.context.width,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            top: 20,
            right: 30,
          ),
          child: Container(
            height: screen.context.height - 0.3,
            child: MediaQuery.removePadding(
              context: screen.context,
              removeTop: true,
              child: controller.obx(
                (state) => StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: state.length,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    itemBuilder: (context, index) {
                      var name = state[index].name;
                      var fisrtLetterOfName = name.substring(0, 1);
                      return GestureDetector(
                        onTap: () async {
                          await controller.setCurrentShop(state[index]);

                          Get.to(() => ShopFeatureShowCase(shop: state[index]),
                              binding: ShopFeaturesBinding());
                        },
                        child: Column(
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0, right: 0, top: 0),
                                child: Container(
                                  height: screen.context.height * 0.2,
                                  width: screen.context.width * 0.37,
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: screen.context.height * 0.19,
                                        width: screen.context.width * 0.34,
                                        decoration: BoxDecoration(
                                          color: DEFAULT_YELLOW_BG
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: state[index].logoUrl == null ||
                                                state[index].logoUrl == "null"
                                            ? Center(
                                                child: Text(
                                                  "${fisrtLetterOfName.toUpperCase()}",
                                                  style: TextStyle(
                                                      fontSize: 70,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLUE),
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Card(
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        state[index].logoUrl,
                                                    fit: BoxFit.fill,
                                                    placeholder: (context,
                                                            url) =>
                                                        Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                      backgroundColor:
                                                          Colors.amber[400],
                                                    )),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(
                                                      Icons.error,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ), /*Image.network(
                                                  state[index].logoUrl,
                                                  fit: BoxFit.cover,
                                                ),*/
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              state[index].name,
                              style: TextStyle(
                                color: DEFAULT_BLACK,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
