import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

class PasswordPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset('images/slogan.png'),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'তথ্য সুরক্ষার জন্য আপনার ৫ ডিজিটের পিন দিয়ে দোকানে প্রবেশ করুন',
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                cursorColor: DEFAULT_BLACK,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(5),
                  FilteringTextInputFormatter.allow(
                    RegExp('[0-9]'),
                  ),
                ],
                maxLength: 11,
                onChanged: (value) {
                  // controller.mobileNumber.value = value;
                },
                decoration: InputDecoration(
                  prefix: Text(
                    "+88 ",
                    style: TextStyle(
                        color: DEFAULT_BLACK.withOpacity(0.7)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  border: InputBorder.none,
                  counterText: "",
                  hintText: 'Mobile Number',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w100,
                    color: Colors.black26,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'পিন ভুলে গেছেন?',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}