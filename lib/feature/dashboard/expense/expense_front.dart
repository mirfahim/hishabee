import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/expense/pay_salary_page.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_category.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_model.dart';
import 'package:hishabee_business_manager_fl/new_UI/constants/constant_values.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'expense_details.dart';
import 'expense_types.dart';
import 'all_expenses.dart';

var now = DateTime.now();

class ExpenseList extends StatefulWidget {
  // Shop shop;
  // ExpenseList({this.shop});
  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  ExpenseController _expenseController = Get.put(ExpenseController());
  Shop shop = Get.arguments;
  List<ExpenseResponseModel> _expenseList;
  List<ExpenseCategoryResponseModel> _expenseCatergoryList;
  bool _isLoading = true;
  int listCount = 6;

  // int totalExpense = 0;
  var getShopId = GetStorage('shop_id');

  @override
  void initState() {
    print('shop id: ${getShopId.read('shop_id')}');
    // print('user id: ${shop.userId}');
    _expenseController
        .getAllExpense(
            shopId: '${getShopId.read('shop_id')}', userId: '${shop.userId}')
        .then((value) {
      setState(() {
        _expenseList = getExpenseFromModel(value);
        _expenseController.allExpenseList.value = getExpenseFromModel(value);
        _expenseController.totalExpense.value = _expenseController
            .allExpenseList
            .map((e) => e.amount)
            .fold(0, (previousValue, element) => previousValue + element);
        _isLoading = false;
        print('expense list: ${_expenseController.allExpenseList.value}');
      });
    });

    _expenseController
        .getAllExpenseCategory(shopId: '${getShopId.read('shop_id')}')
        .then((value) {
      setState(() {
        _expenseController.allExpenseCategory.value =
            expenseCategoryResponseModelFromModel(value);
        print('category: ${_expenseController.allExpenseCategory}');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> fixedCategory = [
      GestureDetector(
        onTap: () {
          Get.to(
              PaySalaryPage(
                shopId: '${getShopId.read('shop_id')}',
                type: 'salary'.tr,
              ),
              arguments: shop);
        },
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFC4C4C4).withOpacity(.35)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('salary'.tr)],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.to(
              PaySalaryPage(
                shopId: '${getShopId.read('shop_id')}',
                type: 'rent'.tr,
              ),
              arguments: shop);
        },
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFC4C4C4).withOpacity(.35)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('rent'.tr)],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.to(
              PaySalaryPage(
                shopId: '${getShopId.read('shop_id')}',
                type: 'bill',
              ),
              arguments: shop);
        },
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFC4C4C4).withOpacity(.35)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'bill'.tr,
                style: TextStyle(fontFamily: 'Rubik', fontSize: 14),
              )
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.to(
              PaySalaryPage(
                shopId: '${getShopId.read('shop_id')}',
                type: 'rent'.tr,
              ),
              arguments: shop);
        },
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFC4C4C4).withOpacity(.35)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('rent'.tr,
                  style: TextStyle(fontFamily: 'Rubik', fontSize: 14))
            ],
          ),
        ),
      ),
    ];

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    for (int i = 0;
        i < _expenseController.allExpenseCategory.value.length;
        i++) {
      for (int j = 0; j < _expenseController.allExpenseList.value.length; j++) {
        if (_expenseController.allExpenseCategory[i].name ==
            _expenseController.allExpenseList[j].type) {
          _expenseController.categoryWiseTotalAmount.value =
              _expenseController.allExpenseList[j].amount +
                  _expenseController.categoryWiseTotalAmount.value;
        }
      }
    }

    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Expense List',
            style: TextStyle(fontFamily: 'Rubik', fontSize: 16)),
        backgroundColor: bgColor,
      ),
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: _isLoading,
          opacity: 1,
          child: listCount != 0
              ? SingleChildScrollView(
                  child: Container(
                    // height: height + 1000,
                    color: Colors.white,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Column(
                        children: [
                          Container(
                            height: 300,
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: DEFAULT_BLUE,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'total_cost'.tr,
                                        style: TextStyle(
                                            color: Color(0xFFFECD1A),
                                            fontFamily: 'Rubik',
                                            fontSize: 16),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(ExpenseList2(),
                                              arguments: shop);
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Icon(
                                                Icons.compare_arrows_rounded,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(() => Text(
                                            '${_expenseController.totalExpense.value}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontFamily: 'Rubik'),
                                          )),
                                      Text(
                                        '${DateFormat.yMMMMd().format(now)}',
                                        style: TextStyle(
                                            color: Color(0xFFDFE0EB),
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: const Color(0xFFC4C4C4)
                                        .withOpacity(.35),
                                    thickness: 1.5,
                                  ),
                                  Obx(() => GridView.count(
                                        crossAxisCount: 3,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        childAspectRatio: 1.5,
                                        children: List.generate(
                                          6,
                                          (index) => Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0, bottom: 5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Color(0xFFC4C4C4)
                                                      .withOpacity(.35)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${_expenseController.allExpenseList[index].amount}',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFDFE0EB),
                                                          fontSize: 16,
                                                          fontFamily: 'Rubik'),
                                                    ),
                                                    Text(
                                                      '${((_expenseController.allExpenseList[index].amount / _expenseController.totalExpense.value) * 100).toStringAsFixed(1)}%',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFDFE0EB),
                                                          fontSize: 16,
                                                          fontFamily: 'Rubik'),
                                                    ),
                                                    Text(
                                                      '${_expenseController.allExpenseList[index].type}',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFDFE0EB),
                                                          fontSize: 16,
                                                          fontFamily: 'Rubik'),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('new_expense'.tr,
                                  style: TextStyle(
                                      fontFamily: 'Rubik', fontSize: 16)),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  side: BorderSide(color: Colors.blueAccent),
                                ),
                                onPressed: () {

                                  Get.to(AllExpenses(), arguments: shop);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.blueAccent,
                                    ),
                                    Text(
                                      'expense_type'.tr,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontFamily: 'Rubik',
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GridView.count(
                            primary: false,
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 5,
                            shrinkWrap: true,
                            children: List.generate(
                              fixedCategory.length,
                              (index) => fixedCategory[index],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(() => GridView.count(
                                primary: false,
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 5,
                                shrinkWrap: true,
                                children: List.generate(
                                  _expenseController.allExpenseCategory.length,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      // print(
                                      //     'type name: ${_expenseController.allExpenseCategory[index].name}');
                                      Get.to(
                                          NewExpense(
                                            shopId:
                                                '${getShopId.read('shop_id')}',
                                            type:
                                                '${_expenseController.allExpenseCategory[index].name}',
                                            // purpose: _expenseList[index].purpose,
                                            // details: _expenseList[index].details,
                                            // amount:
                                            //     '${_expenseList[index].amount}',
                                            // userId:
                                            //     '${_expenseList[index].userId}',
                                          ),
                                          arguments: shop);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0xFFC4C4C4)
                                              .withOpacity(.35)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              '${_expenseController.allExpenseCategory[index].name}',
                                              style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 16))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
