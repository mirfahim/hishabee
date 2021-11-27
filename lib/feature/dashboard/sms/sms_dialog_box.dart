
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  static exit(context) => showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondAnimation) =>
          SafeArea(child: SmsCustomDialogContacts()));
}



class SmsCustomDialogContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.white,
      child: _buildChild(context, height, width),
    );
  }

  _buildChild(BuildContext context, double height, double width) =>
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Text('Contact List'),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: width,
                  decoration: BoxDecoration(
                      color: Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Customer'),
                        Text('Supplier'),
                        Text('Workers')
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    fillColor: Colors.white,
                    label: Text('Search Customer'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                  child: ListTile(
                    title: Text('Md. Samin Yeaser'),
                    subtitle: Text('01830736470'),
                    leading: Container(
                      height: 55.0,
                      width: 55.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child:
                      ClipOval(child: Image.asset('images/sharukh2.jpeg')),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                  child: ListTile(
                    title: Text('Md. Samin Yeaser'),
                    subtitle: Text('01830736470'),
                    leading: Container(
                      height: 55.0,
                      width: 55.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child:
                      ClipOval(child: Image.asset('images/sharukh2.jpeg')),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                  child: ListTile(
                    title: Text('Md. Samin Yeaser'),
                    subtitle: Text('01830736470'),
                    leading: Container(
                      height: 55.0,
                      width: 55.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child:
                      ClipOval(child: Image.asset('images/sharukh2.jpeg')),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          child: Text(
                            'Close',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Add Customer'),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
