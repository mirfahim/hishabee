import 'package:flutter/material.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';

Widget costListCard() {
  return Container(
    decoration: BoxDecoration(
        color: Color(
          0xFFF1F1F1,
        ),
        borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text('Salary'),
              Text('Type: panir bill'),
              Text('27th September')
            ],
          ),
          Text('1000\$')
        ],
      ),
    ),
  );
}

class ExpenseList2 extends StatefulWidget {
  @override
  _ExpenseList2State createState() => _ExpenseList2State();
}

class _ExpenseList2State extends State<ExpenseList2> {
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
        title: const Text('Expense book'),
        backgroundColor: bgColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height,
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                          color: DEFAULT_BLUE,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Total Cost'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.arrow_back_ios_new)),
                              const Text('18th September'),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.arrow_forward_ios)),
                            ],
                          ),
                          Text('5000\$')
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  costListCard(),
                  SizedBox(
                    height: 10,
                  ),
                  costListCard(),
                  SizedBox(
                    height: 10,
                  ),
                  costListCard(),
                  SizedBox(
                    height: 10,
                  ),
                  costListCard(),
                  SizedBox(
                    height: 10,
                  ),
                  costListCard(),
                  SizedBox(
                    height: 10,
                  ),
                  costListCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
