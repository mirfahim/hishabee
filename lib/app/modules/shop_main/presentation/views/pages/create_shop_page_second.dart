import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SignUpBodySecond extends StatefulWidget {


  @override
  State<SignUpBodySecond> createState() => _SignUpBodySecondState();
}

class _SignUpBodySecondState extends State<SignUpBodySecond> {
  @override
  Widget build(BuildContext context) {
    String selectCity = 'Samin';
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final citiesSelected = TextEditingController();
    List _cities = [
      "বিভাগ",
      "চট্টগ্রাম",
      "ঢাকা",
      "বরিশাল",
      "সিলেট",
      "রাজশাহী",
      "খুলনা",
      "রংপুর"
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              width: double.infinity,
              // height: 500,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      30,
                    ),
                    topRight: Radius.circular(
                      30,
                    ),
                  )),
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 30, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('images/slogan.png'),
                    const Text(
                      "হিসাবি ব্যবসার অ্যায়কাউন্ট তৈরি করুন",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            onSaved: (value) {
                              // controller.brandName.value = value;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "name_of_business".tr,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 40,
                          width: 150,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton(
                            hint: const Text('বিভাগ'),
                            dropdownColor: Colors.white,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 30,
                            isExpanded: true,
                            underline: const SizedBox(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                            value: _cities[0],
                            onChanged: (value) {
                              setState(() {
                                selectCity = value.toString();
                              });
                            },
                            items: _cities
                                .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                                .toList(),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 150,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton(
                            hint: const Text('বিভাগ'),
                            dropdownColor: Colors.white,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 30,
                            isExpanded: true,
                            underline: const SizedBox(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                            value: _cities[0],
                            onChanged: (value) {
                              setState(() {
                                selectCity = value.toString();
                              });
                            },
                            items: _cities
                                .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                                .toList(),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 40,
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton(
                        hint: const Text('বিভাগ'),
                        dropdownColor: Colors.white,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 30,
                        isExpanded: true,
                        underline: const SizedBox(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                        value: _cities[0],
                        onChanged: (value) {
                          setState(() {
                            selectCity = value.toString();
                          });
                        },
                        items: _cities
                            .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                            .toList(),
                      ),
                    ),

                    ///TODO need a drop down here with a locaiton indicator
                    const SizedBox(height: 20),
                    const Text(
                        '[মানচিত্র আইকনটি টিপে আপনার দোকানের ঠিকানা নির্বাচন করুন]'),
                    SizedBox(height: 20),
                    Container(
                      height: 40,
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 5, top: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'রেফারেল (যদি থাকে)'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: Colors.black,
                            // value: controller.termsAgreed.value,
                            onChanged: (value) {
                              // controller.termsAgreed.value = value;
                            },
                            value: true,
                          ),
                          // Obx(
                          //   () => Checkbox(
                          //     checkColor: Colors.white,
                          //     activeColor: Colors.black,
                          //     // value: controller.termsAgreed.value,
                          //     onChanged: (value) {
                          //       // controller.termsAgreed.value = value;
                          //     },
                          //     value: null,
                          //   ),
                          // ),
                          // Obx(
                          //       () => const Text(
                          //     'I have read and accept',
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //         // controller.termsAgreed.value
                          //         //     ? FontWeight.bold
                          //         //     : FontWeight.normal,
                          //         fontSize: 12,
                          //         color: Colors.black),
                          //   ),
                          // ),
                          const Text(
                            'I have read and accept',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                // controller.termsAgreed.value
                                //     ? FontWeight.bold
                                //     : FontWeight.normal,
                                fontSize: 12,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        const url = 'https://hishabee.business/terms-of-use/';
                        // if (await canLaunch(url)) {
                        //   await launch(url);
                        // } else {
                        //   throw 'Could not launch $url';
                        // }
                      },
                      child: Center(
                        child: Text(
                          "General Terms & Conditions",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        const url =
                            'https://hishabee.business/business-manager-terms-of-use/';
                        // if (await canLaunch(url)) {
                        //   await launch(url);
                        // } else {
                        //   throw 'Could not launch $url';
                        // }
                      },
                      child: Center(
                        child: Text(
                          "Business Manager Terms &Condition",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'প্রবেশ করুন',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF185ADB),
                            padding: const EdgeInsets.only(
                                left: 100, right: 100, top: 20, bottom: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}