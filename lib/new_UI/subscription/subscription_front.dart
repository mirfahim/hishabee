import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Color textColor = const Color(0xFF185ADB);

class SubscriptionFrontPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Present Subscription',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              Text(
                'My shop',
                style: TextStyle(fontSize: 18, color: textColor),
              )
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SvgPicture.asset(
                'assets/questionMark.svg',
                width: 20,
                height: 20,
              ),
            )
          ],
          backgroundColor: Colors.amber,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                child: Card(
                  elevation: 5,
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SvgPicture.asset('assets/tickSign.svg'),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 4.0, bottom: 4),
                          child: Text('PresentSubscription'),
                        ),
                        const Text(
                          'ADVANCED',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Validation: 30 days',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                              'Next Time to validate: 10th Sepetermber, 2021'),
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: const Text('Proceed'))
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20.0, bottom: 30),
                          child: Text('History of Subscription'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 8,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Column(
                                    children: const [
                                      Text(
                                        '14',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Days',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.blue),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                const VerticalDivider(
                                  width: 2,
                                  thickness: 2,
                                  color: Colors.black,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text('TRAIL',
                                          style: TextStyle(
                                            fontSize: 16,
                                          )),
                                      Text('start date: 5th July, 2021',
                                          style: TextStyle(
                                            fontSize: 12,
                                          )),
                                      Text('start date: 10th September, 2021',
                                          style: TextStyle(
                                            fontSize: 12,
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 8,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Column(
                                    children: const [
                                      Text(
                                        '14',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Days',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.blue),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                const VerticalDivider(
                                  width: 2,
                                  thickness: 1,
                                  color: Colors.black,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text('TRAIL',
                                          style: TextStyle(
                                            fontSize: 16,
                                          )),
                                      Text('start date: 5th July, 2021',
                                          style: TextStyle(
                                            fontSize: 12,
                                          )),
                                      Text('start date: 10th September, 2021',
                                          style: TextStyle(
                                            fontSize: 12,
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Center(
                    child: Text(
                      'Buy other Subscription Package',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 2,
                      color: Color(0xFF185ADB),
                    ),
                    primary: Color(0xFF185ADB),
                    // minimumSize: Size(40, 10),
                    fixedSize: Size(MediaQuery.of(context).size.width, 42),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
