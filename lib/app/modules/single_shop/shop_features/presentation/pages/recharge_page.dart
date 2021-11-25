import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/page_header.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/recharge_page_controller.dart';

class RechargePage extends GetView<RechargeController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.2,
                        width: size.width,
                        child: Image.asset(
                          "images/topBg.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      buildPageHeader('Recharge', "Amr Dokan"),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                    child: Text(
                      "Amount",
                      style: TextStyle(
                        fontSize: 16,
                        color: DEFAULT_BLACK,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 15, right: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: TextFormField(
                        cursorColor: DEFAULT_BLACK,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[0-9]'),
                          ),
                        ],
                        maxLength: 20,
                        onChanged: (value) {
                          controller.amount.value = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          border: InputBorder.none,
                          counterText: "",
                          hintText: 'Amount',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w100,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                    child: Text(
                      "[Give the amount yo want to recharge in Hishabee wallet]",
                      style: TextStyle(
                        fontSize: 12,
                        color: DEFAULT_BLACK,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 15, right: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: DEFAULT_BLACK)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "[Hishabee credit shall not be withdrawn and can only be used to buy hishabee service lik subscribe package and marketing shop products]",
                          style: TextStyle(
                            fontSize: 16,
                            color: DEFAULT_BLACK,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: DEFAULT_BLACK),
                      onPressed: () {
                        controller.recharge();
                      },
                      child: Container(
                        height: 40,
                        width: size.width,
                        child: Center(
                          child: Text(
                            "Recharge in Hishabee Wallet",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
