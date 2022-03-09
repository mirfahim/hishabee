import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:intl/intl.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/_binding/contact_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/contact_type_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/customer_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/pages/add_contact_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/_bindings/due_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/add_due_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/presentation/manager/due_list_controller.dart';
import 'due_list_page.dart';

class AddDuePage extends StatefulWidget {
  @override
  _AddDuePageState createState() => _AddDuePageState();
}

class _AddDuePageState extends State<AddDuePage> {
  final formKey = GlobalKey<FormState>();
  String radioVal;
  bool selection;
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AddDueController controller =
      Get.find<AddDueController>(); //Get.find<TaskController>();

  @override
  void initState() {
    super.initState();

    var androidInitilize = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSinitilize = IOSInitializationSettings();
    // var initilizationsSettings =
    //     InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
    // notificationsPlugin = FlutterLocalNotificationsPlugin();
    // notificationsPlugin.initialize(initilizationsSettings,
    //     onSelectNotification: notificationSelected);
  }

  Future _showNotification(String task) async {
    var androidDetails = AndroidNotificationDetails(
      "Hishabee-channel",
      "Hishabee Notification",
      // "This channel is used for Hishabee Notification.",
      importance: Importance.max,
      playSound: true,
      icon: "@mipmap/ic_launcher",
      //sound: RawResourceAndroidNotificationSound("notify"),
    );
    var iSODetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iSODetails);

    var scheduledTime = DateTime.now().add(Duration(
        days: controller.differenceOfDay.value,
        hours: controller.differenceOfHour.value,
        minutes: controller.differenceOfMinute.value));

