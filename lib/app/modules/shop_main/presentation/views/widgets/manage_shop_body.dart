import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/_navigation/shop_main_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/manager/manage_shop_controller.dart';

class ManageShopBody extends GetResponsiveView<ManageShopController> {
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
        // height: screen.height,
        // width: screen.width,
        child: Obx(()=> controller.isLoading.value == true ? Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ) : Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25, top: 20),
            child: Container(
              // height: screen.context.height - 0.3,
              child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: controller.shops.length,
                  // mainAxisSpacing: 5,
                  // crossAxisSpacing: 5,
                  itemBuilder: (context, index) {
                    var name = controller.shops[index].name;
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
                                    child:
                                    controller.shops[index].logoUrl == null ||
                                        controller.shops[index].logoUrl ==
                                            "null"
                                        ? Center(
                                      child: Container(

                                        child: Image.asset('images/bee.png'), height: 60,),
                                    )
                                        : Center(
                                      child: CachedNetworkImage(
                                        imageUrl: controller
                                            .shops[index].logoUrl,
                                        height: 60,
                                      ),
                                    )
                                  // Center(
                                  //       child: CachedNetworkImage(
                                  //         imageUrl: controller
                                  //             .shops[index].logoUrl,
                                  //         // fit: BoxFit.fill,
                                  //         placeholder: (context, url) =>
                                  //             Center(
                                  //                 child:
                                  //                     CircularProgressIndicator(
                                  //           backgroundColor:
                                  //               Colors.amber[400],
                                  //         )),
                                  //         errorWidget:
                                  //             (context, url, error) =>
                                  //                 Center(
                                  //                     child: Icon(
                                  //           Icons.error,
                                  //           color: Colors.red,
                                  //         )),
                                  //       ),
                                  //     ),

                                ),
                              ),
                              Text(
                                controller.shops[index].name,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: DEFAULT_BLACK,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                controller.shops[index].address,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                  color: DEFAULT_BLACK.withOpacity(.5),
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              ShopMainRoutes.EDIT_SHOP,
                                              arguments: {
                                                'shop':
                                                controller.shops[index]
                                              },
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: DEFAULT_BLUE,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                                              child: Text('edit'.tr, textAlign: TextAlign.center, style: TextStyle(
                                                fontFamily: 'Roboto', color: Colors.white,

                                              ),),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            CustomDialog
                                                .deleteAlertDialog();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                                              child: Text('delete_delete'.tr,textAlign: TextAlign.center, style: TextStyle(
                                                fontFamily: 'Roboto', color: Colors.white,

                                              ),),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
            )),
        ),
      ),
    );
  }
}
