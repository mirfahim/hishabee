import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/manager/onboardingManager/onboardingController.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingPage extends StatelessWidget {
  final _controller = OnboardingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      // padding: EdgeInsets.only(top: 0),
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller.pageController,
            onPageChanged: _controller.selectedPageIndex,
            itemCount: _controller.onboardingPages.length,
            itemBuilder: (context, index) {
              // double width = MediaQuery.of(context).size.width;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    _controller.onboardingPages[index].imageAsset,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                  Text(
                    _controller.onboardingPages[index].title,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(_controller.onboardingPages[index].icon1),
                          SizedBox(
                            width: 10,
                          ),
                          Text(_controller.onboardingPages[index].point1),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(_controller.onboardingPages[index].icon2),
                          SizedBox(
                            width: 10,
                          ),
                          Text(_controller.onboardingPages[index].point2),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            _controller.onboardingPages[index].icon3,
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(_controller.onboardingPages[index].point3),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(_controller.onboardingPages[index].icon4),
                          SizedBox(
                            width: 10,
                          ),
                          Text(_controller.onboardingPages[index].point4),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 180,
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
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: _controller.fowardAction,
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
