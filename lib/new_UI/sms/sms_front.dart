





///TODO: this is implemented in the main app








import 'package:flutter/material.dart';

class SMSFront extends StatefulWidget {

  @override
  State<SMSFront> createState() => _SMSFrontState();
}

class _SMSFrontState extends State<SMSFront> {
  final TextEditingController messageController = TextEditingController();
  int maxLengthForText = 160;
  String textInTheMessageField = '';
  int messageCount = 1;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back),
            ),
            backgroundColor: Colors.amber,
            title: Text('SMS'),
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        focusColor: Colors.black,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        prefixIcon: Icon(
                          Icons.call,
                          color: Colors.grey,
                        )),
                  ),
                ),
                Text(
                  'Get Number From',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(
                                Icons.people,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Customer',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            side:
                                const BorderSide(width: 1, color: Colors.black),
                            primary: Colors.white,
                            fixedSize: Size(140, 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(
                                Icons.people,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Employee',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            side:
                                const BorderSide(width: 1, color: Colors.black),
                            primary: Colors.white,
                            fixedSize: Size(140, 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(
                                Icons.people,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Supplier',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            side:
                                const BorderSide(width: 1, color: Colors.black),
                            primary: Colors.white,
                            fixedSize: Size(140, 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.contacts,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Import from contacts',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(width: 1, color: Colors.black),
                      primary: Colors.white,
                      fixedSize: Size(width, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: messageController,
                    onChanged: (text) {
                      setState(() {
                        textInTheMessageField = text;
                      });
                      RegExp exp = RegExp("[A-Za-z0-9]");
                      if (exp.hasMatch(text.substring(0)) &&
                          text.substring(0) != " ") {
                        setState(() {
                          maxLengthForText = 160;
                        });
                        if ((text.length / 160) <= 1) {
                          setState(() {
                            messageCount = 1;
                          });
                        } else if ((text.length / 160) > 1 &&
                            (text.length / 160) < 2) {
                          setState(() {
                            messageCount = 2;
                          });
                        } else if ((text.length / 160) > 2 &&
                            (text.length / 160) < 3) {
                          setState(() {
                            messageCount = 3;
                          });
                        }
                      } else {
                        setState(() {
                          maxLengthForText = 70;
                        });
                        if ((text.length / 70) <= 1) {
                          setState(() {
                            messageCount = 1;
                          });
                        } else if ((text.length / 70) > 1 &&
                            (text.length / 70) < 2) {
                          setState(() {
                            messageCount = 2;
                          });
                        } else if ((text.length / 70) > 2 &&
                            (text.length / 70) < 3) {
                          setState(() {
                            messageCount = 3;
                          });
                        }
                      }
                    },
                    // maxLength: maxLengthForText,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      helperText:
                          '${textInTheMessageField.length} Characters | ${messageCount} Messages | (${maxLengthForText}/1 messages)',
                      labelText: 'Message',
                      focusColor: Colors.black,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Send Messages',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(width: 1, color: Colors.black),
                      primary: Colors.black,
                      fixedSize: Size(width, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Buy SMS',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                        Text(
                          'SMS left - 30',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(width: 1, color: Colors.blue),
                      primary: Colors.white,
                      fixedSize: Size(110, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
