import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/local/data_sources/local_expense_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/data_sources/expense_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/repositories/expense_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/domain/repositories/i_expense_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/report/presentation/manager/report_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/local/data_sources/local_transaction_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/data_sources/transaction_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/repositories/transaction_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/domain/repositories/i_transaction_repository.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ILocalTransactionProvider>(() => LocalTransactionProvider());
    Get.lazyPut<ITransactionProvider>(() => TransactionProvider(Get.find()));
    Get.lazyPut<ITransactionRepository>(
        () => TransactionRepository(Get.find(), Get.find(), Get.find()));

    Get.lazyPut<ILocalTransactionProvider>(() => LocalTransactionProvider());
    Get.lazyPut<IExpenseProvider>(() => ExpenseProvider(Get.find()));
    Get.lazyPut<ILocalExpenseProvider>(() => LocalExpenseProvider());
    Get.lazyPut<IExpenseRepository>(
        () => ExpenseRepository(Get.find(), Get.find(), Get.find()));

    Get.lazyPut(() => ReportController(Get.find(), Get.find()));
  }
}
