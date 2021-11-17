import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constants_widgets.dart';

import 'package:input_calculator/input_calculator.dart';

class QuickSell extends StatefulWidget {
  @override
  State<QuickSell> createState() => _QuickSellState();
}

class _QuickSellState extends State<QuickSell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Quick Sell'),
        backgroundColor: Colors.amber,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset('assets/questionMark.svg'),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 15),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      elevatedButtonStyled(
                          text: 'Quick Sell',
                          icon: null,
                          buttonColor: DEFAULT_BLUE,
                          buttonTextColor: Colors.white,
                          width: 150,
                          height: 40,
                          svgAsset: 'assets/bag.svg'),
                      elevatedButtonStyled(
                          text: 'Quick Sell',
                          icon: null,
                          buttonColor: Colors.white,
                          buttonTextColor: DEFAULT_BLUE,
                          width: 150,
                          height: 40,
                          svgAsset: 'assets/money.svg'),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // TextFormFieldWithBorder(
                  //   hintText: 'Got the Cash',
                  //   regEx: '',
                  //   textFieldColor: Colors.white,
                  // ),
                  CalculatorTextFormField(
                    inputDecoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      counterText: "",
                      hintText: 'Pay Cash',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CalculatorTextFormField(
                    inputDecoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      counterText: "",
                      hintText: 'Description of Text',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Center(
                          child: Text(
                            '14th September, 2021',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 1, color: Colors.black),
                          primary: Colors.white,
                          fixedSize: Size(120, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Center(
                          child: Text(
                            'Add Reciept',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(width: 1, color: Colors.black),
                          primary: Colors.white,
                          fixedSize: const Size(120, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Center(
                      child: Text(
                        'Enter',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      // side: BorderSide(
                      //   width: 1,
                      // ),
                      primary: DEFAULT_BLUE,
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
