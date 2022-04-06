import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hishabee_business_manager_fl/app/_utils/analytics_event.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_workmanager/analytics_service.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/calculator/calculator_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_controller.dart';
//import 'package:hishabee_business_manager_fl/app/modules/single_shop/sell/presentation/manager/sell_controller.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcButton extends GetView<SellController> {
  Widget build(BuildContext context) {
    return Obx(
      () => SimpleCalculator(
        value: controller.amountCal.toDouble(),
        hideExpression: false,
        hideSurroundingBorder: true,
        onChanged: (key, value, expression) {
          controller.amountCal.value = value;
        },
        onTappedDisplay: (value, details) {},
        theme: const CalculatorThemeData(
          borderColor: Colors.white,
          borderWidth: 1,
          displayColor: Colors.black,
          displayStyle: const TextStyle(fontSize: 80, color: DEFAULT_YELLOW_BG),
          expressionColor: Colors.white,
          expressionStyle: const TextStyle(fontSize: 16, color: Colors.black),
          operatorColor: DEFAULT_BLACK,
          operatorStyle: const TextStyle(fontSize: 30, color: Colors.white),
          commandColor: DEFAULT_BLACK,
          commandStyle: const TextStyle(fontSize: 30, color: Colors.white),
          numColor: Colors.grey,
          numStyle: const TextStyle(fontSize: 25, color: Colors.white),
        ),

      ),

    );

  }
}

// class Calculator extends StatefulWidget {
//   @override
//   _CalculatorState createState() => _CalculatorState();
// }
//
// class _CalculatorState extends State<Calculator> {
//   String equation = "0";
//   String result = "0";
//   String expression = "";
//   double equationFontSize = 38.0;
//   double resultFontSize = 48.0;
//
//   buttonPressed(String buttonText) {
//     setState(() {
//       if (buttonText == "C") {
//         equation = "0";
//         result = "0";
//         equationFontSize = 38.0;
//         resultFontSize = 48.0;
//       } else if (buttonText == "⌫") {
//         equationFontSize = 48.0;
//         resultFontSize = 38.0;
//         equation = equation.substring(0, equation.length - 1);
//         if (equation == "") {
//           equation = "0";
//         }
//       } else if (buttonText == "=") {
//         equationFontSize = 38.0;
//         resultFontSize = 48.0;
//
//         expression = equation;
//         expression = expression.replaceAll('×', '*');
//         expression = expression.replaceAll('÷', '/');
//
//         try {
//           Parser p = Parser();
//           Expression exp = p.parse(expression);
//
//           ContextModel cm = ContextModel();
//           result = '${exp.evaluate(EvaluationType.REAL, cm)}';
//         } catch (e) {
//           result = "error";
//         }
//       } else {
//         equationFontSize = 48.0;
//         resultFontSize = 38.0;
//         if (equation == "0") {
//           equation = buttonText;
//         } else {
//           equation = equation + buttonText;
//         }
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     AnalyticsService.sendAnalyticsToServer(event: AnalyticsEvent.calculator);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.all(8),
//               child: Container(
//                 height: size.height * 0.22,
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(8)),
//                 alignment: Alignment.centerRight,
//                 padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
//                 child: SingleChildScrollView(
//                   child: Text(
//                     equation,
//                     style: TextStyle(fontSize: equationFontSize),
//                   ),
//                   reverse: true,
//                 ),
//               ),
//             ),
//             Container(
//               alignment: Alignment.centerRight,
//               padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//               child: Text(
//                 result == "error"
//                     ? "SynTextError"
//                     : "${double.parse(double.parse(result).toStringAsFixed(2))}",
//                 style: TextStyle(
//                     fontSize: resultFontSize,
//                     color: result == "error" ? Colors.red : DEFAULT_BLUE),
//               ),
//             ),
//             Expanded(
//               child: Divider(),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   width: MediaQuery.of(context).size.width * .75,
//                   child: Table(
//                     children: [
//                       TableRow(children: [
//                         buildButton(
//                           "C",
//                           1,
//                           DEFAULT_BLACK,
//                           Colors.white,
//                         ),
//                         buildButton(
//                           "⌫",
//                           1,
//                           DEFAULT_BLACK,
//                           Colors.white,
//                         ),
//                         buildButton(
//                           "÷",
//                           1,
//                           DEFAULT_BLACK,
//                           Colors.white,
//                         ),
//                       ]),
//                       TableRow(children: [
//                         buildButton("7", 1, Colors.white, DEFAULT_BLACK),
//                         buildButton("8", 1, Colors.white, DEFAULT_BLACK),
//                         buildButton("9", 1, Colors.white, DEFAULT_BLACK),
//                       ]),
//                       TableRow(children: [
//                         buildButton("4", 1, Colors.white, DEFAULT_BLACK),
//                         buildButton("5", 1, Colors.white, DEFAULT_BLACK),
//                         buildButton("6", 1, Colors.white, DEFAULT_BLACK),
//                       ]),
//                       TableRow(children: [
//                         buildButton("1", 1, Colors.white, DEFAULT_BLACK),
//                         buildButton("2", 1, Colors.white, DEFAULT_BLACK),
//                         buildButton("3", 1, Colors.white, DEFAULT_BLACK),
//                       ]),
//                       TableRow(children: [
//                         buildButton(".", 1, Colors.white, DEFAULT_BLACK),
//                         buildButton("0", 1, Colors.white, DEFAULT_BLACK),
//                         buildButton("00", 1, Colors.white, DEFAULT_BLACK),
//                       ]),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.25,
//                   child: Table(
//                     children: [
//                       TableRow(children: [
//                         buildButton("×", 1, DEFAULT_BLACK, Colors.white),
//                       ]),
//                       TableRow(children: [
//                         buildButton("-", 1, DEFAULT_BLACK, Colors.white),
//                       ]),
//                       TableRow(children: [
//                         buildButton("+", 1, DEFAULT_BLACK, Colors.white),
//                       ]),
//                       TableRow(children: [
//                         buildButton("=", 2, DEFAULT_BLACK, Colors.white),
//                       ]),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildButton(String buttonText, double buttonHeight, Color buttonColor,
//       Color textColor) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: buttonColor,
//       ),
//
//       child: FlatButton(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(0.0),
//               side: BorderSide(
//                   color: Colors.white, width: 1, style: BorderStyle.solid)),
//           padding: EdgeInsets.all(12.0),
//           highlightColor: DEFAULT_BLUE,
//           onPressed: () => buttonPressed(buttonText),
//           child: Text(
//             buttonText,
//             style: TextStyle(
//                 fontSize: 30.0,
//                 fontWeight: FontWeight.normal,
//                 color: textColor),
//           )),
//     );
//   }
// }
