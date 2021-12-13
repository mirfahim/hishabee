import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';

class DueFront extends StatelessWidget {
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
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
              child: Column(
                children: [
                  Container(
                    height: height - 500,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: DEFAULT_BLUE,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'মোট ব্যলেন্স',
                          style: TextStyle(color: Colors.amber, fontSize: 14),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                            Text('১৯ অক্টবার, ২০২১'),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 60,
                              width: width / 2.5,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text('৭০০০ টাকা'),
                                    Text('বাকি দিবো')
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 60,
                              width: width / 2.5,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text('১০০০ টাকা'),
                                    Text('বাকি দিবো')
                                  ],
                                ),
                              ),
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
                    children: [
                      Expanded(
                        flex: 9,
                        child: TextFormField(
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9]'),
                            ),
                          ],
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            counterText: "",
                            hintText: 'নাম বা মোবাইল নম্বর দিয়ে অনুসন্ধান করুন',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black26,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.menu),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'কাস্টমার(০২)/সাপ্লাইয়ার(০৪)/ কর্মচারী(০৪)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            'পাবো',
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            '/দিবো',
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: width,
                    height: height / 7,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.35),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: Image.asset('images/sharukh2.jpeg'),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('এস এম আলিউজ্জামান'),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('০১৭৮৮৬৫১৭৭৮'),
                          Text('২৭ নভেম্বর, ২০২১ পর্যন্ত')
                        ],
                      ),
                      trailing: Column(
                        children: [
                          Text(
                            '১০৯৯টাকা',
                            style: TextStyle(color: Colors.red),
                          ),
                          Text('কাস্টমার'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: width,
                    height: height / 7,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.35),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: Image.asset('images/sharukh2.jpeg'),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('এস এম আলিউজ্জামান'),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('০১৭৮৮৬৫১৭৭৮'),
                          Text('২৭ নভেম্বর, ২০২১ পর্যন্ত')
                        ],
                      ),
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
                  ElevatedButton(
                    onPressed: () {},
                    child: Center(
                      child: Text(
                        'Enter',
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
