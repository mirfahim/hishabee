import 'package:flutter/material.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';

class DueDetailsCustomer extends StatelessWidget {
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
              'বাকির খাতা',
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
                children: [
                  Container(
                    height: height - 470,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: DEFAULT_BLUE,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'এস এম আলীউজ্জামান',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '০১৭৮৮৬৫১৭৭৪',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'মোট দিবো :',
                                    style: TextStyle(
                                        color: Colors.amber, fontSize: 14),
                                  ),
                                  Text(
                                    '৮,০০০',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.call,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.message,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Divider(
                            thickness: 2,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'বাকি পরিশোধের তারিখ :',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'নির্বাচন করুন ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.call),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'বাকির ইতিহাস',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      Row(
                        children: [
                          Text(
                            'বাকি /',
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                          Text(
                            'জমা',
                            style: TextStyle(color: Colors.green, fontSize: 14),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: width,
                    height: height / 7.50,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.35),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('১৯ অক্টোবর , ২০২১'),
                      ),
                      subtitle: Text('১০.৩৫ AM'),
                      trailing: Column(
                        children: [
                          Text(
                            '১০৯৯টাকা',
                            style: TextStyle(color: Colors.green),
                          ),
                          Text('কাস্টমার'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Center(
                            child: Text(
                              'দিলাম/বাকি',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(width: 1, color: DEFAULT_BLUE),
                            primary: Colors.red,
                            fixedSize: Size(width, 20),
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
                              'পেলাম/জমা',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(width: 1, color: DEFAULT_BLUE),
                            primary: Colors.green,
                            // fixedSize: Size(, 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      )
                    ],
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
