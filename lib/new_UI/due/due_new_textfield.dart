import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';

class DueNewTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        title: Column(
          children: [
            Text(
              'নতুন বাকি',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            Text(
              'তুসার টেলিকম',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: height,
            color: DEFAULT_BODY_BG_COLOR,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'শ্রেনী নির্বাচন করুন',
                    style: TextStyle(
                        color: Colors.black, fontSize: 14, fontFamily: 'Rubik'),
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
                    height: 20,
                  ),
                  Text(
                    'বাকির ধরণ নির্বাচন করুন',
                    style: TextStyle(
                        color: Colors.black, fontSize: 14, fontFamily: 'Rubik'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Center(
                            child: Text(
                              'পেলাম/জমা',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Rubik'),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: DEFAULT_BLUE,
                            fixedSize: Size(width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Center(
                            child: Text(
                              'দিলাম/বাকি',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Rubik'),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            fixedSize: Size(width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('নাম'),
                  TextFormField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp('[a-zA-Z0-9]'),
                      ),
                    ],
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      counterText: "",
                      hintText: 'নাম',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('মোবাইল নাম্বার'),
                  TextFormField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp('[0-9]'),
                      ),
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      counterText: "",
                      hintText: 'মোবাইল নাম্বার',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('বাকির পরিমাণ'),
                  TextFormField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp('[0-9]'),
                      ),
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      counterText: "",
                      hintText: 'বাকির পরিমাণ',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('বিবরণ ( না দিলেও হবে)'),
                  TextFormField(
                    maxLines: 5,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp('[a-zA-Z0-9]'),
                      ),
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      counterText: "",
                      hintText: 'বিবরণ ( না দিলেও হবে)',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('১৮ অক্টোবর , ২০২১'),
                      Text('রিসিপ্ট যুক্ত করুন')
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      height: 30,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.35),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Text(
                            'এস এম এস - ফ্রি (২০)',
                            style: TextStyle(color: Colors.blue),
                          ),
                          Switch(
                            onChanged: (bool value) {},
                            value: true,
                          )
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Center(
                      child: Text(
                        'সেভ করুন',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 12),
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
        ),
      ),
    );
  }
}
