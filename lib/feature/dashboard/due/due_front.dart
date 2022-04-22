import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/due/due_controller.dart';
import 'package:hishabee_business_manager_fl/models/due/due_model.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:intl/intl.dart';

import 'due_history.dart';
import 'due_item_details.dart';
import 'due_new_add.dart';
// import 'package:pinverification/constants/constants.dart';
// import 'package:pinverification/due/due_details_customer.dart';
// import 'package:pinverification/due/due_new.dart';
// import 'package:pinverification/due/due_new_credit.dart';
// import 'package:pinverification/due/due_new_textfield.dart';

// import 'due_history_edit_delete.dart';

class DueFront extends StatefulWidget {

  @override
  State<DueFront> createState() => _DueFrontState();
}

class _DueFrontState extends State<DueFront> {

  DueController _dueController = Get.put(DueController());
  Shop shop = Get.arguments;

  @override
  void initState() {
    _dueController.getAllDue(shopId: shop.id).then((value){
      if(value != null){
        // _dueController.dueList.value = getAllDueResponseModelFromJson(value);
        _dueController.filterList.value = getAllDueResponseModelFromJson(value['data']);
        for(int i = 0; i<_dueController.filterList.length; i++){
          if(_dueController.filterList[i].dueAmount < 0){
            _dueController.payDue.value = _dueController.filterList
                .map((e) => e.dueAmount)
                .fold(0, (previousValue, element) => previousValue + element);
          }else if(_dueController.filterList[i].dueAmount > 0){
            _dueController.takeDue.value = _dueController.filterList
                .map((e) => e.dueAmount)
                .fold(0, (previousValue, element) => previousValue + element);
          }

          if('${_dueController.filterList[i].contactType}' == 'ContactType.CUSTOMER' && _dueController.filterList[i].version > 0){
            _dueController.customerCount.value++;
          }else if('${_dueController.filterList[i].contactType}' == 'ContactType.SELLER' && _dueController.filterList[i].version > 0){
            _dueController.supplierCount.value++;
          }else if('${_dueController.filterList[i].contactType}' == 'ContactType.EMPLOYEE' && _dueController.filterList[i].version > 0){
            _dueController.employeeCount.value++;
          }
        }
      }
    });
    print('due filterList ${_dueController.filterList}');
    super.initState();
  }

