import 'package:flutter/material.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';


Widget textFormFeildForExpense(
    {String hintText,
    String labelText,
    IconButton iconButton,
    int maxLine}) {
  return TextFormField(
    cursorColor: Colors.black,
    minLines: maxLine,
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

class ExpenseTypeFirst extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('New Expense'),
        backgroundColor: bgColor,
      ),
      body: SafeArea(
        child: Container(
          height: height,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Name of type of the Expense'),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormFeildForExpense(
                        hintText: 'Type Name', labelText: 'Type')
                  ],
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
                    fixedSize: Size(width, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
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
