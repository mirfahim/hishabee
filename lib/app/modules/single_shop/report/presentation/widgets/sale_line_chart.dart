// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/report/presentation/manager/report_controller.dart';
import 'package:intl/intl.dart';

import 'custom_card_container.dart';

class SaleLineChart extends GetView<ReportController> {
  final bool animate;

  const SaleLineChart({Key key, this.animate}) : super(key: key);

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
                "sale".tr,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: DEFAULT_BLACK,
                ),
              ),
            ),
            SizedBox(
              height: 0,
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
            SizedBox(
              height: 0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(),
                // Obx(
                //   () {
                //     final seriesData = controller.saleLineData.toList();
                //     return seriesData.isEmpty
                //         ? Container()
                //         : charts.TimeSeriesChart(
                //             seriesData,
                //             animate: animate,
                //             animationDuration: Duration(milliseconds: 500),
                //             // behaviors: [
                //             //   charts.RangeAnnotation([
                //             //     charts.RangeAnnotationSegment(
                //             //         DateTime(2021, 5, 1),
                //             //         DateTime(2021, 5, 30),
                //             //         charts.RangeAnnotationAxisType.domain),
                //             //   ]),
                //             //   // charts.LinePointHighlighter()
                //             // ],
                //           );
                //   },
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
