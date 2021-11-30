import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset('images/slogan.png'),
                const SizedBox(
                  height: 30,
                ),
                const Text('tottho shurokkhar jnw 5 digit er pin din'),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  cursorColor: Colors.black,
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
                    suffixIcon: const Icon(Icons.visibility_off),
                    // prefix: Text(
                    //   " Give your Pin",
                    //   style: TextStyle(color: Colors.black.withOpacity(0.7)),
                    // ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    counterText: "",
                    hintText: 'Give your pin',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black26,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  cursorColor: Colors.black,
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
                    suffixIcon: const Icon(Icons.visibility_off),
                    // prefix: Text(
                    //   " Give your Pin",
                    //   style: TextStyle(color: Colors.black.withOpacity(0.7)),
                    // ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    counterText: "",
                    hintText: 'Confirm your pin',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black26,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('confirm it'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF185ADB),
                      fixedSize: Size(400, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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
