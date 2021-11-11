import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  // final Image img;
  CustomDialogBox(this.title, this.text, this.descriptions);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Determine the Bill',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent),
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
              ),
              const Text('Amount'),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  '49',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Divider(
                thickness: 2,
                color: const Color(0xFFc4c4c4).withOpacity(.35),
              ),
              const SizedBox(
                height: 10,
              ),
              Table(
                border: TableBorder.all(color: Colors.grey.withOpacity(.35)),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                          child: Column(
                        children: const [
                          Text(
                            'CashBack',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '.50',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                          child: Column(
                        children: const [
                          Text(
                            'New Balance',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '450',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      )),
                    ),
                  ]),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 300,
                    child: const CircleAvatar(
                      maxRadius: 80,
                      backgroundColor: Color(0xFF185ADB),
                      child: Text(
                        'Top Up',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  Text('Tap to Recharge')
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