  @override
  void dispose() {
    _dueController.customerCount.value = 0;
    _dueController.supplierCount.value = 0;
    _dueController.employeeCount.value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        child: GestureDetector(
          onTap: (){
            Get.to(DueNew(), arguments: shop);
          },
          child: Container(
            width: width,
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
      ),
      backgroundColor: bgColor,
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Column(
          children: [
            Text(
              'due_list'.tr,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: height,
            color: DEFAULT_BODY_BG_COLOR,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 5),
              child: Column(
                children: [
                  Container(
                    // height: height - 500,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: DEFAULT_BLUE,
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        Text(
                          'total_due',
                          style: TextStyle(color: Colors.amber, fontSize: 14),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     IconButton(
                        //       icon: Icon(
                        //         Icons.arrow_back_ios,
                        //         color: Colors.white,
                        //       ),
                        //       onPressed: () {},
                        //     ),
                        //     Text('১৯ অক্টবার, ২০২১'),
                        //     IconButton(
                        //       icon: Icon(
                        //         Icons.arrow_forward_ios,
                        //         color: Colors.white,
                        //       ),
                        //       onPressed: () {},
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 60,
                              width: width / 2.5,
                              decoration: BoxDecoration(
                                color: Color(0xFFC4C4C4).withOpacity(.35),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Obx(()=>Text('${_dueController.payDue.value}', style: TextStyle(color: Colors.white),),),
                                    Text('lend'.tr, style: TextStyle(color: Colors.white),)
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 60,
                              width: width / 2.5,
                              decoration: BoxDecoration(
                                color: Color(0xFFC4C4C4).withOpacity(.35),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Obx(()=>Text('${_dueController.takeDue.value}', style: TextStyle(color: Colors.white),),),

                                    Text('borrowed'.tr, style: TextStyle(color: Colors.white),)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: (){
                            Get.to(DueHistory(), arguments: shop);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.history, color: Colors.white,),
                                Text('due_history'.tr, style: TextStyle(
                                    color: Colors.white
                                ),)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        // flex: 9,
                        child: TextFormField(
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9]'),
                            ),
                          ],
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6)),
                            counterText: "",
                            hintText: 'নাম বা মোবাইল নম্বর দিয়ে অনুসন্ধান করুন',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black26,
                            ),
                          ),
                        ),
                      ),
                      // Expanded(
                      //   child: IconButton(
                      //     onPressed: () {},
                      //     icon: Icon(Icons.menu),
                      //   ),
                      // )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(()=>
                          Text(
                            'কাস্টমার(${_dueController.customerCount.value})'
                                '/সাপ্লাইয়ার(${_dueController.supplierCount})/'
                                ' কর্মচারী(${_dueController.employeeCount})',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                      ),

                      Row(
                        children: [
                          Text(
                            'পাবো',
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            '/দিবো',
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
                  Obx(()=> Expanded(
                    child: ListView.builder(
                      itemCount: _dueController.filterList.length,
                        itemBuilder: (context, index){
                        // if('${_dueController.filterList[index].contactType}' == 'ContactType.CUSTOMER'){
                        //   _dueController.customerCount.value++;
                        // }else if(_dueController.filterList[index].contactType == 'ContactType.SELLER'){
                        //   _dueController.supplierCount.value++;
                        // }else if(_dueController.filterList[index].contactType == 'ContactType.EMPLOYEE'){
                        //   _dueController.employeeCount.value++;
                        // }
                        return _dueController.filterList[index].version < 0 ? Container():
                        GestureDetector(
                          onTap: (){
                            Get.to(
                                DueDetailsCustomer(
                                  name: _dueController.filterList[index].contactName,
                                  mobileNumber: _dueController.filterList[index].contactMobile,
                                  dueTotalAmount: _dueController.filterList[index].dueAmount,
                                  uniqueId: _dueController.filterList[index].uniqueId,
                                ),
                                arguments: shop);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFF1F1F1),
                                    borderRadius: BorderRadius.circular(6)
                                ),
                              child: ListTile(
                                leading: Image.asset('images/assets/emptyImage.png'),
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text('${_dueController.filterList[index].contactName}'),
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${_dueController.filterList[index].contactMobile}'),
                                    Text('${DateFormat.yMMMd().format(_dueController.filterList[index].createdAt)}')
                                  ],
                                ),
                                trailing: Column(
                                  children: [
                                    Text(
                                      '${_dueController.filterList[index].dueAmount}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: _dueController.filterList[index].dueAmount< 0 ? Colors.green : Colors.red),
                                    ),
                                    Text('${_dueController.filterList[index].contactType}'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                        }
                    ),
                  )),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   width: width,
                  //   height: height / 7,
                  //   decoration: BoxDecoration(
                  //       color: Colors.grey.withOpacity(.35),
                  //       borderRadius: BorderRadius.circular(10)),
                  //   child: ListTile(
                  //     leading: Image.asset('images/sharukh2.jpeg'),
                  //     title: Padding(
                  //       padding: const EdgeInsets.only(top: 8.0),
                  //       child: Text('এস এম আলিউজ্জামান'),
                  //     ),
                  //     subtitle: Column(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text('০১৭৮৮৬৫১৭৭৮'),
                  //         Text('২৭ নভেম্বর, ২০২১ পর্যন্ত')
                  //       ],
                  //     ),
                  //     trailing: Column(
                  //       children: [
                  //         Text(
                  //           '১০৯৯টাকা',
                  //           style: TextStyle(color: Colors.green),
                  //         ),
                  //         Text('কাস্টমার'),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Get.to(DueNewTextField());
                  //   },
                  //   child: Center(
                  //     child: Text(
                  //       'Enter',
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(color: Colors.white, fontSize: 12),
                  //     ),
                  //   ),
                  //   style: ElevatedButton.styleFrom(
                  //     primary: DEFAULT_BLUE,
                  //     fixedSize: Size(width, 50),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
