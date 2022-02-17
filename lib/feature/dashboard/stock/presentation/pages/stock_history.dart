import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

class StockHistory extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('stock_history'.tr),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        titleSpacing: 0,

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
        child: Column(
          children: [
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
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                          hintText: 'search_product_with_name_or_category'.tr,
                          hintStyle:
                          TextStyle(fontSize: 12, fontFamily: 'Roboto')),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('stock_wise_product'.tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400
                                  ),),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Expanded(child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFFC4C4C4).withOpacity(.35),
                                          borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: 1,
                                            groupValue: 1,
                                            activeColor: DEFAULT_BLUE,
                                            onChanged: (value){

                                            },

                                          ),
                                          Text('new_product'.tr,style: TextStyle(
                                              fontSize: 12, fontFamily: 'Roboto'
                                          ),),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                            child: Icon(Icons.arrow_forward),
                                          ),
                                          Text('old_product'.tr,style: TextStyle(
                                              fontSize: 12, fontFamily: 'Roboto'
                                          ),),
                                        ],
                                      ),
                                    ),),
                                    SizedBox(width: 10,),
                                    Expanded(child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFFC4C4C4).withOpacity(.35),
                                          borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: 2,
                                            groupValue: 2,
                                            activeColor: DEFAULT_BLUE,
                                            // onChanged: (value){
                                            //
                                            // },
                                          ),
                                          Text('old_product'.tr,style: TextStyle(
                                              fontSize: 12, fontFamily: 'Roboto'
                                          ),),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                            child: Icon(Icons.arrow_forward),
                                          ),
                                          Text('new_product'.tr,style: TextStyle(
                                              fontSize: 12, fontFamily: 'Roboto'
                                          ),),
                                        ],
                                      ),
                                    ),),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Text('stock_wise_product_count'.tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400
                                  ),),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Expanded(child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFFC4C4C4).withOpacity(.35),
                                          borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: 1,
                                            groupValue: 1,
                                            activeColor: DEFAULT_BLUE,
                                            onChanged: (value){

                                            },

                                          ),
                                          Text('few_product'.tr,style: TextStyle(
                                              fontSize: 12, fontFamily: 'Roboto'
                                          ),),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                            child: Icon(Icons.arrow_forward),
                                          ),
                                          Text('many_products'.tr,style: TextStyle(
                                              fontSize: 12, fontFamily: 'Roboto'
                                          ),),
                                        ],
                                      ),
                                    ),),
                                    SizedBox(width: 10,),
                                    Expanded(child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFFC4C4C4).withOpacity(.35),
                                          borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: 2,
                                            groupValue: 2,
                                            activeColor: DEFAULT_BLUE,
                                            // onChanged: (value){
                                            //
                                            // },
                                          ),
                                          Text('many_products'.tr,style: TextStyle(
                                              fontSize: 12, fontFamily: 'Roboto'
                                          ),),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                            child: Icon(Icons.arrow_forward),
                                          ),
                                          Text('few_product'.tr,style: TextStyle(
                                              fontSize: 12, fontFamily: 'Roboto'
                                          ),),
                                        ],
                                      ),
                                    ),),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Text('price_wise_product'.tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400
                                  ),),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Expanded(child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFFC4C4C4).withOpacity(.35),
                                          borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: 1,
                                            groupValue: 1,
                                            activeColor: DEFAULT_BLUE,
                                            onChanged: (value){

                                            },

                                          ),
                                          Text('min_price'.tr,style: TextStyle(
                                              fontSize: 12, fontFamily: 'Roboto'
                                          ),),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                            child: Icon(Icons.arrow_forward),
                                          ),
                                          Text('max_price'.tr,style: TextStyle(
                                              fontSize: 12, fontFamily: 'Roboto'
                                          ),),
                                        ],
                                      ),
                                    ),),
                                    SizedBox(width: 10,),
                                    Expanded(child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFFC4C4C4).withOpacity(.35),
                                          borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: 2,
                                            groupValue: 2,
                                            activeColor: DEFAULT_BLUE,
                                            // onChanged: (value){
                                            //
                                            // },
                                          ),
                                          Text('max_price'.tr,style: TextStyle(
                                              fontSize: 12, fontFamily: 'Roboto'
                                          ),),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                            child: Icon(Icons.arrow_forward),
                                          ),
                                          Text('min_price'.tr,style: TextStyle(
                                              fontSize: 12, fontFamily: 'Roboto'
                                          ),),
                                        ],
                                      ),
                                    ),),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: SvgPicture.asset('images/svg_image/filter.svg'),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: SvgPicture.asset('images/svg_image/empty-image.svg'),
                        title: Text('Gents Pant', style: TextStyle(
                          fontSize: 14,fontFamily: 'Roboto'
                        ),),
                        subtitle: Text('২০ অক্টোবর ২০২১ ,  সকাল ১২:১০'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('stock_price'.tr, style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Roboto',
                                  color: Color(0xFF707070)
                                ),),
                                Text('৳ 500', style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF232323)
                                ),)
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('previous_stock'.tr, style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF707070)
                                ),),
                                Text('500', style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF232323)
                                ),)
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('increase_stock'.tr, style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF707070)
                                ),),
                                Text('+500', style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF669E4F)
                                ),)
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('present_stock'.tr, style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF707070)
                                ),),
                                Text('500', style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF232323)
                                ),)
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
