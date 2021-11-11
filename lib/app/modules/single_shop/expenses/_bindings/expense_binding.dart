import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/local/data_sources/local_contact_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/remote/data_sources/contact_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/data/repositories/contact_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/domain/repositories/i_contact_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/local/data_sources/local_expense_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/data_sources/expense_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/repositories/expense_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/domain/repositories/i_expense_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/presentation/manager/add_expense_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/presentation/manager/expense_list_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/presentation/manager/expense_page_controller.dart';

class ExpenseBinding extends Bindings {
  static final find = Get.find;

  @override
  void dependencies() {
    Get.lazyPut<IExpenseProvider>(() => ExpenseProvider(find()));
    Get.lazyPut<ILocalExpenseProvider>(() => LocalExpenseProvider());
    Get.lazyPut<IExpenseRepository>(
        () => ExpenseRepository(find(), find(), find()));

    Get.lazyPut<ILocalContactProvider>(() => LocalContactProvider());
    Get.lazyPut<IContactProvider>(() => ContactProvider(find()));
    Get.lazyPut<IContactRepository>(
        () => ContactRepository(find(), find(), find()));

    Get.lazyPut(() => AddExpenseController(find(), find()));
    Get.lazyPut(() => ExpenseListController(find()));
    Get.lazyPut(() => ExpensePageController());
  }
}
