import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        child:
          Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25, top: 20),
          child: Container(
            child: controller.obx(
              (state) => StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: state.length,
                  // mainAxisSpacing: 5,
                  // crossAxisSpacing: 5,
                  itemBuilder: (context, index) {
                    var name = state[index].name;
                    var firstLetterOfName = name.substring(0, 1);
                    return Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5, top: 10),
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            color: DEFAULT_BLUE
                                .withOpacity(0.06),
                            borderRadius:
                            BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // height: screen.context.height * 0.19,
                                  // width: screen.context.width * 0.34,

                                  child: state[index].logoUrl == null ||
                                          state[index].logoUrl == "null"
                                      ? Center(
                                          child: Container(

                                              child: Image.asset('images/bee.png'), height: 60,),
                                        )
                                      : Center(
                                          child: CachedNetworkImage(
                                              imageUrl: state[index].logoUrl,
                                            height: 60,
                                          ),
                                  )
                                  // ClipRRect(
                                  //         borderRadius:
                                  //             BorderRadius.circular(4),
                                  //         child: Card(
                                  //           child: CachedNetworkImage(
                                  //             imageUrl:
                                  //                 state[index].logoUrl,
                                  //             fit: BoxFit.fill,
                                  //             placeholder: (context,
                                  //                     url) =>
                                  //                 Center(
                                  //                     child:
                                  //                         CircularProgressIndicator(
                                  //               backgroundColor:
                                  //                   Colors.amber[400],
                                  //             )),
                                  //             errorWidget:
                                  //                 (context, url, error) =>
                                  //                     Icon(
                                  //               Icons.error,
                                  //               color: Colors.red,
                                  //             ),
                                  //           ),
                                  //         ), /*Image.network(
                                  //           state[index].logoUrl,
                                  //           fit: BoxFit.cover,
                                  //         ),*/
                                  //       ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                state[index].name,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: DEFAULT_BLACK,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                state[index].address,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: DEFAULT_BLACK.withOpacity(.5),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 10,),
                              GestureDetector(
                                onTap: () async {
                                  await controller.setCurrentShop(state[index]);

                                  Get.to(() => ShopFeatureShowCase(shop: state[index]),
                                      binding: ShopFeaturesBinding());
                                },
                                child: Container(
                                  width: screen.width,
                                  decoration: BoxDecoration(
                                    color: DEFAULT_BLUE,
                                    borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5.0),
                                    child: Text('select'.tr, textAlign: TextAlign.center, style: TextStyle(
                                      color: Colors.white,
                                    ),),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
            ),
          ),
        ),
      ),
    );
  }
}
