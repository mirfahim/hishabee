import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_category.dart';

import 'all_expenses.dart';
import 'expense_details.dart';

// Widget textFormFeildForExpense(
//     {String hintText,
//       String labelText,
//       IconButton iconButton,
//       int maxLine}) {
//   return
//     TextFormField(
//     cursorColor: Colors.black,
//     minLines: maxLine,
//     onChanged: (value) {
//       // controller.mobileNumber.value = value;
//     },
//     maxLines: maxLine,
//     decoration: InputDecoration(
//       label: Text(labelText),
//       suffix: iconButton,
//       filled: true,
//       contentPadding: EdgeInsets.symmetric(horizontal: 8),
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//       counterText: "",
//       hintText: hintText,
//       hintStyle: const TextStyle(
//         fontWeight: FontWeight.bold,
//         color: Colors.black26,
//       ),
//     ),
//   );
// }

class ExpenseTypeSecond extends StatefulWidget {
  @override
  State<ExpenseTypeSecond> createState() => _ExpenseTypeSecondState();
}

class _ExpenseTypeSecondState extends State<ExpenseTypeSecond> {
  ExpenseController _expenseController = Get.find();

  TextEditingController _textEditingController = TextEditingController();

  Shop shop = Get.arguments;

  var getShopId = GetStorage('shop_id');

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('New Expense'),
        backgroundColor: DEFAULT_YELLOW_BG,
      ),
      body: SafeArea(
        child: Container(
          height: height,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Name of type of the Expense'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _textEditingController,
                      cursorColor: Colors.black,
                      minLines: 1,
                      onChanged: (value) {
                        // controller.mobileNumber.value = value;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        counterText: "",
                        hintText: 'type',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black26,
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // setState(() {
                        for (int i = 0;
                            i < _expenseController.allExpenseCategory.length;
                            i++) {
                          if (_textEditingController.value.text ==
                              _expenseController.allExpenseCategory[i].name) {
                            // print(
                            //     '_textEditingController.value.text: ${_textEditingController.value.text}');
                            // print(
                            //     '_expenseController.allExpenseCategory[i].name: ${_expenseController.allExpenseCategory[i].name}');
                            // print('The type Exist');
                            break;
                          } else {
                            await _expenseController.createNewExpenseType(
                                shopId: '${shop.id}',
                                name: _textEditingController.value.text);
                            await _expenseController.getAllExpenseCategory(shopId: '${shop.id}').then((value){
                              setState(() {
                                _expenseController.allExpenseCategory.value =
                                           expenseCategoryResponseModelFromModel(value);
                              });
                            });
                            _expenseController.fixedCategory.add(
                                GestureDetector(
                                  onTap: () {
                                    Get.to(
                                        NewExpense(
                                          shopId: '${shop.id}',
                                          type: '${_textEditingController.value.text}',
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
                                        Image.asset('images/assets/defaultImage.png'),
                                        Text('${_textEditingController.value.text}',
                                            style: TextStyle(fontFamily: 'Rubik', fontSize: 16))
                                      ],
                                    ),
                                  ),
                                ));
                            // }));
                            Get.back();
                            Get.back();
                            break;
                          }
                        }

                        _textEditingController.clear();
                        // setState(() {
                        //   _expenseController.getAllExpenseCategory(
                        //       shopId: '${shop.id}');
                        // });
                      },
                      child: const Center(
                        child: Text(
                          'Save',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: DEFAULT_BLACK,
                        fixedSize: Size(width, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
