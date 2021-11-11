import 'package:darq/darq.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/data/remote/models/expense_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/domain/repositories/i_expense_repository.dart';

class ExpenseListController extends GetxController {
  final expenseList = <ExpenseResponseModel>[].obs;
  final filteredExpenseList = <ExpenseResponseModel>[].obs;
  final tExpense = 0.obs;

  final selectedStartDate = Rxn<DateTime>();
  final selectedEndDate = Rxn<DateTime>();
  final shop = Rxn<Shop>();

  final IExpenseRepository expenseRepository;

  ExpenseListController(this.expenseRepository);

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
    await getAllExpense();
  }

  getArguments() {
    shop.value = Get.arguments['shop'];
  }

  Future<void> getAllExpense() async {
    var list = await expenseRepository.getAllExpense(
        userId: shop.value.userId, shopId: shop.value.id);
    if (list != null) {
      expenseList.assignAll(list.orderByDescending(
          (element) => element.createdAt.microsecondsSinceEpoch));
      filteredExpenseList.assignAll(expenseList);

      calculateTotalAmount(list);
    }
  }

  getRangeExpenses() {
    final result = expenseList.where((element) {
      if (element.createdAt != null) {
        return Utility.isInRange(
            selectedStartDate.value, selectedEndDate.value, element.createdAt);
      }
      return false;
    }).toList();

    print("REx: ${result.length}");

    final res = result.orderByDescending(
        (element) => element.createdAt.microsecondsSinceEpoch);

    filteredExpenseList.assignAll(res);

    calculateTotalAmount(result);
  }

  calculateTotalAmount(List<ExpenseResponseModel> expense) {
    var totalExpense = 0;
    for (int i = 0; i < expense.length; i++) {
      totalExpense = totalExpense + expense[i].amount;
    }
    tExpense.value = totalExpense;
  }
}
