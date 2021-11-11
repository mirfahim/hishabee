import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/models/employee_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/repositories/salary_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_contact_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/models/expense_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/models/request/salary_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/models/response/salary_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/domain/repositories/i_expense_repository.dart';

class AddExpenseController extends GetxController {
  final IContactRepository contactRepository;
  final IExpenseRepository expenseRepository;

  final result = Rxn<GenericResponseModel>();
  final salaryResponse = Rxn<PaySalaryResponse>();
  final shop = Rxn<Shop>();
  final employeeList = <Employee>[].obs;
  final searchEmployeeList = <Employee>[].obs;

  final selectedEmployee = Rxn<Employee>();
  final selectedMonth = Rxn<DateTime>();
  final month = "--Select Month--".obs;

  final amount = 0.obs;
  final details = "".obs;
  final purpose = "".obs;
  final paying = false.obs;
  final salaryFormKey = GlobalKey<FormState>();

  final billFormKey = GlobalKey<FormState>();
  final inventoryFormKey = GlobalKey<FormState>();
  final rentFormKey = GlobalKey<FormState>();
  final otherFormKey = GlobalKey<FormState>();

  AddExpenseController(this.expenseRepository, this.contactRepository);

  @override
  void onInit() async {
    getArguments();
    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getAllEmployee();
    searchEmployeeList.assignAll(employeeList);
  }

  getArguments() {
    shop.value = Get.arguments['shop'];
  }

  Future<void> addExpense(String type) async {
    CustomDialog.showLoadingDialog(message: "Adding expense");
    paying.value = true;
    result.value = await expenseRepository.addExpense(
        ExpenseResponseModel(
          shopId: shop.value.id,
          purpose: purpose.value,
          details: details.value,
          amount: amount.value,
        ),
        type);
    CustomDialog.hideDialog();
    paying.value = false;
  }

  addNewSalary() async {
    paying.value = true;
    CustomDialog.showLoadingDialog(message: "Paying Salary");
    PaySalaryRequest salaryRequest = new PaySalaryRequest(
        shopId: shop.value.id,
        amount: amount.value,
        employeeId: selectedEmployee.value.id,
        time: DateTime.now(),
        details: details.value);
    salaryResponse.value = await expenseRepository.addNewSalary(salaryRequest);
    paying.value = false;
    CustomDialog.hideDialog();
    if (salaryResponse.value.code == 200) {
      CustomDialog.showStringDialog("${salaryResponse.value.message}");
    } else {
      CustomDialog.showStringDialog("${salaryResponse.value.message}");
    }
  }

  Future getAllEmployee() async {
    final result =
        await contactRepository.getAllEmployee(shopId: shop.value.id);

    employeeList.assignAll(result);
  }

  Future<void> searchEmployee(String searchEmployeeName) async {
    if (searchEmployeeName.isNotEmpty) {
      final result = employeeList
          .where((Employee em) =>
              em.name.toLowerCase().contains(searchEmployeeName.toLowerCase()))
          .toList();
      searchEmployeeList.assignAll(result);
    } else {
      searchEmployeeList.assignAll(employeeList);
    }
  }
}
