import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

class ImportantPapers extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'important_papers'.tr,
        ),
        titleSpacing: 0,
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: (){
            // Get.back();
          },
          child: Container(
            height: 40,
            width: width,
            decoration: BoxDecoration(
                color: DEFAULT_BLUE,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text('proceed'.tr, style: TextStyle(
                    fontSize: 16, color: Colors.white
                ),),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('recent_trade_licence'.tr, style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600
                        ),),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F1F1),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.file_upload, color: DEFAULT_BLUE,),
                                Text('upload'.tr, style: TextStyle(
                                  color: DEFAULT_BLUE, fontSize: 12
                                ),)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('tin_certificate'.tr, style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600
                        ),),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.file_upload, color: DEFAULT_BLUE,),
                                Text('upload'.tr, style: TextStyle(
                                    color: DEFAULT_BLUE, fontSize: 12
                                ),)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('website_logo'.tr, style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600
                        ),),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.file_upload, color: DEFAULT_BLUE,),
                                Text('upload'.tr, style: TextStyle(
                                    color: DEFAULT_BLUE, fontSize: 12
                                ),)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('association_memorandum'.tr, style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600
                            ),),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFF1F1F1),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.file_upload, color: DEFAULT_BLUE,),
                                    Text('upload'.tr, style: TextStyle(
                                        color: DEFAULT_BLUE, fontSize: 12
                                    ),)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SvgPicture.asset('images/svg_image/empty-image.svg')
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
