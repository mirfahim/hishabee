import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

class DueHistory extends StatefulWidget {

  @override
  State<DueHistory> createState() => _DueHistoryState();
}

class _DueHistoryState extends State<DueHistory> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('due_history'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Column(
          children: [
              Container(
                decoration: BoxDecoration(
                  color: DEFAULT_BLUE,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text('total_due'.tr, style: TextStyle(
                      color: Color(0xFFFECD1A)
                    ),),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
                        Text('17 april', style: TextStyle(color: Colors.white),),
                        IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.arrow_forward_ios, color: Colors.white,)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 60,
                          width: size.width / 2.5,
                          decoration: BoxDecoration(
                            color: Color(0xFFC4C4C4).withOpacity(.35),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text('700', style: TextStyle(
                                    color: Colors.white
                                ),),
                                Text('lend'.tr, style: TextStyle(
                                    color: Colors.white
                                ),)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: size.width / 2.5,
                          decoration: BoxDecoration(
                            color: Color(0xFFC4C4C4).withOpacity(.35),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text('১০০০ টাকা', style: TextStyle(
                                    color: Colors.white
                                ),),
                                Text('borrowed'.tr, style: TextStyle(
                                    color: Colors.white
                                ),)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
