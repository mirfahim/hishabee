import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/due/customer_contact.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/due/employee_contact.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/due/supplier_contact.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/due/due_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/sms/customerDialog.dart';
import 'package:hishabee_business_manager_fl/models/due/due_item_model.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:intl/intl.dart';

int flagDate = 0;
var now = DateTime.now();
var startOfMonth = DateTime(now.year, now.month, 1);
var lastOfTheMonth = (now.month < 12)
    ? new DateTime(now.year, now.month + 1, 0)
    : new DateTime(now.year + 1, 1, 0);
bool imageChanged = false;

class DueItemEdit extends StatefulWidget {
  String dueTakerType;
  String image;
  String dueUniqId;
  // String dueType;
  int version;
  String name;
  String mobile;
  String amount;
  String details;
  String createdAt;
  String updatedAt;
  int dueLeft;
  String uniqueId;
  var dueTotalAmount;

  DueItemEdit(
      {this.dueUniqId,
        this.dueTakerType,
      this.image,
        this.uniqueId,
      this.createdAt,
        this.updatedAt,
      this.name,
      this.mobile,
      this.amount,
      this.details,
      this.version,
      this.dueLeft,this.dueTotalAmount});

  @override
  State<DueItemEdit> createState() => _DueItemEditState();
}

class _DueItemEditState extends State<DueItemEdit> {
  // File image;
  Shop shop = Get.arguments;
  DueController _dueController = Get.find();
  String _value = 'customer';
  String dueType = '';
  int dueTypeFlagGet = 0;
  int dueTypeFlagGiven = 0;
  int flag = 0;
  DateTime selectedDate;
  DateTime initialDate = DateTime.now();
  DateTime endDate;
  bool changedName = false;
  bool changedMobile = false;
  bool changedDueAmount = false;
  bool changedDescription = false;
  var changedTotalDue;
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController mobileTextEditingController = TextEditingController();
  TextEditingController dueAmountEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();

  @override
  void initState() {
    nameTextEditingController.text = widget.name;
    mobileTextEditingController.text = widget.mobile;
    dueAmountEditingController.text = widget.amount;
    // descriptionEditingController.text = widget.details;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getDialog() async {
    await _selectStartDate(context);
    // await _selectEndDate(context);
    // widgets.controller.getRangeTransaction();
  }

