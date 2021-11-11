





///TODO: this is implemented in the main app






import 'package:flutter/material.dart';

Widget PackageCard(int smsNumber, double smsMoney) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10),
    child: SizedBox(
      height: 80,
      child: Card(
        child: Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              child: Column(
                children: [
                  Text(
                    smsNumber.toString(),
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'S M S',
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            const VerticalDivider(
              width: 10,
              thickness: 1,
              color: Colors.black,
              indent: 10,
              endIndent: 10,
            ),
            const SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('৳${smsMoney.toString()}',
                      style: const TextStyle(
                        fontSize: 20,
                      )),
                  Text('Per SMS ${(smsMoney / smsNumber)} TK only',
                      style: const TextStyle(
                        fontSize: 15,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

List<Widget> packageWidget = [
  PackageCard(35, 10.5),
  PackageCard(100, 28),
  PackageCard(250, 65),
  PackageCard(500, 120),
];

class SMSPackages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          ),
          backgroundColor: Colors.amber,
          title: const Text('SMS'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  children: const [
                    Icon(Icons.history),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Message History')
                  ],
                ),
              ),
            )
          ],
        ),
        body: ListView.builder(
            itemCount: packageWidget.length,
            itemBuilder: (context, index) {
              return packageWidget[index];
            }),
      ),
    );
  }
}
