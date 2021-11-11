import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/image_helper.dart';
import 'package:hishabee_business_manager_fl/app/modules/nid_verification/presentation/manager/nid_verification_page_controller.dart';

class NidVerificationPage extends GetView<NidVerificationController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: DEFAULT_YELLOW_BG,
        title: Text(
          "NID Verification",
          style: TextStyle(color: DEFAULT_BLACK, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "NID Number",
                    style: TextStyle(
                      fontSize: 16,
                      color: DEFAULT_BLACK,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: TextFormField(
                      cursorColor: DEFAULT_BLACK,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp('[0-9]'),
                        ),
                      ],
                      maxLength: 20,
                      onChanged: (value) {
                        controller.nidNumber.value = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        border: InputBorder.none,
                        counterText: "",
                        hintText: 'NID Number',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w100,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "NID Image (Front Side)",
                    style: TextStyle(
                      fontSize: 16,
                      color: DEFAULT_BLACK,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {
                      _showPictureOptionDialogueFront(controller, context);
                    },
                    child: Container(
                      height: 130,
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: DEFAULT_BLACK)),
                      child: Stack(
                        children: [
                          Obx(
                            () => controller.nidFront.value == null
                                ? Container()
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.file(
                                      controller.nidFront.value,
                                      height: 130,
                                      width: size.width,
                                    ),
                                  ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  size: 35,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Front Side of NID",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: DEFAULT_BLACK,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "NID Image (Back Side)",
                    style: TextStyle(
                      fontSize: 16,
                      color: DEFAULT_BLACK,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {
                      _showPictureOptionDialogueBack(controller, context);
                    },
                    child: Container(
                      height: 130,
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: DEFAULT_BLACK)),
                      child: Stack(
                        children: [
                          Obx(
                            () => controller.nidBack.value == null
                                ? Container()
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.file(
                                      controller.nidBack.value,
                                      height: 130,
                                      width: size.width,
                                    ),
                                  ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  size: 35,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Back Side of NID",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: DEFAULT_BLACK,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: DEFAULT_BLACK),
                    onPressed: () {
                      controller.verifyNid();
                    },
                    child: Container(
                      height: 40,
                      width: size.width,
                      child: Center(
                        child: Text(
                          "save".tr,
                          style: TextStyle(color: Colors.white, fontSize: 16),
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
    );
  }

  _showPictureOptionDialogueFront(
      NidVerificationController controller, BuildContext context) {
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
                        controller.nidFront.value = value;
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
                        controller.nidFront.value = value;
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

  _showPictureOptionDialogueBack(
      NidVerificationController controller, BuildContext context) {
    final NidVerificationController controller = Get.find();
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
                        controller.nidBack.value = value;
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
                        controller.nidBack.value = value;
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
}
