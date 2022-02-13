import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
class UpdateProduct extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('update_product'.tr),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        titleSpacing: 0,

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    // width: MediaQuery.of(context).size.width /
                    //     1.1,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Color(0xFF185ADB),
                            width: 1.5),
                        borderRadius: BorderRadius.all(
                            Radius.circular(6.0))),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 3.0),
                            child: TextFormField(
                              onChanged: (value) {
                                // controller.searchProduct(value);
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Search For Product",
                                icon: SvgPicture.asset(
                                    'images/svg_image/search.svg'),
                                hintStyle: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'Roboto'),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0),
                            child: Container(
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 30,
                                          child: VerticalDivider(
                                              thickness: 2,
                                              color:
                                              Color(0xFF185ADB),
                                              indent: 0,
                                              endIndent: 0)),
                                      InkWell(
                                        onTap: () {
                                          // _showCategoryDialog(
                                          //     controller
                                          //         .productCategoryList,
                                          //     size,
                                          //     context);
                                        },
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              right: 5.0,
                                              left: 5),
                                          child: SvgPicture.asset(
                                              'images/svg_image/filter.svg'),
                                        ),
                                      ),
                                      Text(
                                        'filter'.tr,
                                        style: TextStyle(
                                            fontFamily: 'Roboto'),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: IconButton(
                        icon: SvgPicture.asset(
                            'images/svg_image/scanner.svg'),
                        onPressed: () async {
                          // await controller.scanProduct();
                        },
                        color: Color(0xFF185ADB)))
              ],
            ),
            SizedBox(height: 10,),
            ListTile(
              leading: SvgPicture.asset('images/svg_image/empty-image.svg'),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gents Pant', style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF232323),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500
                  ),),
                  Text('Gents Pant', style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF707070),
                      fontFamily: 'Roboto'
                  ),),
                  Row(
                    children: [
                      Text('stock_count'.tr, style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF232323),
                          fontFamily: 'Roboto'
                      ),),
                      Text(':700', style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF185ADB),
                          fontFamily: 'Roboto'
                      ),)
                    ],
                  ),
                ],
              ),
              trailing: SizedBox(
                height: 70,
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                            shape: BoxShape.circle,
                          border: Border.all(color: Color(0xFFC4C4C4).withOpacity(.35), width: 1.5)
                        ),
                        child: Icon(Icons.remove, color: Color(0xFF979797) ,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFF1F1F1), width: 1)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                          child: Text('100', style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto'
                          ),),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                          color: DEFAULT_BLUE,
                            shape: BoxShape.circle,
                            // border: Border.all(color: Color(0xFFC4C4C4).withOpacity(.35), width: 1.5)
                        ),
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
