import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/expense/type_create.dart';
import 'package:hishabee_business_manager_fl/feature/dashboard/expense/type_create_edit.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_category.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'expense_front.dart';

class AllExpenses extends StatefulWidget {
  @override
  State<AllExpenses> createState() => _AllExpensesState();
}

class _AllExpensesState extends State<AllExpenses> {
  ExpenseController _expenseController = Get.find();

  Shop shop = Get.arguments;
  var getShopId = GetStorage('shop_id');
  // bool _isLoading = true;
  @override
  void initState() {
    _expenseController
        .getAllExpenseCategory(shopId: '${getShopId.read('shop_id')}')
        .then((value) {
      setState(() {
        _expenseController.allExpenseCategory.value =
            expenseCategoryResponseModelFromModel(value);
        // bool _isLoading = false;
        // print('category: ${_expenseController.allExpenseCategory}');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: DEFAULT_YELLOW_BG,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
            // MaterialPageRoute(builder: (context) => ExpenseList());
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Other Expenses'),
        backgroundColor: DEFAULT_YELLOW_BG,
      ),
      body: SafeArea(
          child:
              // LoadingOverlay(
              //   isLoading: _isLoading,
              //   child:
              // _expenseController.allExpenseCategory != null
              //       ?
              Container(
        height: height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Container(
                  height: 600,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _expenseController.allExpenseCategory.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFF1F1F1),
                            ),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8, bottom: 8),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          '${_expenseController.allExpenseCategory[index].name}')
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Get.to(ExpenseTypeEdit(
                                            shopId:
                                                '${getShopId.read('shop_id')}',
                                            categoryId:
                                                '${_expenseController.allExpenseCategory[index].id}',
                                            name:
                                                '${_expenseController.allExpenseCategory[index].name}',
                                          ));
                                          // _expenseController.updateCategory(
                                          //     shopId:
                                          //         '${getShopId.read('shop_id')}',
                                          //     categoryid:
                                          //         '${_expenseController.allExpenseCategory[index].id}',
                                          //     name:
                                          //         '${_expenseController.allExpenseCategory[index].name}');
                                        },
                                        icon: Icon(Icons.edit),
                                        color: Colors.blue,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _expenseController.deleteCategory(
                                              categoryid:
                                                  '${_expenseController.allExpenseCategory[index].id}');
                                          // print(
                                          //     'category id: ${_expenseController.allExpenseCategory[index].id}');

                                          _expenseController
                                              .getAllExpenseCategory(
                                                  shopId:
                                                      '${getShopId.read('shop_id')}')
                                              .then((value) {
                                            setState(() {
                                              _expenseController
                                                      .allExpenseCategory
                                                      .value =
                                                  expenseCategoryResponseModelFromModel(
                                                      value);
                                              print(
                                                  'category: ${_expenseController.allExpenseCategory}');
                                            });
                                          });
                                        },
                                        icon: Icon(Icons.delete),
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(ExpenseTypeSecond(), arguments: shop);
                },
                child: const Center(
                  child: Text(
                    'New Expense Type',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueAccent, fontSize: 12),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  fixedSize: Size(width, 40),
                  side: BorderSide(color: Colors.blueAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              )
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