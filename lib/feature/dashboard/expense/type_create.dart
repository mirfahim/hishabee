import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:hishabee_business_manager_fl/models/expense/expense_category.dart';

import 'all_expenses.dart';

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
            // print(_expenseController.getAllExpenseCategory(shopId: '${getShopId.read('shop_id')}'));
            Get.back();
            // Get.to(() => AllExpenses());
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
                      onPressed: () async{
                        // setState(() {
                        for(int i = 0;i<_expenseController.allExpenseCategory.length; i++){
                          if(_textEditingController.value.text == _expenseController.allExpenseCategory[i].name){
                            print('_textEditingController.value.text: ${_textEditingController.value.text}');
                            print('_expenseController.allExpenseCategory[i].name: ${_expenseController.allExpenseCategory[i].name}');
                            print('The type Exist');
                            break;
                          }else{
                            _expenseController.createNewExpenseType(
                                shopId: '${shop.id}',
                                name: _textEditingController.value.text);
                            // _expenseController.allExpenseCategory.value.add(value);
                            break;
                          }
                        }

                        // _expenseController.allExpenseCategory
                        //     .removeWhere((element) =>
                        // element.id ==
                        //     _expenseController
                        //         .allExpenseCategory[index]
                        //         .id);

                        // _expenseController.allExpenseCategory.add((element) =>
                        //     element.name ==
                        //     _expenseController
                        //         .allExpenseCategory[element.id].name);

                        // _expenseController
                        //     .getAllExpenseCategory(
                        //         shopId: '${getShopId.read('shop_id')}')
                        //     .then((value) {
                        // setState(() {
                        //   _expenseController.allExpenseCategory.value;
                        // });
                        // });
                        // });

                        _textEditingController.clear();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => AllExpenses()));
                        // Get.off();
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
                    // TextButton(
                    //   onPressed: () {},
                    //   style: TextButton.styleFrom(primary: Colors.red),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: const [
                    //       Icon(Icons.delete),
                    //       Text('Delete the type')
                    //     ],
                    //   ),
                    // )
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
