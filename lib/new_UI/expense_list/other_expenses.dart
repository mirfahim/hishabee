import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';

Widget ExpensesCard(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFFF1F1F1),
    ),
    height: 50,
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
          child: Row(
            children: [
              SvgPicture.asset('assets/imageEmpty.svg'),
              SizedBox(
                width: 10,
              ),
              Text('Mouse')
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit),
                color: Colors.blue,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete),
                color: Colors.red,
              ),
            ],
          ),
        )
      ],
    ),
  );
}

class OthersExpenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Other Expenses'),
        backgroundColor: bgColor,
      ),
      body: SafeArea(
        child: Container(
          height: height,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ExpensesCard(context),
                ElevatedButton(
                  onPressed: () {},
                  child: const Center(
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
