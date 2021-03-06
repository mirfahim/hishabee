import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/_bindings/due_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/new_pages/updated_UI/controller/due_history_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/pages/add_due_page.dart';

import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:get/get.dart';

import '../add_new_due.dart';
import 'due_details_customer.dart';
import 'due_history.dart';
import 'due_history_edit_delete.dart';
import 'due_new_textfield.dart';

class DueFront extends StatefulWidget {
  @override
  State<DueFront> createState() => _DueFrontState();
}

class _DueFrontState extends State<DueFront> {
  DueControllerNew _dueControllerNew = Get.put(DueControllerNew());
  GetAllDueResponseModel _allDue;
  bool _isLoading;

  @override
  void initState() {
    _dueControllerNew.getAllDue(shopId: '8').then((c) {
      _dueControllerNew.dueList.value = getAllDueResponseModelFromJson(c);
      print('length of due: ${_dueControllerNew.dueHistory.value.data.length}');
      setState(() {
        _allDue = getAllDueResponseModelFromJson(c);
        _isLoading = false;
        print('length of due: ${_allDue.data.length}');
      });
    });
    super.initState();
  }

  int flag = 1;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
        child: ElevatedButton(
          onPressed: () {
            Get.to(
              AddDuePage(),
              binding: DueListBinding(),
            );
          },
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'new_due'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 16, fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: DEFAULT_BLUE,
            fixedSize: Size(width, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
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
        title: Column(
          children: [
            Text(
              'dueList'.tr,
              style: TextStyle(color: Colors.black, fontFamily: 'Roboto'),
            ),
            // Text(
            //   '??????????????? ??????????????????',
            //   style: TextStyle(color: Colors.black, fontSize: 12),
            // ),
          ],
        ),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: DEFAULT_BLUE,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'total_balance'.tr,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                color: Color(0xFFFECD1A)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.arrow_back_ios_outlined,
                                      color: Colors.white,
                                      size: 11,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '21th February,2022',
                                  style: TextStyle(
                                      color: Color(0xFFDFE0EB),
                                      fontSize: 13,
                                      fontFamily: 'Roboto'),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: Colors.white,
                                      size: 11,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xFFC4C4C4).withOpacity(.35),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '???${_allDue.total.toString()}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Roboto',
                                                color: Colors.white),
                                          ),
                                          Text(
                                            'get_due'.tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Roboto',
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xFFC4C4C4).withOpacity(.35),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '???700',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Roboto',
                                                color: Colors.white),
                                          ),
                                          Text(
                                            'given_due'.tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Roboto',
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(DueHistory());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'due_history'.tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        color: Colors.white),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: TextFormField(
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9]'),
                            ),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            counterText: "",
                            hintText: '????????? ?????? ?????????????????? ??????????????? ???????????? ??????????????????????????? ????????????',
                            hintStyle: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              color: Color(0xFf707070),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Container(
                                      // height: height,
                                      // color: DEFAULT_BODY_BG_COLOR,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'filter'.tr,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Roboto'),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'select_date_due'.tr,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Roboto'),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      flag = 1;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Color(
                                                                0XFFC4C4C4)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: flag == 1
                                                            ? DEFAULT_BLUE
                                                            : Colors.white),
                                                    child: Center(
                                                      child: Text(
                                                        'today'.tr,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: 14,
                                                            color: flag == 1
                                                                ? Colors.white
                                                                : Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      flag = 2;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Color(
                                                                0XFFC4C4C4)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: flag == 2
                                                            ? DEFAULT_BLUE
                                                            : Colors.white),
                                                    child: Center(
                                                      child: Text(
                                                        '???????????????',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: flag == 2
                                                                ? Colors.white
                                                                : Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      flag = 3;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Color(
                                                                0XFFC4C4C4)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: flag == 3
                                                            ? DEFAULT_BLUE
                                                            : Colors.white),
                                                    child: Center(
                                                      child: Text(
                                                        '?????? ??? ?????????',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: flag == 3
                                                                ? Colors.white
                                                                : Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      flag = 4;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Color(
                                                                0XFFC4C4C4)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: flag == 4
                                                            ? DEFAULT_BLUE
                                                            : Colors.white),
                                                    child: Center(
                                                      child: Text(
                                                        '?????? ?????????',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: flag == 4
                                                                ? Colors.white
                                                                : Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            Color(0XFFC4C4C4)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '?????? ?????????',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  height: 40,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            Color(0XFFC4C4C4)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '????????? ????????????',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'select_type'.tr,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Roboto'),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Radio(
                                                  value: 'customer'.tr,
                                                  groupValue: 'groupValue',
                                                  onChanged: (value) {},
                                                  activeColor: Colors.blue,
                                                ),
                                                Text('????????????????????????'),
                                                Radio(
                                                  value: 'supplier'.tr,
                                                  groupValue: 'groupValue',
                                                  onChanged: (value) {},
                                                ),
                                                Text(
                                                  'supplier'.tr,
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14),
                                                ),
                                                Radio(
                                                  value: 'employee'.tr,
                                                  groupValue: 'groupValue',
                                                  onChanged: (value) {},
                                                ),
                                                Text(
                                                  'employee'.tr,
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'select_due_type'.tr,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Roboto'),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Radio(
                                                  value: '????????????????????????',
                                                  groupValue: 'groupValue',
                                                  onChanged: (value) {},
                                                  activeColor: Colors.blue,
                                                ),
                                                Text(
                                                  '????????????'.tr,
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14),
                                                ),
                                                Radio(
                                                  value: '????????????????????????',
                                                  groupValue: 'groupValue',
                                                  onChanged: (value) {},
                                                ),
                                                Text(
                                                  'give'.tr,
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                            ElevatedButton(
                                              onPressed: () {},
                                              child: Center(
                                                child: Text(
                                                  'confirm'.tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontFamily: 'Roboto'),
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary: DEFAULT_BLUE,
                                                fixedSize: Size(width, 50),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child:
                              SvgPicture.asset('images/svg_image/filter.svg'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '????????????????????????(??????)/??????????????????????????????(??????)/ ????????????????????????(??????)',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '????????????',
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            '/????????????',
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(DueDetailsCustomer());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFF1F1F1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10),
                        child: ListTile(
                          leading: Image.asset('images/assets/shirt.png'),
                          title: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              '?????? ?????? ?????????????????????????????????',
                              style: TextStyle(
                                  color: Color(0xFF232323),
                                  fontFamily: 'Roboto',
                                  fontSize: 14),
                            ),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('?????????????????????????????????',
                                  style: TextStyle(
                                      color: Color(0xFF707070),
                                      fontFamily: 'Roboto',
                                      fontSize: 14)),
                              Text('?????? ?????????????????????, ???????????? ?????????????????????',
                                  style: TextStyle(
                                      color: Color(0xFF707070),
                                      fontFamily: 'Roboto',
                                      fontSize: 14))
                            ],
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '???????????????',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontFamily: 'Roboto'),
                              ),
                              Text(
                                'customer'.tr,
                                style: TextStyle(
                                    color: Color(0xFF979797),
                                    fontSize: 12,
                                    fontFamily: 'Roboto'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(DueDetailsCustomer);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFF1F1F1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10),
                        child: ListTile(
                          leading: Image.asset('images/assets/shirt.png'),
                          title: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              '?????? ?????? ?????????????????????????????????',
                              style: TextStyle(
                                  color: Color(0xFF232323),
                                  fontFamily: 'Roboto',
                                  fontSize: 14),
                            ),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('?????????????????????????????????',
                                  style: TextStyle(
                                      color: Color(0xFF707070),
                                      fontFamily: 'Roboto',
                                      fontSize: 14)),
                              Text('?????? ?????????????????????, ???????????? ?????????????????????',
                                  style: TextStyle(
                                      color: Color(0xFF707070),
                                      fontFamily: 'Roboto',
                                      fontSize: 14))
                            ],
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '???????????????',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontFamily: 'Roboto'),
                              ),
                              Text(
                                'customer'.tr,
                                style: TextStyle(
                                    color: Color(0xFF979797),
                                    fontSize: 12,
                                    fontFamily: 'Roboto'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
