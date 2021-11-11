import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/nid_verification/_bindings/nid_verification_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/nid_verification/presentation/pages/nid_verification_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/presentation/manager/notification_controller.dart';
import 'package:intl/intl.dart';

class NotificationPage extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: size.height * 0.2,
              width: size.width,
              child: Image.asset(
                "images/topBg.png",
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
                top: 20,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: DEFAULT_BLACK,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
                left: 50,
                top: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'notification'.tr,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: DEFAULT_BLACK,
                    ),
                  ),
                  FlatButton(
                    color: Colors.red,
                    onPressed: () {
                      controller.clearAll();
                    },
                    child: Row(
                      children: [
                        Text(
                          "Clear All",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 70.0,
                left: 10,
              ),
              child: Text(
                controller.shop.value.name,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: DEFAULT_BLACK,
                ),
              ),
            ),
            Obx(() => controller.creds.value == null
                ? Container()
                : controller.creds.value.user.nidVerified == 0
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 100),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => NidVerificationPage(),
                                binding: NidVerificationBinding());
                          },
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: DEFAULT_BLACK,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Your NID is not verified",
                                    style: TextStyle(
                                        color: DEFAULT_YELLOW_BG, fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Click hare to verify your NID",
                                    style: TextStyle(
                                        color: DEFAULT_YELLOW_BG, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container()),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 200,
              ),
              child: Obx(
                () => MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    //physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.notificationList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = controller.notificationList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          height: 90,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image(
                                  width: MediaQuery.of(context).size.width / 7,
                                  image: AssetImage('images/defaultLogo.png'),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    item.title,
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.bold,
                                      color: DEFAULT_BLUE,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: size.width * 0.7,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            item.details,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          DateFormat("hh:m a MMM yyyy")
                                              .format(item.time),
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  isThreeLine: true,
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(
                                  0,
                                  2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ), //generateNotifications(),
            )
          ],
        ),
      ),
    );
  }

/*Widget generateNotifications() {
    return ListView.builder(
      itemCount: notificationCollection.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            height: 90,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    width: MediaQuery.of(context).size.width / 7,
                    image: AssetImage('images/defaultLogo.png'),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      notificationCollection[index].title,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        color: default_blue,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            notificationCollection[index].details,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            notificationCollection[index].time,
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              color: Colors.black38,
                            ),
                          ),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(
                    0,
                    2,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }*/

/*getNotificationsData() async {
    String url = "$domain/notification/all?shop_id=${widget.shop.id}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    var client = new http.Client();
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      List<dynamic> data = jsonDecode(response.body);
      notificationCollection = [];
      for (dynamic notification in data) {
        NotificationModel notificationModel =
            NotificationModel.fromJson(notification);
        // print(notificationModel.title);
        notificationCollection.add(notificationModel);
      }
      setState(() {
        loading = false;
      });
    } finally {
      client.close();
    }
  }*/
}
