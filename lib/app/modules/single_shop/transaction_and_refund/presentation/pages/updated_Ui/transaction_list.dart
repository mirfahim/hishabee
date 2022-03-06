import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/presentation/pages/updated_Ui/transaction_details.dart';

class TransactionList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    int flag = 1;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        titleSpacing: 0,
        title: Column(
          children: [
            Text(
              'transaction'.tr,
              style: TextStyle(color: Colors.black,fontFamily: 'Roboto'),
            ),
            // Text(
            //   'তুসার টেলিকম',
            //   style: TextStyle(color: Colors.black, fontSize: 12),
            // ),
          ],
        ),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        child: Column(
          children: [
            Container(
              width: width,
              decoration: BoxDecoration(
                  color: DEFAULT_BLUE, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'total_sell'.tr,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('৳8000000', style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 24, color: Colors.white
                    ),)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 9,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp('[a-zA-Z0-9]'),
                      ),
                    ],
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Color(0xFFC4C4C4),
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Color(0xFFC4C4C4),
                          width: 1.5,
                        ),
                      ),
                      counterText: "",
                      hintText: 'search'.tr,
                      hintStyle: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        color: Color(0xFf707070),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState){
                              return Container(
                                height: MediaQuery.of(context).copyWith().size.height * 0.75,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('filter'.tr, style: TextStyle(
                                            fontSize: 14, fontFamily: 'Roboto'
                                        ),),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'select_date_due'.tr,
                                        style: TextStyle(fontSize: 14,fontFamily: 'Roboto'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [

                                          InkWell(
                                            onTap:(){
                                              setState(() {
                                                flag = 1;
                                              });
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Color(0XFFC4C4C4)),
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: flag ==1 ? DEFAULT_BLUE : Colors.white),
                                              child: Center(
                                                child: Text(
                                                  'today'.tr,
                                                  style: TextStyle(fontFamily:'Roboto',fontSize: 14, color: flag ==1 ?  Colors.white: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                flag = 2;
                                              });
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Color(0XFFC4C4C4)),
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: flag == 2 ? DEFAULT_BLUE : Colors.white
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'গতকাল',
                                                  style: TextStyle(fontSize: 14, color: flag == 2 ?  Colors.white: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                flag = 3;
                                              });

                                            },
                                            child: Container(
                                              height: 40,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Color(0XFFC4C4C4)),
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: flag == 3 ? DEFAULT_BLUE : Colors.white
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'গত ৭ দিন',
                                                  style: TextStyle(fontSize: 14, color:flag == 3 ?  Colors.white: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap:(){
                                              setState((){
                                                flag = 4;
                                              });
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Color(0XFFC4C4C4)),
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: flag == 4 ? DEFAULT_BLUE: Colors.white
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'এই মাস',
                                                  style: TextStyle(fontSize: 14, color:flag == 4 ?  Colors.white: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Color(0XFFC4C4C4)),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'গত মাস',
                                                style: TextStyle(fontSize: 14, color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            height: 40,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Color(0XFFC4C4C4)),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'সময় সীমা',
                                                style: TextStyle(fontSize: 14, color: Colors.black),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('start_date'.tr, style: TextStyle(
                                                  fontSize: 12, fontFamily: 'Roboto'
                                                ),),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF1F1F1),
                                                    borderRadius: BorderRadius.circular(6)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset('images/svg_image/calender.svg'),
                                                        SizedBox(width: 5,),
                                                        Text('২৬-১১-২০২১', style: TextStyle(
                                                          fontFamily: 'Roboto',fontSize: 14
                                                        ),)
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('end_date'.tr, style: TextStyle(
                                                    fontSize: 12, fontFamily: 'Roboto'
                                                ),),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFF1F1F1),
                                                      borderRadius: BorderRadius.circular(6)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset('images/svg_image/calender.svg'),
                                                        SizedBox(width: 5,),
                                                        Text('২৬-১১-২০২১', style: TextStyle(
                                                            fontFamily: 'Roboto',fontSize: 14
                                                        ),)
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'select_sell_type'.tr,
                                        style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Radio(
                                            value: 'all_sell'.tr,
                                            groupValue: 'groupValue',
                                            onChanged: (value) {},
                                            activeColor: Colors.blue,
                                          ),
                                          Text('all_sell'.tr, style: TextStyle(fontFamily: 'Roboto', fontSize: 14),),
                                          Radio(
                                            value: 'supplier'.tr,
                                            groupValue: 'groupValue',
                                            onChanged: (value) {},
                                          ),
                                          Text('cash_sell'.tr, style: TextStyle(fontFamily: 'Roboto', fontSize: 14),),
                                          Radio(
                                            value: 'employee'.tr,
                                            groupValue: 'groupValue',
                                            onChanged: (value) {},
                                          ),
                                          Text('quick_sell'.tr, style: TextStyle(fontFamily: 'Roboto', fontSize: 14),),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Radio(
                                            value: 'due'.tr,
                                            groupValue: 'groupValue',
                                            onChanged: (value) {},
                                          ),
                                          Text('due'.tr, style: TextStyle(fontFamily: 'Roboto', fontSize: 14),),
                                          Radio(
                                            value: 'online'.tr,
                                            groupValue: 'groupValue',
                                            onChanged: (value) {},
                                          ),
                                          Text('online'.tr, style: TextStyle(fontFamily: 'Roboto', fontSize: 14),),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),

                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Center(
                                          child: Text(
                                            'confirm'.tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: 'Roboto'),
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: DEFAULT_BLUE,
                                          fixedSize: Size(width, 50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },

                          );
                        },
                      );
                    },
                    child: SvgPicture.asset('images/svg_image/filter.svg'),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: (){
                Get.to(TransactionDetails());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('#78932', style: TextStyle(
                            fontSize: 14, fontFamily: 'Roboto', color: Color(0xFF707070)
                          ),),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text('Samin', style: TextStyle(
                                fontSize: 14, fontFamily: 'Roboto', color: Color(0xFF232323)
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text('t-shirt', style: TextStyle(
                                fontSize: 12, fontFamily: 'Roboto', color: Color(0xFF707070)
                            ),),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('৳25000', style: TextStyle(
                              fontSize: 16, fontFamily: 'Roboto', color: Color(0xFF707070)
                          ),),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(3)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              child: Text('due'.tr, style: TextStyle(
                                  fontSize: 12, fontFamily: 'Roboto', color: Colors.white
                              ),),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Text('21th February, 2022', style: TextStyle(
                                fontSize: 12, fontFamily: 'Roboto', color: Color(0xFF707070)
                            ),),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: (){
                Get.to(TransactionDetails());
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(6)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('#78932', style: TextStyle(
                              fontSize: 14, fontFamily: 'Roboto', color: Color(0xFF707070)
                          ),),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text('Samin', style: TextStyle(
                                fontSize: 14, fontFamily: 'Roboto', color: Color(0xFF232323)
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text('t-shirt', style: TextStyle(
                                fontSize: 12, fontFamily: 'Roboto', color: Color(0xFF707070)
                            ),),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('৳25000', style: TextStyle(
                              fontSize: 16, fontFamily: 'Roboto', color: Color(0xFF707070)
                          ),),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(3)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              child: Text('due'.tr, style: TextStyle(
                                  fontSize: 12, fontFamily: 'Roboto', color: Colors.white
                              ),),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Text('21th February, 2022', style: TextStyle(
                                fontSize: 12, fontFamily: 'Roboto', color: Color(0xFF707070)
                            ),),
                          ),
                        ],
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