    notificationsPlugin.schedule(
        1, "Due Reminder", task, scheduledTime, generalNotificationDetails);
    Fluttertoast.showToast(
        msg:
            "You will get a reminder after ${controller.differenceOfDay.value} day ${controller.differenceOfHour.value} Hour");
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: DEFAULT_BODY_BG_COLOR,
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
            'new_due'.tr,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          backgroundColor: Colors.amber,
        ),
        body: Obx(() => !controller.isLoading.value
            ? SafeArea(
                child: Stack(
                  children: [
                    Obx(
                      () => Form(
                        key: formKey,
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'select_type'.tr,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Roboto'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Radio(
                                        value: 'কাস্টমার',
                                        groupValue: 'groupValue',
                                        onChanged: (value) {
                                          setState(() {
                                            radioVal = value;
                                            print("radiovalue is $value");
                                          });
                                        },
                                        activeColor: Colors.blue),
                                    Text(
                                      'customer'.tr,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          color: Color(0xFF232323)),
                                    ),
                                    Radio(
                                      value: 'কাস্টমার',
                                      groupValue: 'groupValue',
                                      onChanged: (value) {},
                                    ),
                                    Text(
                                      'supplier'.tr,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          color: Color(0xFF232323)),
                                    ),
                                    Radio(
                                      value: 'কাস্টমার',
                                      groupValue: 'groupValue',
                                      onChanged: (value) {},
                                    ),
                                    Text(
                                      'employee'.tr,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          color: Color(0xFF232323)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'select_due_type'.tr,
                                  style: TextStyle(
                                      color: Color(0xFF232323),
                                      fontSize: 16,
                                      fontFamily: 'Roboto '),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            selection = false;
                                          });
                                        },
                                        child: Center(
                                          child: Text(
                                            '৳receive/taken'.tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: selection == false
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 16,
                                                fontFamily: 'Roboto'),
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: selection == false
                                              ? DEFAULT_BLUE
                                              : Colors.white,
                                          fixedSize: Size(width, 50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            selection = true;
                                            print("my selection is $selection");
                                          });
                                        },
                                        child: Center(
                                          child: Text(
                                            '৳given/due'.tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: selection == true
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 16,
                                                fontFamily: 'Roboto'),
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: selection == true
                                              ? Colors.blue
                                              : Colors.white,
                                          fixedSize: Size(width, 50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 10, right: 10),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Container(
                                          width: size.width * 0.2,
                                          child: Text(
                                            "name".tr,
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: DEFAULT_BLACK,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: VerticalDivider(
                                          thickness: 0.6,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                      controller.due.value != null
                                          ? InkWell(
                                              onTap: () {
                                                selectCustomerDialog(
                                                    context, controller);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Container(
                                                  width: size.width * 0.6,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        width:
                                                            (size.width * 0.52),
                                                        child: Obx(
                                                          () => TextFormField(
                                                            initialValue: controller
                                                                        .due
                                                                        .value !=
                                                                    null
                                                                ? controller
                                                                    .due
                                                                    .value
                                                                    .contactName
                                                                : "Select Customer",
                                                            onSaved: (value) {
                                                              controller.name
                                                                      .value =
                                                                  value;
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              hintText: controller
                                                                          .selectedCustomer
                                                                          .value ==
                                                                      null
                                                                  ? "Customer Name"
                                                                  : controller
                                                                      .selectedCustomer
                                                                      .value
                                                                      .name,
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontFamily:
                                                                    'Rubik',
                                                                color: Colors
                                                                    .blueGrey,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: Icon(
                                                        Icons
                                                            .arrow_drop_down_sharp,
                                                        size: 40,
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                selectCustomerDialog(
                                                    context, controller);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Container(
                                                  width: size.width * 0.6,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width:
                                                            (size.width * 0.52),
                                                        child: Obx(
                                                          () => TextFormField(
                                                            cursorColor:
                                                                DEFAULT_BLACK,
                                                            onSaved: (value) {
                                                              controller.name
                                                                      .value =
                                                                  value;
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              hintText: controller
                                                                          .selectedCustomer
                                                                          .value ==
                                                                      null
                                                                  ? "Customer Name"
                                                                  : controller
                                                                      .selectedCustomer
                                                                      .value
                                                                      .name,
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontFamily:
                                                                    'Rubik',
                                                                color: Colors
                                                                    .blueGrey,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: Icon(
                                                        Icons
                                                            .arrow_drop_down_sharp,
                                                        size: 40,
                                                      )),
                                                    ],
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
                                    top: 10.0, left: 10, right: 10),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Container(
                                          width: size.width * 0.2,
                                          child: Text(
                                            "mobile".tr,
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.normal,
                                              color: DEFAULT_BLACK,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: VerticalDivider(
                                          thickness: 0.6,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                      Obx(
                                        () => Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Container(
                                            width: size.width / 2,
                                            child: TextFormField(
                                              cursorColor: DEFAULT_BLACK,
                                              initialValue:
                                                  controller.due.value != null
                                                      ? controller.due.value
                                                          .contactMobile
                                                      : "",
                                              onSaved: (value) {
                                                controller.phoneNumber.value =
                                                    value;
                                              },
                                              maxLength: 11,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              decoration: InputDecoration(
                                                counterText: "",
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                hintText: controller
                                                            .selectedCustomer
                                                            .value ==
                                                        null
                                                    ? "Customer Mobile"
                                                    : controller
                                                        .selectedCustomer
                                                        .value
                                                        .mobile,
                                                hintStyle: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  color: Colors.blueGrey,
                                                ),
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
                                    top: 10.0, left: 10, right: 10),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Container(
                                          width: size.width * 0.2,
                                          child: Text(
                                            "description".tr,
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: DEFAULT_BLACK,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: VerticalDivider(
                                          thickness: 0.6,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Container(
                                          width: size.width / 2,
                                          child: Obx(
                                            () => TextFormField(
                                              cursorColor: DEFAULT_BLACK,
                                              initialValue:
                                                  controller.due.value != null
                                                      ? controller
                                                          .due.value.contactName
                                                      : " nothing",
                                              onSaved: (value) {
                                                controller.address.value =
                                                    value;
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                hintText: controller
                                                            .selectedCustomer
                                                            .value ==
                                                        null
                                                    ? "Customer Address"
                                                    : controller
                                                        .selectedCustomer
                                                        .value
                                                        .address,
                                                hintStyle: TextStyle(
                                                  color: Colors.blueGrey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10.0,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Text(
                                  "due_amount".tr,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: DEFAULT_BLACK,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 10, right: 10),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextFormField(
                                      cursorColor: DEFAULT_BLACK,
                                      onSaved: (value) {
                                        if (value.length != 0) {
                                          controller.amount.value =
                                              int.parse(value);
                                        } else {
                                          controller.amount.value = 0;
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        hintText: "Due Amount",
                                        hintStyle: TextStyle(
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0, left: 10, right: 10),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await controller
                                                .selectDate(context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                      Icons.more_time_outlined),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Obx(() => Text(controller
                                                              .reDate.value ==
                                                          null
                                                      ? ""
                                                      : DateFormat('yyyy-MM-dd')
                                                          .format(controller
                                                              .reDate.value))),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showPictureOptionDialogue(context);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            border: Border.all(
                                                color: Color(0xFFC4C4C4)
                                                    .withOpacity(.35))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  'images/svg_image/receipt_add.svg'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              controller.image.value == null
                                                  ? Text('রিসিপ্ট যুক্ত করুন')
                                                  : Text("image Added"),
                                            ],
                                          ),
                                        )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 05,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 60,
                                  left: 10.0,
                                  right: 10,
                                ),
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: DEFAULT_BLACK),
                                    onPressed: () {
                                      addDue(context, controller);
                                      _showNotification(
                                          "You have a Due reminder");
                                    },
                                    child: Text(
                                      "save".tr,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: size.height,
                width: size.width,
              )),
      ),
    );
  }

  // Future notificationSelected(
  //   String payload,
  // ) async {
  //   Get.to(() => DueListPage(),
  //       arguments: {
  //         "shop": controller.shop.value,
  //       },
  //       binding: DueListBinding());
  // }
  showPictureOptionDialogue(BuildContext context) {
    //   final AddProductController controller = Get.find();
    Get.dialog(
      Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  ImageHelper.getImageFromCamera().then((value) {
                    controller.image.value = value;
                    print(
                        "image path is +++++++++++++ ${controller.image.value.path}");

                    navigator.pop();
                  });
                },
                child: Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: Image(
                            height: 80,
                            image: AssetImage('images/icons/camera.png'),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Camera",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //getImageFromGallery(option);
                  ImageHelper.getImageFromGallery().then((value) {
                    controller.image.value = value;

                    navigator.pop();
                  });
                },
                child: Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: Image(
                            height: 80,
                            image: AssetImage('images/icons/gallery.png'),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Gallery",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        )
                      ],
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

  addDue(BuildContext context, AddDueController controller) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (controller.amount.value == 0) {
        CustomDialog.showStringDialog("Please Enter Amount");
      } else {
        await controller.addDue();
        // final DueListController dueListController = Get.find();
        //  await dueListController.getAllDue();
        CustomDialog.showDialogAddProductDialog(
            controller.addDueResponse.value.message);

        //  Get.to(() => DueListPage(), binding: DueListBinding());
      }
    }
  }

  selectCustomerDialog(BuildContext context, AddDueController controller) {
    showDialog(
      context: context,
      builder: (_) => KeyboardAwareDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                left: 10,
              ),
              child: Text(
                "Customer List",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: DEFAULT_BLACK,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
                      onChanged: (value) {
                        controller.searchCustomer(value);
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: controller.searchCustomerList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.selectedCustomer.value =
                                  controller.searchCustomerList[index];
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                () => Text(
                                  "${controller.searchCustomerList[index].name} ( ${controller.searchCustomerList[index].mobile} )",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      child: TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "close".tr,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      margin: EdgeInsets.all(8),
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: DEFAULT_BLACK,
                      ),
                      child: TextButton(
                          onPressed: () {
                            Customer customer = new Customer();
                            Get.to(() => AddContactPage(),
                                arguments: {
                                  'shop': controller.shop.value,
                                  "type": ContactType.CUSTOMER,
                                  "contact": customer,
                                },
                                binding: ContactBinding());
                          },
                          child: Center(
                            child: Text(
                              "add_new_customer".tr,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
