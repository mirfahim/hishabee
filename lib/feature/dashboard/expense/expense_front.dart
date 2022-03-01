import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/_bindings/expense_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/expenses/presentation/pages/pay_salary_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/expense/custom_expense_page.dart';
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
  var startOfMonth = DateTime(now.year, now.month, 1);
  var lastOfTheMonth = (now.month < 12)
      ? new DateTime(now.year, now.month + 1, 0)
      : new DateTime(now.year + 1, 1, 0);
  ExpenseController _expenseController = Get.put(ExpenseController());
  Shop shop = Get.arguments;
  List<ExpenseResponseModel> _expenseList;
  List<ExpenseCategoryResponseModel> _expenseCatergoryList;
  bool _isLoading = true;
  int listCount = 6;

  // int totalExpense = 0;
  var getShopId = GetStorage('shop_id');

  @override
  @override
  void initState() {
    setState(() {

      _expenseController
          .getAllExpense(
          shopId: '${shop.id}',
          userId: '${shop.userId}',
          startDate: '$startOfMonth',
          endDate: '$lastOfTheMonth')
          .then((value) {

        _expenseController.allExpenseList.value = getExpenseFromModel(value);
        _expenseController.allFixedExpenseList.value =
            _expenseController.allExpenseList.value;

        _expenseController.totalExpense.value = _expenseController.allExpenseList
            .map((e) => e.amount)
            .fold(0, (previousValue, element) => previousValue + element);
        _expenseController.totalFixedExpense.value =
            _expenseController.totalExpense.value;
        _isLoading = false;
      });

    });

    _expenseController
        .getAllExpenseCategory(shopId: '${shop.id}')
        .then((value) {
      setState(() {
        _expenseController.allExpenseCategory.value =
            expenseCategoryResponseModelFromModel(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final shopFeatureController = Get.find<ShopFeaturesController>();
    _expenseController.fixedCategory = [
      GestureDetector(
        onTap: () {
          Get.to(
              PaySalaryPage(),
              arguments: {"shop": shop},
              binding: ExpenseBinding()
          );
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
              Image.asset('images/assets/salary_expense.png'),
              Text('salary'.tr)
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.to(
              CustomExpensePage(
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
              Image.asset('images/assets/rent_expense.png'),
              Text('rent'.tr,style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14
              ),)
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.to(
              CustomExpensePage(
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
              Image.asset('images/assets/utility_expense.png'),
              Text(
                'bill'.tr,
                style: TextStyle(fontFamily: 'Roboto', fontSize: 14),
              )
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.to(
              CustomExpensePage(
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
              Image.asset('images/assets/rent_expense.png'),
              Text('rent'.tr,
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 14))
            ],
          ),
        ),
      ),
    ].obs;
    _expenseController.allExpenseCategory
        .forEach((element) =>
        setState(() {
          _expenseController.fixedCategory.add(
              GestureDetector(
                onTap: () {
                  Get.to(
                      NewExpense(
                        shopId: '${shop.id}',
                        type: '${element.name}',
                      ),
                      arguments: shop);
                },
                child: Container(
                  height: 80,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFC4C4C4).withOpacity(.35)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('images/svg_image/empty-image.svg', height: 30,),
                      Text('${element.name}',
                          style: TextStyle(fontFamily: 'Roboto', fontSize: 16))
                    ],
                  ),
                ),
              ));
        }));
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;
    // for (int i = 0;
    //     i < _expenseController.allExpenseCategory.value.length;
    //     i++) {
    //   for (int j = 0; j < _expenseController.allExpenseList.value.length; j++) {
    //     if (_expenseController.allExpenseCategory[i].name ==
    //         _expenseController.allExpenseList[j].type) {
    //       _expenseController.categoryWiseTotalAmount.value =
    //           _expenseController.allExpenseList[j].amount +
    //               _expenseController.categoryWiseTotalAmount.value;
    //     }
    //   }
    // }

    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('expense'.tr,
            style: TextStyle(fontFamily: 'Roboto')),
        backgroundColor: bgColor,
      ),
      body: SafeArea(
        child:
        // LoadingOverlay(
        //   isLoading: _isLoading,
        //   opacity: 1,
        //   child: listCount != 0
        //       ?
          SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      children: [
                        Container(
                          // height: _expenseController.allExpenseList.length == 0 ? 210 : 320,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: DEFAULT_BLUE,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8, top: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'total_cost'.tr,
                                          style: TextStyle(
                                              color: Color(0xFFFECD1A),
                                              fontFamily: 'Roboto',
                                              fontSize: 16),
                                        ),
                                        Text(
                                          '${DateFormat.yMMMM().format(now)}',
                                          style: TextStyle(
                                              color: Color(0xFFDFE0EB),
                                              fontSize: 12, fontFamily: 'Roboto'),
                                        ),
                                      ],
                                    ),
                                    Obx(() => Text(
                                      '৳${_expenseController.totalFixedExpense.value}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontFamily: 'Roboto'),
                                    )),
                                  ],
                                ),
                                Divider(
                                  color: const Color(0xFFC4C4C4)
                                      .withOpacity(.35),
                                  thickness: 1.5,
                                ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('maximum_expense_list'.tr, style: TextStyle(
                                    fontSize: 14, fontFamily: 'Roboto', color: Colors.white
                                  ),),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(ExpenseList2(),
                                              arguments: shop);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10)
                                              ),
                                          child: Padding(
                                              padding:
                                              const EdgeInsets.all(10.0),
                                              child: Text('see_more_details'.tr, style: TextStyle(
                                                color: DEFAULT_BLUE,
                                                fontSize: 12,
                                                fontFamily: 'Roboto'
                                              ),)),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Obx(() => GridView.count(
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                              childAspectRatio: 1.25,
                              children: List.generate(
                                _expenseController.allFixedExpenseList
                                    .length >=
                                    6
                                    ? 6
                                    : _expenseController
                                    .allFixedExpenseList.length,
                                    (index) => Padding(
                                  padding: const EdgeInsets.only(left: 2,
                                      right: 2.0, bottom: 4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        color: Color(0xFFC4C4C4)
                                            .withOpacity(.35)),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '৳ ${_expenseController.allFixedExpenseList[index].amount}',
                                            style: TextStyle(
                                                color:
                                                Color(0xFFDFE0EB),
                                                fontSize: 16,
                                                fontFamily: 'Roboto'),
                                          ),
                                          Text(
                                            '${((_expenseController.allFixedExpenseList[index].amount / _expenseController.totalExpense.value) * 100).toStringAsFixed(1)}%',
                                            style: TextStyle(
                                                color:
                                                Color(0xFFDFE0EB),
                                                fontSize: 16,
                                                fontFamily: 'Roboto'),
                                          ),
                                          Text(
                                            '${_expenseController.allFixedExpenseList[index].type}',
                                            style: TextStyle(
                                                color:
                                                Color(0xFFDFE0EB),
                                                fontSize: 16,
                                                fontFamily: 'Roboto'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )), //TODO: Expense percentage according to category
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
                                    fontFamily: 'Roboto', fontSize: 16)),
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
                                        fontFamily: 'Roboto',
                                        fontSize: 14),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(() => GridView.count(
                          // childAspectRatio: 2.25,
                          primary: false,
                          crossAxisCount: 3,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          shrinkWrap: true,
                          children: List.generate(
                            _expenseController.fixedCategory.length,
                                (index) => _expenseController.fixedCategory[index],
                          ),
                        ))
                      ],
                    ),
                  ),
                )
              // : Container(),
        // ),
      ),
    );
  }
}
