import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

class TransactionDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              'transaction_details'.tr,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(6)
                ),
                child: ListTile(
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('৳ 120', style: TextStyle(
                          fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w500
                      ),),
                    ],
                  ),

                  title: Text('Samin', textAlign: TextAlign.start, style: TextStyle(
                      fontSize: 16, fontFamily: 'Roboto'
                  ),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('payment_method'.tr, style: TextStyle(
                          fontSize: 14, fontFamily: 'Roboto'
                      ),),
                      Text('15th January, 2022', style: TextStyle(
                          fontSize: 14, fontFamily: 'Roboto'
                      ),)
                    ],
                  ),
                )
              ),
              SizedBox(height: 20,),
              Text('customer_name'.tr, style: TextStyle(
                fontSize: 14, fontFamily: 'Roboto',
              ),),
              SizedBox(height: 10,),
              TextFormField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp('[a-zA-Z0-9]'),
                  ),
                ],
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(onTap:(){},child: SvgPicture.asset('images/svg_image/contacts_transaction.svg')),
                  ),
                  suffixIconConstraints: BoxConstraints(
                    maxWidth: 32,maxHeight: 32
                  ),
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
                  hintText: 'এস এম আলীউজ্জামান'.tr,
                  hintStyle: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12,
                    color: Color(0xFf707070),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('product_list'.tr, style: TextStyle(
                        fontSize: 14, fontFamily: 'Roboto'
                      ),),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Expanded(flex: 1,child: SvgPicture.asset('images/svg_image/empty-image.svg')),
                            Expanded(
                              flex: 1,
                              child: Text('T-shirt', style: TextStyle(
                                fontSize: 14, fontFamily: 'Roboto'
                              ),),
                            ),
                            Expanded(
                              flex: 2,
                                child: Container(),
                            ),
                            Expanded(
                              flex: 1,
                                child: Text('X 1', style: TextStyle(
                                fontSize: 14, fontFamily: 'Roboto'
                            ),)),
                            Expanded(
                                flex: 1,
                                child: Text('৳100', textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 14, fontFamily: 'Roboto'
                                ),))
                          ],
                        ),
                      ),
                      Divider(thickness: 2,color: Color(0xFFC4C4C4).withOpacity(.35),),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Expanded(flex: 1,child: SvgPicture.asset('images/svg_image/empty-image.svg')),
                            Expanded(
                              flex: 1,
                              child: Text('T-shirt', style: TextStyle(
                                  fontSize: 14, fontFamily: 'Roboto'
                              ),),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(),
                            ),
                            Expanded(
                                flex: 1,
                                child: Text('X 1', style: TextStyle(
                                    fontSize: 14, fontFamily: 'Roboto'
                                ),)),
                            Expanded(
                                flex: 1,
                                child: Text('৳100', textAlign: TextAlign.center, style: TextStyle(
                                    fontSize: 14, fontFamily: 'Roboto'
                                ),))
                          ],
                        ),
                      ),
                      Divider(thickness: 2,color: Color(0xFFC4C4C4).withOpacity(.35),),
                      SizedBox(height: 10,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: DEFAULT_BLUE, fixedSize: Size(MediaQuery.of(context).size.width, 40)),
                          onPressed: (){},
                          child: Text('edit_product_details'.tr, style: TextStyle(
                            fontSize: 16, fontFamily: 'Roboto', color: Colors.white
                          ),)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('total'.tr, style: TextStyle(
                    fontSize: 16, fontFamily: 'Roboto',color: Color(0xFF707070)
                  ),),
                  Text('৳100'.tr, style: TextStyle(
                      fontSize: 16, fontFamily: 'Roboto',color: Colors.black
                  ),)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('discount(%)'.tr, style: TextStyle(
                      fontSize: 16, fontFamily: 'Roboto',color: Color(0xFF707070)
                  ),),
                  SizedBox(height: 10,),
                  Text('৳100'.tr, style: TextStyle(
                      fontSize: 16, fontFamily: 'Roboto',color: Colors.black
                  ),)
                ],
              ),
              SizedBox(height: 10,),
              Divider(thickness: 2,color: Color(0xFFC4C4C4).withOpacity(.35),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('grand_total'.tr, style: TextStyle(
                      fontSize: 16, fontFamily: 'Roboto',color: Colors.black
                  ),),
                  Text('৳100'.tr, style: TextStyle(
                      fontSize: 16, fontFamily: 'Roboto',color: Colors.black
                  ),)
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('total_got'.tr, style: TextStyle(
                      fontSize: 16, fontFamily: 'Roboto',color: Colors.black
                  ),),
                  Text('৳100'.tr, style: TextStyle(
                      fontSize: 16, fontFamily: 'Roboto',color: Colors.black
                  ),)
                ],
              ),

              SizedBox(height: 10,),
              Divider(thickness: 2,color: Color(0xFFC4C4C4).withOpacity(.35),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('total_due'.tr, style: TextStyle(
                      fontSize: 16, fontFamily: 'Roboto',color: Colors.black
                  ),),
                  Text('৳100'.tr, style: TextStyle(
                      fontSize: 16, fontFamily: 'Roboto',color: Colors.black
                  ),)
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F1F1)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset('images/svg_image/add_receipt.svg'),
                          SizedBox(width: 5,),
                          Text('add_receipt'.tr, style: TextStyle(
                            fontSize: 12, fontFamily: 'Roboto'
                          ),)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFF1F1F1)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset('images/svg_image/receipt_share.svg'),
                          SizedBox(width: 5,),
                          Text('share_receipt'.tr, style: TextStyle(
                              fontSize: 12, fontFamily: 'Roboto'
                          ),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              TextFormField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp('[a-zA-Z0-9]'),
                  ),
                ],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xFFC4C4C4),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(
                      color: Color(0xFFC4C4C4).withOpacity(.35),
                      width: 1.5,
                    ),
                  ),
                  counterText: "",
                  hintText: 'comment'.tr,
                  hintStyle: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    color: Color(0xFF232323),
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
