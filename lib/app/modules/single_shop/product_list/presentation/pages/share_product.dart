import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../shop_main/data/remote/models/get_all_shop_response_model.dart';
import '../../../contacts/data/remote/models/customer_model.dart';
import '../../../online_shop/presentation/manager/store_dashboard_controller.dart';
class ShareProduct extends  StatelessWidget{

  final slag;
  final shopName;
  const ShareProduct({Key key, this.slag, this.shopName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 50),
              child: Align(alignment:Alignment.center,child: Text('share_product_link'.tr,style: TextStyle(
                fontSize: 20, fontFamily: 'Roboto'
              ),)),
            ),
            Card(
              elevation: 2,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.grey.withOpacity(.2)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("http://hishabee.market/$shopName/product/$slag", textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 16, fontFamily: 'Roboto'
                  ),),
                ),
              ),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        String url =
                            "https://dev.hishabee.market/$shopName/product/$slag";
                        Utility.launchURL(url);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(.35)),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('images/svg_image/visit.svg'),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20, bottom: 20),
                              child: Text('visit'.tr, style: TextStyle(fontSize: 16, fontFamily: 'Roboto',color: DEFAULT_BLUE),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Clipboard.setData(ClipboardData(text: "https://dev.hishabee.market/$shopName/product/$slag"));
                        var snackBar = SnackBar(content: Text('Copied to clipboard '), duration: Duration(milliseconds: 200),);

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.withOpacity(.35)),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('images/svg_image/copy.svg', height: 20,),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20, bottom: 20),
                                child: Align(child: Text('copy_url'.tr, style: TextStyle(fontSize: 16, fontFamily: 'Roboto',color: DEFAULT_BLUE),)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Divider(thickness: 1, color: Colors.grey.withOpacity(.8),indent: 5,endIndent: 5,),
            Padding(padding: EdgeInsets.only(top: 10, bottom: 10),child: Align(alignment:Alignment.center,child: Text('share_link'.tr,style: TextStyle(
                fontSize: 20, fontFamily: 'Roboto'
            ),)),),
            Padding(padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          String shopUrl =
                              "https://dev.hishabee.market/$shopName/product/$slag";
                          Share.share('Check out our website $shopUrl');
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset('images/svg_image/sms.svg', height: 50,),
                            SizedBox(height: 10,),
                            Text('sms'.tr, style: TextStyle(fontFamily: 'Roboto', fontSize: 16),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          String shopUrl =
                              "https://dev.hishabee.market/$shopName/product/$slag";
                          Share.share('Check out our website $shopUrl');
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset('images/svg_image/whatsapp.svg',height: 50,),
                            SizedBox(height: 10,),
                            Text('whatsapp'.tr, style: TextStyle(fontFamily: 'Roboto', fontSize: 16),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          String shopUrl =
                              "https://dev.hishabee.market/$shopName/product/$slag";
                          Share.share('Check out our website $shopUrl');
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset('images/svg_image/messenger.svg',height: 50,),
                            SizedBox(height: 10,),
                            Text('messenger'.tr, style: TextStyle(fontFamily: 'Roboto', fontSize: 16),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [

                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          String shopUrl =
                              "https://dev.hishabee.market/$shopName/product/$slag";
                          Share.share('Check out our website $shopUrl');
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset('images/svg_image/gmail.svg',height: 50,),
                            SizedBox(height: 10,),
                            Text('email'.tr, style: TextStyle(fontFamily: 'Roboto', fontSize: 16),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(

                      child: GestureDetector(
                        onTap: (){
                          String shopUrl =
                              "https://dev.hishabee.market/$shopName/product/$slag";
                          Share.share('Check out our website $shopUrl');
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset('images/svg_image/scanner.svg',height: 50,),
                            SizedBox(height: 10,),
                            Text('scanner'.tr, style: TextStyle(fontFamily: 'Roboto', fontSize: 16),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(

                      child: GestureDetector(
                        onTap: (){
                          String shopUrl =
                              "https://dev.hishabee.market/$shopName/product/$slag";
                          Share.share('Check out our website $shopUrl');
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset('images/svg_image/others.svg',height: 50,),
                            SizedBox(height: 10,),
                            Text('others'.tr, style: TextStyle(fontFamily: 'Roboto', fontSize: 16),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                  ],
                ),
              ],
            ),
            ),
            SizedBox(height: 10,),
            Divider(thickness: 1, color: Colors.grey.withOpacity(.8),indent: 5,endIndent: 5,),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                Get.back();
              },
              child: Text('Done', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Roboto'),),
              style: ElevatedButton.styleFrom(
                primary: DEFAULT_BLUE,
                fixedSize: Size(MediaQuery.of(context).size.width,40 )
              ),
            )
          ],
        ),
      ),
    );
  }
}
