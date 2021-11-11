import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/page_background.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/page_header.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/salary_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/presentation/manager/salary_report_controller.dart';
import 'package:intl/intl.dart';

class SalaryReportPage extends GetResponsiveView<SalaryReportController> {
  @override
  Widget builder() {
    Size size = MediaQuery.of(screen.context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
              Column(
                children: [
                  buildPageHeader(
                      "salary_report".tr, controller.shop.value.name),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Container(
                      width: size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: size.width * 0.5,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: DEFAULT_BLUE,
                                    size: 30,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      onChanged: (value) {
                                        controller.searchEmployee(value);
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        hintText: "Search Employee",
                                        hintStyle: TextStyle(
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // controller.getMonth(screen.context);
                            },
                            child: Container(
                              width: size.width * 0.38,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(() => controller.selectedDate.value !=
                                          null
                                      ? Text(
                                          DateFormat("MMM yyyy").format(
                                              controller.selectedDate.value),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLUE,
                                          ),
                                        )
                                      : Text("Select Month")),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Container(
                      height: size.height,
                      child: Obx(
                        () => ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.searchList.length,
                          itemBuilder: (BuildContext context, int index) {
                            SalaryResponseModel salary =
                                controller.searchList[index];
                            return Column(
                              children: [
                                Container(
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
                                  child: ListTile(
                                    title: Text(
                                      salary.employee.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    leading: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Container(
                                            child: salary.employee.imageSrc ==
                                                    null
                                                ? Image.asset(
                                                    "images/icons/profile_placeholder.png")
                                                : Container(
                                                    height: 50,
                                                    width: 50,
                                                    child: Image.network(
                                                      salary.employee.imageSrc,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )),
                                      ),
                                    ),
                                    subtitle: Text(
                                      salary.employee.position,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    trailing:
                                        salary.employee.monthlySalary != null
                                            ? Text(
                                                "${salary.employee.monthlySalary}",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : Text(
                                                "-",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
