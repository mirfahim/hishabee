import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/salary_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_salary_repository.dart';
// import 'package:month_picker_dialog/month_picker_dialog.dart';

class SalaryReportController extends GetxController {
  final shop = Rxn<Shop>();
  final selectedDate = Rxn<DateTime>();
  final salaryList = <SalaryResponseModel>[].obs;
  final searchList = <SalaryResponseModel>[].obs;
  final ISalaryRepository salaryRepository;
  SalaryReportController(this.salaryRepository);

  @override
  void onInit() async {
    getArguments();
    selectedDate.value = DateTime.now();
    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getAllSalary();
  }

  getArguments() {
    shop.value = Get.arguments['shop'];
  }

  // void getMonth(BuildContext context) {
  //   showMonthPicker(
  //     context: context,
  //     firstDate: DateTime(DateTime.now().year - 10, 5),
  //     lastDate: DateTime(DateTime.now().year + 10, 9),
  //     initialDate: DateTime.now(),
  //     //locale: Locale("es"),
  //   ).then((date) {
  //     if (date != null) {
  //       selectedDate.value = date;
  //     }
  //   });
  // }

  Future<void> getAllSalary() async {
    final result = await salaryRepository.getAllSalary(shopId: shop.value.id);
    salaryList.assignAll(result);
    searchList.assignAll(result);
  }

  Future<void> searchEmployee(String employeeName) async {
    final result = salaryList
        .where((SalaryResponseModel s) =>
            s.employee.name.toLowerCase().contains(employeeName.toLowerCase()))
        .toList();
    searchList.assignAll(result);
  }
}
