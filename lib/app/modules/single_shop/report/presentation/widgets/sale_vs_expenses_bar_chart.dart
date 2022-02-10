import 'dart:core';

// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/report/presentation/manager/report_controller.dart';
import 'package:intl/intl.dart';

import 'custom_card_container.dart';

class SaleVsExpenseBarChart extends GetView<ReportController> {
  final bool animate;

  SaleVsExpenseBarChart({this.animate});

  // String vocalizeDomainAndMeasures(List<charts.SeriesDatum> seriesDatums) {
  //   final buffer = new StringBuffer();
  //
  //   buffer.write(seriesDatums.first.datum.year);
  //
  //   // for (charts.SeriesDatum seriesDatum in seriesDatums) {
  //   //   final series = seriesDatum.series;
  //   //   final datum = seriesDatum.datum;
  //   //
  //   //   buffer.write(' ${series.displayName} '
  //   //       '${datum.sales / 1000} thousand dollars');
  //   // }
  //
  //   return buffer.toString();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: CustomCardContainer(
        height: 300,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "sale_vs_expense".tr,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: DEFAULT_BLACK,
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
                // child: DomainA11yExploreBarChart.withSampleData(),
                child: Semantics(
                  // Describe your chart
                  label: 'Yearly sales bar chart',
                  hint: 'Press and hold to enable explore',
                  child:
                      // final barChartData = controller.barChartData.toList();
                      Container(),
                  // barChartData.isEmpty
                  //   ? Container()
                  //   : charts.BarChart(
                  //       barChartData,
                  //       animate: animate,
                  //       animationDuration: Duration(milliseconds: 500),
                  //       defaultInteractions:
                  //           !MediaQuery.of(context).accessibleNavigation,
                  //       behaviors: [
                  //         new charts.DomainA11yExploreBehavior(
                  //           // Callback for generating the message that is vocalized.
                  //           // An example of how to use is in [vocalizeDomainAndMeasures].
                  //           // If none is set, the default only vocalizes the domain value.
                  //           vocalizationCallback:
                  //               vocalizeDomainAndMeasures,
                  //           // The following settings are optional, but shown here for
                  //           // demonstration purchases.
                  //           // [exploreModeTrigger] Default is press and hold, can be
                  //           // changed to tap.
                  //           exploreModeTrigger:
                  //               charts.ExploreModeTrigger.pressHold,
                  //           // [exploreModeEnabledAnnouncement] Optionally notify the OS
                  //           // when explore mode is enabled.
                  //           exploreModeEnabledAnnouncement:
                  //               'Explore mode enabled',
                  //           // [exploreModeDisabledAnnouncement] Optionally notify the OS
                  //           // when explore mode is disabled.
                  //           exploreModeDisabledAnnouncement:
                  //               'Explore mode disabled',
                  //           // [minimumWidth] Default and minimum is 1.0. This is the
                  //           // minimum width of the screen reader bounding box. The bounding
                  //           // box width is calculated based on the domain axis step size.
                  //           // Minimum width will be used if the step size is smaller.
                  //           minimumWidth: 1.0,
                  //         ),
                  //         // Optionally include domain highlighter as a behavior.
                  //         // This behavior is included in this example to show that when an
                  //         // a11y node has focus, the chart's internal selection model is
                  //         // also updated.
                  //         new charts.DomainHighlighter(
                  //             charts.SelectionModelType.info),
                  //       ],
                  //     );
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
