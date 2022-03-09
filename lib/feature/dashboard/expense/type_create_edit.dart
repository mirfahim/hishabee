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

class ExpenseTypeEdit extends StatelessWidget {
  String categoryId;
  String shopId;
  String name;
  ExpenseTypeEdit({this.categoryId, this.shopId, this.name});

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
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
        title: Text('New Expense', style: TextStyle(
            color: Colors.black
        ),),
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
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide(
                            color: Color(0xFFC4C4C4).withOpacity(.35),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide(
                            color: Color(0xFFC4C4C4).withOpacity(.35),
                          ),
                        ),
                        counterText: "",
                        hintText: name,
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
                        await _expenseController.updateCategory(
                            shopId: shopId,
                            categoryid: categoryId,
                            name: _textEditingController.text);

                        await _expenseController
                            .getAllExpenseCategory(
                                shopId: '${getShopId.read('shop_id')}')
                            .then((value) {
                          // setState(() {
                          _expenseController.allExpenseCategory.value =
                              expenseCategoryResponseModelFromModel(value);
                          print(
                              'category: ${_expenseController.allExpenseCategory}');
                          // });
                        });
                        Get.back();
                        Get.back();
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
