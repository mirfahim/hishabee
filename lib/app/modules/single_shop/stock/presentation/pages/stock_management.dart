import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

class StockManagement extends GetView {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: (){

                },
                child: Text('update_stock'.tr, style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    color: DEFAULT_BLUE
                ),),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: BorderSide(width: 1.0, color: DEFAULT_BLUE,),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    )

                ),
              ),
            ),
            SizedBox(width: 10,),
            Expanded(child: ElevatedButton(
                onPressed: (){

                },
                child: Text('add_new_product'.tr, style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    color: Colors.white
                ),),
                style: ElevatedButton.styleFrom(
                  primary: DEFAULT_BLUE,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),),
                )))
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('stock'.tr),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        titleSpacing: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8, right: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1.5, color:DEFAULT_BLUE)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('images/svg_image/appBar_clock.svg'),
                    SizedBox(width: 5,),
                    Text('stock_history'.tr,style: TextStyle(
                      fontSize: 12,
                      color: DEFAULT_BLUE,
                      fontFamily: 'Roboto'
                    ),)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: DEFAULT_BLUE,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('total_stock'.tr,style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: Color(0xFFFECD1A)
                    ),),
                    SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){},
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(Icons.arrow_back_ios_outlined, color: Colors.white,size: 11,),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('21th February,2022',style: TextStyle(
                            color: Color(0xFFDFE0EB),
                            fontSize: 13, fontFamily: 'Roboto'
                          ),),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(Icons.arrow_forward_ios_sharp, color: Colors.white,size: 11,),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFC4C4C4).withOpacity(.35),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('700', style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        color: Colors.white
                                    ),),
                                    Text('total_product'.tr,textAlign: TextAlign.center, style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        color: Colors.white
                                    ),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFC4C4C4).withOpacity(.35),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('700', style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        color: Colors.white
                                    ),),
                                    Text('total_stocked_product'.tr,textAlign: TextAlign.center, style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        color: Colors.white
                                    ),)
                                  ],
                                ),
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
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Color(0xFFC4C4C4).withOpacity(.35),
                            width: 1.5),
                        borderRadius: BorderRadius.all(
                            Radius.circular(6.0))),
                    child: TextField(
                      onChanged: (value) {

                      },
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                        hintText: 'search_product_with_name_or_category'.tr,
                        hintStyle: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Roboto'
                        )
                      ),
                    ),
                  ),
                ),
                Expanded(child: SvgPicture.asset('images/svg_image/filter.svg'))
              ],
            ),
            ListTile(
              leading: SvgPicture.asset('images/svg_image/empty-image.svg'),
              title: Text('T-Shirt',style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500
              ),),
              subtitle: Text('stock_count'.tr, style: TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto'
              ),),
              trailing: Text('৳ 100', style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto'
              ),),
            ),
            Divider(thickness: 2, color: Color(0xFFC4C4C4).withOpacity(.35),),


          ],
        ),
      ),
    );
  }
}
