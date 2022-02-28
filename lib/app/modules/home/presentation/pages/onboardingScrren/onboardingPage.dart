import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/manager/onboardingManager/onboardingController.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingPage extends StatelessWidget {
  final _controller = OnboardingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller.pageController,
              onPageChanged: _controller.selectedPageIndex,
              itemCount: _controller.onboardingPages.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Image.asset(
                        _controller.onboardingPages[index].imageAsset,
                        fit: BoxFit.fitWidth,
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                _controller.onboardingPages[index].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'Roboto'),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: (width /3)),
                              child: Column(
                                children: [
                                  Row(
                                    // mainAxisAlignment:  MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          _controller.onboardingPages[index].icon1),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(_controller.onboardingPages[index].point1),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    // mainAxisAlignment:  MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          _controller.onboardingPages[index].icon2),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(_controller.onboardingPages[index].point2),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    // mainAxisAlignment:  MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          _controller.onboardingPages[index].icon3,
                                        height: 30, width: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(_controller.onboardingPages[index].point3),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    // mainAxisAlignment:  MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        _controller.onboardingPages[index].icon4,
                                        height: 30, width: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(_controller.onboardingPages[index].point4),
                                    ],
                                  )
                                ],
                              ),
                            )
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   mainAxisAlignment : MainAxisAlignment.start,
                            //   children: [
                            //     Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       // crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         Image.asset(
                            //             _controller.onboardingPages[index].icon1),
                            //         SizedBox(
                            //           width: 10,
                            //         ),
                            //         Text(_controller.onboardingPages[index].point1),
                            //       ],
                            //     ),
                            //     SizedBox(height: 10,),
                            //     Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         Image.asset(
                            //             _controller.onboardingPages[index].icon2),
                            //         SizedBox(
                            //           width: 10,
                            //         ),
                            //         Text(_controller.onboardingPages[index].point2),
                            //       ],
                            //     ),
                            //     SizedBox(height: 10,),
                            //     Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         Image.asset(
                            //           _controller.onboardingPages[index].icon3,
                            //           width: 30,
                            //           height: 30,
                            //         ),
                            //         SizedBox(
                            //           width: 20,
                            //         ),
                            //         Text(_controller.onboardingPages[index].point3),
                            //       ],
                            //     ),
                            //     SizedBox(height: 10,),
                            //     Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         Image.asset(
                            //             _controller.onboardingPages[index].icon4),
                            //         SizedBox(
                            //           width: 10,
                            //         ),
                            //         Text(_controller.onboardingPages[index].point4),
                            //       ],
                            //     ),
                            //   ],
                            // )
                          ],
                        ))
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: width/2.5),
                child: Row(
                  children: List.generate(
                    _controller.onboardingPages.length,
                    (index) => Obx(() {
                      return Container(
                        margin: EdgeInsets.all(4),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            color: _controller.selectedPageIndex.value == index
                                ? Colors.amber
                                : Colors.black12,
                            shape: BoxShape.circle),
                      );
                    }),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FloatingActionButton(
                    onPressed: _controller.fowardAction,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
