// import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/_bindings/due_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_list_controller.dart';
import 'package:number_display/number_display.dart';

import 'add_due_page.dart';
import 'due_details_page.dart';

class DueListPage extends GetView<DueFrontController> {
  final display = createDisplay();
  final Shop shop;
  DueListPage({
    this.shop,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: Container(
          width: size.width,
          height: 40,
          decoration: BoxDecoration(
            color: DEFAULT_BLUE,
            borderRadius: BorderRadius.circular(6)
          ),
          child: Center(
            child: Text(
              'add_due'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        titleSpacing: 0,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Container(
        //       width: 100,
        //       height: 30,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(4),
        //         color: Colors.black,
        //       ),
        //       child: TextButton(
        //         onPressed: () {
        //           Get.to(() => AddDuePage(),
        //               arguments: {
        //                 "shop": controller.shop.value,
        //                 "due": null,
        //               },
        //               binding: DueListBinding());
        //         },
        //         child: Text(
        //           'add_due'.tr,
        //           style: TextStyle(
        //             fontFamily: 'Rubik',
        //             fontSize: 16,
        //             fontWeight: FontWeight.bold,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //     ),
        //   )
        // ],
        title: Column(
          children: [
            Text(
              'dueList'.tr,
              style: TextStyle(color: Colors.black, fontFamily: 'Roboto'),
            ),
            // Text(
            //   'তুসার টেলিকম',
            //   style: TextStyle(color: Colors.black, fontSize: 12),
            // ),
          ],
        ),
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Container(
                    height: 170,
                    decoration: BoxDecoration(
                      color: DEFAULT_BLUE,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text('total_due'.tr, style: TextStyle(
                            color: Color(0xFFFECD1A),
                            fontSize: 16
                          ),),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 60,
                              width: size.width / 2.5,
                              decoration: BoxDecoration(
                                color: Color(0xFFC4C4C4).withOpacity(.35),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text('700', style: TextStyle(
                                      color: Colors.white
                                    ),),
                                    Text('lend'.tr, style: TextStyle(
                                        color: Colors.white
                                    ),)
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 60,
                              width: size.width / 2.5,
                              decoration: BoxDecoration(
                                color: Color(0xFFC4C4C4).withOpacity(.35),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text('১০০০ টাকা', style: TextStyle(
                                        color: Colors.white
                                    ),),
                                    Text('borrowed'.tr, style: TextStyle(
                                        color: Colors.white
                                    ),)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        GestureDetector(
                          onTap: (){},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.history, color: Colors.white,),
                              Text('due_history'.tr, style: TextStyle(
                                color: Colors.white
                              ),)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10, right: 10),
                child: Container(
                  height: 50,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset:
                            Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Icon(
                          Icons.search,
                          color: DEFAULT_BLUE,
                          size: 22,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Container(
                          width: size.width * 0.7,
                          child: TextFormField(
                            onChanged: (value) {
                              controller.searchDue(value);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintText: "Search by name or number",
                              hintStyle: TextStyle(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10, right: 10, bottom: 120),
                child: Container(
                  height: size.height - 170,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(1, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.searchList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Due due = controller.searchList[index];
                        return InkWell(
                          onTap: () {
                            Get.to(
                              () => DueDetailsPage(
                                  // shop: controller.shop.value,
                                  // due: due,
                                  ),
                              binding: DueListBinding(),
                            );
                          },
                          child: Container(
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.grey),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8, left: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
                                  ),
                                  Container(
                                    width: size.width * 0.3,
                                    child: Text(
                                      due.contactName,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLUE),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.3,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "${display(controller.dueList[index].dueAmount)} /=",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: "",
                                          style:
                                              DefaultTextStyle.of(context)
                                                  .style,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    "${due.updatedAt.day}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    " ${getMonthName(due.updatedAt.month)}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    " ${due.updatedAt.year}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.arrow_forward)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: missing_return
  String getMonthName(int monthNumber) {
    switch (monthNumber) {
      case 1:
        return "January";
        break;
      case 2:
        return "February";
        break;
      case 3:
        return "March";
        break;
      case 4:
        return "April";
        break;
      case 5:
        return "May";
        break;
      case 6:
        return "June";
        break;
      case 7:
        return "July";
        break;
      case 8:
        return "August";
        break;
      case 9:
        return "September";
        break;
      case 10:
        return "October";
        break;
      case 11:
        return "November";
        break;
      case 12:
        return "December";
        break;
    }
  }

// _materialDialog(String data) {
//   showDialog(
//     context: context,
//     builder: (_) => new AlertDialog(
//       content: new Text(data),
//       actions: <Widget>[
//         FlatButton(
//           child: Text('Close'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         )
//       ],
//     ),
//   );
// }

// _cupertinoDialog(String data) {
//   showDialog(
//     context: context,
//     builder: (_) => new CupertinoAlertDialog(
//       content: new Text(data),
//       actions: <Widget>[
//         FlatButton(
//           child: Text('Close'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         )
//       ],
//     ),
//   );
// }
}