  _showPictureOptionDialogue() {
    try {
      if (Platform.isIOS) {
        showDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
                  title: Text("Picture option"),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          ImageHelper.getImageFromCamera().then((value) {
                            setState(() {
                              widget.image = value.path;
                              flag = 1;
                              imageChanged = true;
                            });

                            navigator.pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                  height: 80,
                                  image: AssetImage('images/icons/camera.png'),
                                ),
                                Text("Camera")
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //getImageFromGallery(option);
                          ImageHelper.getImageFromGallery().then((value) {
                            setState(() {
                              widget.image = value.path;
                              flag = 1;
                              imageChanged = true;
                            });

                            navigator.pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                  height: 80,
                                  image: AssetImage('images/icons/gallery.png'),
                                ),
                                Text("Gallery")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Close'),
                      onPressed: () {
                        navigator.pop();
                      },
                    )
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text("Picture option"),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          ImageHelper.getImageFromCamera().then((value) {
                            setState(() {
                              widget.image = value.path;
                              flag = 1;
                              imageChanged = true;
                            });

                            navigator.pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                  height: 80,
                                  image: AssetImage('images/icons/camera.png'),
                                ),
                                Text("Camera")
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //getImageFromGallery(option);
                          ImageHelper.getImageFromGallery().then((value) {
                            setState(() {
                              widget.image = value.path;
                              flag = 1;
                              imageChanged = true;
                            });

                            navigator.pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                  height: 80,
                                  image: AssetImage('images/icons/gallery.png'),
                                ),
                                Text("Gallery")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Close'),
                      onPressed: () {
                        navigator.pop();
                      },
                    )
                  ],
                ));
      }
    } catch (e) {}
  }

  _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      helpText: "start_date".tr,
      context: context,
      initialDate: initialDate,
      // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: DEFAULT_BLACK,
              onPrimary: DEFAULT_BODY_BG_COLOR,
              surface: Colors.green,
              onSurface: DEFAULT_BLACK,
            ),
            dialogBackgroundColor: DEFAULT_BODY_BG_COLOR,
          ),
          child: child,
        );
      },
    );
    if (picked != null) {
      setState(() {
        // widgets.controller.selectedStartDate.value = picked;
        flagDate = 1;
        selectedDate = picked;
        initialDate = picked;
        widget.updatedAt = DateFormat.yMMMMd().format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: bgColor,
      resizeToAvoidBottomInset: true,
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
        title: Text(
          'due_new'.tr,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  'name'.tr,
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  onChanged: (changedValue){
                    changedName = true;
                  },
                  controller: nameTextEditingController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[a-zA-Z0-9]'),
                    ),
                  ],
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (dueType == 'customer'.tr) {
                          // Future.delayed(Duration.zero, () async {
                          //   Navigator.of(context).push(PageRouteBuilder(
                          //       pageBuilder: (context, _, __) =>
                          //           CustomerContact(),
                          //       opaque: false));
                          // });
                          Get.to(CustomerContact(),arguments: shop);
                        } else if (dueType == 'supplier'.tr) {
                          // Future.delayed(Duration.zero, () async {
                          //   Navigator.of(context).push(PageRouteBuilder(
                          //       pageBuilder: (context, _, __) =>
                          //           SupplierContact(),
                          //       opaque: false));
                          // });
                          Get.to(SupplierContact(),arguments: shop);
                        } else {
                          Get.to(EmployeeContact(),arguments: shop);
                          // Future.delayed(Duration.zero, () async {
                          //   Navigator.of(context).push(PageRouteBuilder(
                          //       pageBuilder: (context, _, __) =>
                          //           EmployeeContact(),
                          //       opaque: false));
                          // });
                        }
                      },
                      icon: Icon(Icons.arrow_drop_down),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    counterText: "",
                    hintText: 'name'.tr,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black26,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'mobile'.tr,
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  onChanged: (changedValue){
                    changedMobile = true;
                  },
                  controller: mobileTextEditingController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[0-9]'),
                    ),
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    counterText: "",
                    hintText: 'mobile'.tr,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black26,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'due_amount'.tr,
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  onChanged: (changedValue){
                    setState(() {
                      changedDueAmount = true;
                    });
                  },
                  controller: dueAmountEditingController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[0-9]'),
                    ),
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    counterText: "",
                    hintText: 'due_amount'.tr,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black26,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'description'.tr,
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  onChanged: (changedValue){
                    changedDescription = true;
                  },
                  controller: descriptionEditingController,
                  maxLines: 5,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[a-zA-Z0-9]'),
                    ),
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    counterText: "",
                    hintText: 'description'.tr,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black26,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          getDialog();
                        },
                        child: Container(
                          // width: 150,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 7),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today),
                                Text('${widget.updatedAt}'),
                              ],
                            ),
                            //asdasdasd
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text('add_receipt'.tr),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              child: InkWell(
                                onTap: () {
                                  print('hello');
                                  _showPictureOptionDialogue();
                                },
                                child: (widget.image == null)
                                    ? Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Icon(Icons.camera_alt),
                                      )
                                    : Container(
                                        height: 50,
                                        width: 50,
                                        child: flag == 0
                                            ? CachedNetworkImage(
                                                imageUrl: '${widget.image}',
                                                alignment: Alignment.topLeft,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 100,
                                              )
                                            : Image.file(
                                                File(widget.image),
                                                alignment: Alignment.topLeft,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 100,
                                              ),
                                      ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: 30,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.35),
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'sms_free_20'.tr,
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        Switch(
                          activeColor: Colors.blue,
                          onChanged: (bool value) {},
                          value: true,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      if(changedDueAmount){
                        changedTotalDue = widget.dueTotalAmount - ((int.parse(widget.amount) - int.parse(dueAmountEditingController.text)));
                      }
                        _dueController.editDue(
                          amount: changedTotalDue,
                          shopId: shop.id,
                          contactType: widget.dueTakerType,
                          mobile: widget.mobile,
                          name: widget.name,
                          updatedDate: '${DateFormat.yMMMd().format(DateTime.now())}',
                          createdDate: widget.createdAt,
                          version: widget.version++,
                        );
                        _dueController.editDueItem(
                            dueUniqueId: widget.dueUniqId,
                          shopId: shop.id,
                          amount: dueAmountEditingController.text,
                          contactType: widget.dueTakerType,
                          mobile: mobileTextEditingController.text,
                          updatedDate: '${DateFormat.yMMMd().format(DateTime.now())}',
                          createdDate: widget.createdAt,
                          version: widget.version++,
                          dueLeft: widget.dueLeft,
                        );
                      _dueController
                          .getAllItemWithUniqueID(uniqueId: widget.uniqueId)
                          .then((value) {
                        _dueController.dueItemList.value = getDueItemResponseModelFromJson(value);
                      });
                      Get.back();
                      Get.back();

                    },
                    child: Center(
                      child: Text(
                        'save'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 12),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
