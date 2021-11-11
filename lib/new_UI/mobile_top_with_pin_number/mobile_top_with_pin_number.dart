import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class MobileTopUpWithPinNumber extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.amber,
        title: Text('Mobile TopUp'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.access_alarms))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: const Color(0xFF185ADB),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add,
                                size: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('Add Money')
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('confirm it'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF185ADB),
                          fixedSize: Size(150, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Mobile Number'),
                  ListTile(
                    leading: ClipOval(
                      child: Image.asset(
                        'images/sharukh2.jpeg',
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    title: Text('Samin Yeaser'),
                    subtitle: Text('01830736470'),
                    trailing: SvgPicture.asset('images/grameen2.svg'),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 4,
              color: const Color(0xFFc4c4c4).withOpacity(.35),
            ),
            const Text('Amount'),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                '49',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Divider(
                    thickness: 4,
                    color: const Color(0xFFc4c4c4).withOpacity(.35),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.mobile_friendly),
                          Text('1 Paisa/Second')
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_time_outlined),
                          Text('2 days')
                        ],
                      )
                    ],
                  ),
                  TextField(
                    maxLength: 5,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(5),
                      FilteringTextInputFormatter.allow(
                        RegExp('[0-9]'),
                      ),
                    ],
                    obscureText: true,
                    decoration: InputDecoration(
                        suffix: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Type your pin number'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
