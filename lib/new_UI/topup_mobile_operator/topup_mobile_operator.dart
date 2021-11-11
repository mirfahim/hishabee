import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget OperatorCard(String imagePath, String name) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
    ),
    height: 30,
    width: 40,
    child: Card(
      elevation: 2,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Image.asset(imagePath),
          Text(name)
        ],
      ),
    ),
  );
}

List<Widget> operators = [
  OperatorCard('images/grameen.jpg', 'Grammen'),
  OperatorCard('images/airtel.jpg', 'Airtel'),
  OperatorCard('images/robi.jpg', 'Robi'),
  OperatorCard('images/teletalk.jpg', 'Teletalk'),
  OperatorCard('images/Banglalink.jpg', 'Banglalink'),
];

class TopUpMobileOperator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select Operator'),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: height / 2.50,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemCount: operators.length,
                        itemBuilder: (BuildContext context, int index) {
                          return operators[index];
                        }),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 4,
              color: const Color(0xFFc4c4c4).withOpacity(.35),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Text('Select Number  type'),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Prepaid',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 1.5,
                            color: Color(0xFF185ADB),
                          ),
                          primary: Colors.white,
                          // minimumSize: Size(40, 10),
                          fixedSize: Size(100, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Postpaid',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 1.5,
                            color: Color(0xFF185ADB),
                          ),
                          primary: Colors.white,
                          // minimumSize: Size(40, 10),
                          fixedSize: Size(100, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Skito',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 1.5,
                            color: Color(0xFF185ADB),
                          ),
                          primary: Colors.white,
                          // minimumSize: Size(40, 10),
                          fixedSize: Size(100, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Proceed',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        width: 2,
                        color: Color(0xFF185ADB),
                      ),
                      primary: Color(0xFF185ADB),
                      // minimumSize: Size(40, 10),
                      fixedSize: Size(341, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
