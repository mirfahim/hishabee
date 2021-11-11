import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

Widget textFormFeildForExpense(
    {int lengthInputFormater,
    String regEx,
    String hintText,
    String labelText,
    IconButton iconButton,
    int maxLine}) {
  return TextFormField(
    cursorColor: Colors.black,
    keyboardType: TextInputType.number,
    minLines: maxLine,
    inputFormatters: [
      LengthLimitingTextInputFormatter(lengthInputFormater),
      FilteringTextInputFormatter.allow(
        RegExp(regEx),
      ),
    ],
    // maxLength: maxLength,
    onChanged: (value) {
      // controller.mobileNumber.value = value;
    },
    maxLines: maxLine,
    decoration: InputDecoration(
      label: Text(labelText),
      suffix: iconButton,
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      counterText: "",
      hintText: hintText,
      hintStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black26,
      ),
    ),
  );
}

class NewExpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('New Expense'),
        backgroundColor: DEFAULT_BODY_BG_COLOR,
      ),
      body: SafeArea(
        child: Container(
          height: height,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text('Give your Mobile Number'),
                textFormFeildForExpense(
                    labelText: 'Mobile Number',
                    hintText: 'Give Your Mobile Number',
                    iconButton: IconButton(
                      icon: Icon(Icons.people),
                      color: DEFAULT_BLUE,
                      onPressed: () {},
                    ),
                    regEx: '[0-9]'),
                SizedBox(
                  height: 20,
                ),
                // const Text('Amount of expenses'),
                textFormFeildForExpense(
                    labelText: 'Amount of Expenses',

                    // iconButton: IconButton(
                    //   icon: Icon(Icons.people),
                    //   color: buttonColor,
                    //   onPressed: () {},
                    // ),
                    regEx: '[0-9]'),
                SizedBox(
                  height: 20,
                ),
                textFormFeildForExpense(
                    labelText: 'Expense Reason',

                    // iconButton: IconButton(
                    //   icon: Icon(Icons.people),
                    //   color: buttonColor,
                    //   onPressed: () {},
                    // ),
                    regEx: '[a-zA-z]'),
                SizedBox(
                  height: 20,
                ),
                textFormFeildForExpense(
                    labelText: 'Expense Description',
                    maxLine: 5,

                    // iconButton: IconButton(
                    //   icon: Icon(Icons.people),
                    //   color: buttonColor,
                    //   onPressed: () {},
                    // ),
                    regEx: '[a-zA-z]'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
