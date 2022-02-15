import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TransactionDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        titleSpacing: 0,
        title: Column(
          children: [
            Text(
              'transaction_details'.tr,
              style: TextStyle(color: Colors.black,fontFamily: 'Roboto'),
            ),
            // Text(
            //   'তুসার টেলিকম',
            //   style: TextStyle(color: Colors.black, fontSize: 12),
            // ),
          ],
        ),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(6)
              ),
              child: ListTile(
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('৳ 120', style: TextStyle(
                        fontSize: 16, fontFamily: 'Roboto'
                    ),),
                  ],
                ),

                title: Text('Samin', textAlign: TextAlign.start, style: TextStyle(
                    fontSize: 16, fontFamily: 'Roboto'
                ),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('payment_method'.tr, style: TextStyle(
                        fontSize: 14, fontFamily: 'Roboto'
                    ),),
                    Text('15th January, 2022', style: TextStyle(
                        fontSize: 14, fontFamily: 'Roboto'
                    ),)
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
