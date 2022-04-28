import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

class PersonalInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: (){

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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'personal_information'.tr,
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'person_name'.tr,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: 'person_name'.tr,
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)))),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'mobile_number'.tr,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'mobile_number'.tr,
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)))),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'email'.tr,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'email'.tr,
                    contentPadding: const EdgeInsets.all(15),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'birth_date'.tr,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.calendar_today),
                    hintText: 'birth_date'.tr,
                    contentPadding: const EdgeInsets.all(15),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'voter_id'.tr,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'voter_id'.tr,
                    contentPadding: const EdgeInsets.all(15),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
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
