/// Bar chart with series legend example
// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/report/presentation/manager/report_controller.dart';
import 'package:intl/intl.dart';

import 'custom_card_container.dart';

class ExpensesPieChart extends GetView<ReportController> {
  final bool animate;

  ExpensesPieChart({this.animate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 0),
      child: CustomCardContainer(
        height: 300,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "expense".tr,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: DEFAULT_BLACK,
                  letterSpacing: 1.3,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    controller.decrementDate();
                  },
                ),
                Spacer(),
                Obx(
                  () => Text(
                    '${DateFormat('MMM yyyy').format(controller.date.value)}',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: DEFAULT_BLACK,
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    controller.incrementDate();
                  },
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20),
                    child: Obx(() => Container())
                    // Obx(
                    //   () {
                    //     // final seriesData = controller.pieChartData.toList();
                    //     // print("Emp: ${seriesData.isEmpty}");
                    //     return
                    //       seriesData.isEmpty
                    //         ? Container()
                    //         : charts.PieChart(
                    //             seriesData,
                    //             animate: animate,
                    //             animationDuration: Duration(milliseconds: 500),
                    //             behaviors: [
                    //               new charts.DatumLegend(
                    //                 outsideJustification:
                    //                     charts.OutsideJustification.endDrawArea,
                    //                 horizontalFirst: false,
                    //                 desiredMaxRows: 1,
                    //                 cellPadding: new EdgeInsets.only(
                    //                     right: 4.0, bottom: 4.0),
                    //                 entryTextStyle: charts.TextStyleSpec(
                    //                     color: charts.MaterialPalette.black,
                    //                     fontFamily: 'Georgia',
                    //                     fontSize: 12),
                    //               )
                    //             ],
                    //             defaultRenderer: new charts.ArcRendererConfig(
                    //                 arcWidth: 100,
                    //                 arcRendererDecorators: [
                    //                   new charts.ArcLabelDecorator(
                    //                       labelPosition:
                    //                           charts.ArcLabelPosition.auto)
                    //                 ]),
                    //             // Add the series legend behavior to the chart to turn on series legends.
                    //             // By default the legend will display above the chart.
                    //           );
                    //   },
                    // ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
