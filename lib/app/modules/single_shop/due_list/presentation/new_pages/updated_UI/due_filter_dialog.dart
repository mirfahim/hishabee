import 'package:flutter/material.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

class DueFilterDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        color: DEFAULT_BODY_BG_COLOR,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('ফিল্টার'), Icon(Icons.cut)],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'তারিখ নির্বাচন করুন',
                style: TextStyle(fontSize: 14),
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
                        borderRadius: BorderRadius.circular(10),
                        color: DEFAULT_BLUE),
                    child: Center(
                      child: Text(
                        'আজ',
                        style: TextStyle(fontSize: 14, color: Colors.white),
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
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'গতকাল',
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
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'গত ৭ দিন',
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
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'এই মাস',
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
                children: [
                  Container(
                    height: 40,
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
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
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
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
                height: 20,
              ),
              Text(
                'শ্রেনী নির্বাচন করুন',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: 'কাস্টমার',
                    groupValue: 'groupValue',
                    onChanged: (value) {},
                    activeColor: Colors.blue,
                  ),
                  Text('কাস্টমার'),
                  Radio(
                    value: 'কাস্টমার',
                    groupValue: 'groupValue',
                    onChanged: (value) {},
                  ),
                  Text('সাপ্লায়ার'),
                  Radio(
                    value: 'কাস্টমার',
                    groupValue: 'groupValue',
                    onChanged: (value) {},
                  ),
                  Text('কর্মচারী'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'বাকির ধরণ নির্বাচন করুন',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: 'কাস্টমার',
                    groupValue: 'groupValue',
                    onChanged: (value) {},
                    activeColor: Colors.blue,
                  ),
                  Text('পাবো'),
                  Radio(
                    value: 'কাস্টমার',
                    groupValue: 'groupValue',
                    onChanged: (value) {},
                  ),
                  Text('দিবো'),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                child: Center(
                  child: Text(
                    'নিশ্চিত',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
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
      ),
    );
  }
}
