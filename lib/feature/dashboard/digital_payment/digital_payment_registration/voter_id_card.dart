import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

class VoterIdCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            // Get.back();
          },
          child: Container(
            height: 40,
            width: width,
            decoration: BoxDecoration(
                color: DEFAULT_BLUE, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'proceed'.tr,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'voter_id_card'.tr,
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10, top: 10, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'add_your_picture'.tr,
                  style: TextStyle(
                      color: Color(0xFF232323), fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: SvgPicture.asset(
                        'images/svg_image/digital_payment/upload_image.svg')),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'add_voter_id_card_picture'.tr,
                  style: TextStyle(
                      color: Color(0xFF232323), fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Color(0xFFF1F1F1),
                  width: width,
                  child: DottedBorder(
                    radius: Radius.circular(6),
                    borderType: BorderType.RRect,
                    dashPattern: [8, 4],
                    strokeWidth: 2,
                    color: Color(0xFF185ADB),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('front_picture'.tr),
                            SvgPicture.asset('images/svg_image/digital_payment/add_image.svg')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Color(0xFFF1F1F1),
                  width: width,
                  child: DottedBorder(
                    radius: Radius.circular(6),
                    borderType: BorderType.RRect,
                    dashPattern: [8, 4],
                    strokeWidth: 2,
                    color: Color(0xFF185ADB),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('back_picture'.tr),
                            SvgPicture.asset('images/svg_image/digital_payment/add_image.svg')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
