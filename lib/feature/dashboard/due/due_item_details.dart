import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/due/due_controller.dart';
import 'package:hishabee_business_manager_fl/models/due/due_item_model.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'single_due_item_details.dart';

class DueDetailsCustomer extends StatefulWidget {
  String name;
  String mobileNumber;
  var dueTotalAmount;
  String uniqueId;

  DueDetailsCustomer(
      {this.name, this.mobileNumber, this.dueTotalAmount, this.uniqueId});

  @override
  State<DueDetailsCustomer> createState() => _DueDetailsCustomerState();
}

class _DueDetailsCustomerState extends State<DueDetailsCustomer> {
  DueController _dueController = Get.find();
  Shop shop = Get.arguments;

  @override
  void initState() {
    _dueController
        .getAllItemWithUniqueID(uniqueId: widget.uniqueId)
        .then((value) {
      _dueController.dueItemList.value = getDueItemResponseModelFromJson(value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomSheet: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'given/due'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'get/profit'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
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
              'due_details'.tr,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: Container(
          height: height,
          color: DEFAULT_BODY_BG_COLOR,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 20),
            child: Column(
              children: [
                Container(
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: DEFAULT_BLUE,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.name}',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.mobileNumber}',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    var url = 'tel:${widget.mobileNumber}';
                                    launch(url);
                                  },
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(
                                    Icons.call,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(
                                    Icons.message,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'total_due:'.tr,
                                  style: TextStyle(
                                      color: Colors.amber, fontSize: 14),
                                ),
                                Text(
                                  ' ${widget.dueTotalAmount}৳',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'due_reminder:'.tr,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            Row(
                              children: [
                                Text(
                                  'select_date'.tr,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                IconButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {},
                                  icon: Icon(Icons.calendar_today, color: Colors.white,),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'due_history'.tr,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Row(
                      children: [
                        Text(
                          'due /'.tr,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                        Text(
                          'saving'.tr,
                          style: TextStyle(color: Colors.green, fontSize: 14),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Expanded(
                    child: ListView.builder(
                        itemCount: _dueController.dueItemList.length,
                        itemBuilder: (context, index) {
                          return _dueController.dueItemList[index].version <0 ? Container(): InkWell(
                            onTap: (){
                              Get.to(SingleDueDetails(
                                transactionUniqueId: _dueController.dueItemList[index].transactionUniqueId,
                                dueTotalAmount: widget.dueTotalAmount,
                                dueLeft: _dueController.dueItemList[index].dueLeft,
                                dueUniqueId: widget.uniqueId,
                                amount: _dueController.dueItemList[index].amount,
                                description:_dueController.dueItemList[index].note == null ? 'not_given'.tr : _dueController.dueItemList[index].note,
                                // date: DateFormat.yMMMMd().format(_dueController.dueItemList[index].createdAt),
                                image: _dueController.dueItemList[index].image,
                                createdAt: DateFormat.yMMMMd().format(_dueController.dueItemList[index].createdAt),
                                updatedAt: DateFormat.yMMMMd().format(_dueController.dueItemList[index].updatedAt),
                                uniqueId: _dueController.dueItemList[index].uniqueId,
                                dueTakerType: _dueController.dueItemList[index].contactType,
                                name: _dueController.dueItemList[index].contactName,
                                mobile: _dueController.dueItemList[index].contactMobile,
                                version: _dueController.dueItemList[index].version,
                              ), arguments: shop);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF1F1F1),
                                  borderRadius: BorderRadius.circular(6)
                                ),
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                        '${DateFormat.yMMMd().format(_dueController.dueItemList[index].updatedAt)}'),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0, top: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${DateFormat.Hm().format(_dueController.dueItemList[index].createdAt)}'),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: Text('due_left:'.tr +
                                              '৳${_dueController.dueItemList[index].dueLeft}', style: TextStyle(
                                            color: _dueController.dueItemList[index].dueLeft< 0 ? Colors.green : Colors.red,
                                            fontWeight: FontWeight.w500
                                          ),),
                                        )
                                      ],
                                    ),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Text(
                                      '৳${_dueController.dueItemList[index].amount}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.red, fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
