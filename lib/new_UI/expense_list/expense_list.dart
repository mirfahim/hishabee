import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';

List<Widget> costList = [
  CostCard(),
  CostCard(),
  CostCard(),
  CostCard(),
  CostCard(),
  CostCard(),
];
List<Widget> costTypeList = [
  costTypeCard('assets/calenderMoney.svg', 'Pay Salary'),
  costTypeCard('assets/rent.svg', 'Pay Rent'),
  costTypeCard('assets/boxTick.svg', 'Products'),
  costTypeCard('assets/utilityBill.svg', 'Pay Utility bill'),
  costTypeCard('assets/calenderMoney.svg', 'Pay Salary'),
  costTypeCard('assets/calenderMoney.svg', 'Pay Salary'),
];

List<Widget> costType = [];

Widget CostCard() {
  return Container(
    width: 70,
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFC4C4C4).withOpacity(.35)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            '1000\$',
            style: TextStyle(color: Color(0xFFDFE0EB), fontSize: 14),
          ),
          Text(
            '40%',
            style: TextStyle(color: Color(0xFFDFE0EB), fontSize: 11),
          ),
          Text(
            'Salary',
            style: TextStyle(color: Color(0xFFDFE0EB), fontSize: 11),
          )
        ],
      ),
    ),
  );
}

Widget costTypeCard(String svgPictureAsset, String typeText) {
  return Container(
    height: 70,
    width: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFC4C4C4).withOpacity(.35)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [SvgPicture.asset(svgPictureAsset), Text(typeText)],
    ),
  );
}

class ExpenseList extends StatelessWidget {
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
        title: const Text('Expense List'),
        backgroundColor: bgColor,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: height,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: DEFAULT_BLUE,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Cost',
                                  style: TextStyle(
                                      color: Color(0xFFFECD1A), fontSize: 16),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: SvgPicture.asset(
                                      'assets/costSign.svg',
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  '5000\$',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                                Text(
                                  '18th September, 2021',
                                  style: TextStyle(
                                      color: Color(0xFFDFE0EB), fontSize: 12),
                                ),
                              ],
                            ),
                            Divider(
                              color: const Color(0xFFC4C4C4).withOpacity(.35),
                              thickness: 1.5,
                            ),
                            GridView.count(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5,
                              shrinkWrap: true,
                              children: List.generate(
                                costList.length,
                                (index) => costList[index],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Expense Type'),
                      ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            children: [Icon(Icons.add), Text('Expense Type')],
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                      shrinkWrap: true,
                      children: List.generate(
                        costTypeList.length,
                        (index) => costTypeList[index],
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
