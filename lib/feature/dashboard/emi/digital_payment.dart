import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DigitalPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              "Digital Payment",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 40),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Digital Payment",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 40,
                    color: Colors.blue[900]),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.yellow.shade100,
                  border: Border.all(color: Colors.grey, width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
              child: Text(
                Get.arguments,
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
              ),
            ),
            Text("[Share this url with your customer to receive payment]"),
            Row(
              children: [
                OutlineButton(
                    onPressed: () => null,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Icon(Icons.save_alt_rounded),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Visit Url'),
                          ],
                        ),
                      ],
                    ),
                    highlightedBorderColor: Colors.orange,
                    color: Colors.green,
                    borderSide: new BorderSide(color: Colors.green),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0))),
                OutlineButton(
                    onPressed: () => null,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Icon(Icons.save_alt_rounded),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Copy Url'),
                          ],
                        ),
                      ],
                    ),
                    highlightedBorderColor: Colors.orange,
                    color: Colors.green,
                    borderSide: new BorderSide(color: Colors.green),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
