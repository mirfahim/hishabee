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
        height: screen.height,
        width: screen.width,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            top: 20,
            right: 30,
          ),
          child: Container(
            height: screen.context.height - 0.3,
            child: Obx(
              () => MediaQuery.removePadding(
                context: screen.context,
                removeTop: true,
                child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: controller.shops.length,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    itemBuilder: (context, index) {
                      var name = controller.shops[index].name;
                      var fisrtLetterOfName = name.substring(0, 1);
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          height: screen.height * 0.22,
                          width: screen.width * 0.3,
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Container(
                                height: screen.height * 0.17,
                                width: screen.width * 0.3,
                                decoration: BoxDecoration(
                                  color: DEFAULT_YELLOW_BG.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Stack(
                                  children: [
                                    controller.shops[index].logoUrl == null ||
                                            controller.shops[index].logoUrl ==
                                                "null"
                                        ? Center(
                                            child: Text(
                                              "${fisrtLetterOfName.toUpperCase()}",
                                              style: TextStyle(
                                                  fontSize: 70,
                                                  fontWeight: FontWeight.bold,
                                                  color: DEFAULT_BLUE),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: CachedNetworkImage(
                                              imageUrl: controller
                                                  .shops[index].logoUrl,
                                              fit: BoxFit.fill,
                                              placeholder: (context, url) =>
                                                  Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                backgroundColor:
                                                    Colors.amber[400],
                                              )),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Center(
                                                          child: Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              )),
                                            ),
                                          ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
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
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  color: DEFAULT_BLUE,
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                CustomDialog
                                                    .deleteAlertDialog();
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                controller.shops[index].name,
                                style: TextStyle(
                                  color: DEFAULT_BLACK,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
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
