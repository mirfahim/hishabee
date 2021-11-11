import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget CustomTransparentButton(
    {String text,
     double height,
     double width,
    IconData icon}) {
  return ElevatedButton(
    onPressed: () {},
    child: Row(
      children: [
        (icon != null)
            ? Icon(
                icon,
                color: Color(0xFF185ADB),
              )
            : Container(),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: const TextStyle(color: Color(0xFF185ADB)),
        )
      ],
    ),
    style: ElevatedButton.styleFrom(
      side: const BorderSide(width: 1, color: Color(0xFF185ADB)),
      primary: Colors.white,
      fixedSize: Size(height, width),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

Widget InternetBuyContainer(String gb, String days, String money) {
  return Container(
    height: 81,
    child: Stack(
      children: [
        Positioned(
          top: 1,
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFF185ADB),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            height: 18,
            width: 66,
            child: Center(
              child: const Text(
                'Popular offer',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ),
        Positioned(
          child: Text(
            gb,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          top: 30,
        ),
        Positioned(
          child: Text(
            days,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          top: 50,
        ),
        Positioned(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              money,
              style: TextStyle(fontSize: 30),
            ),
          ),
          bottom: 1,
          right: 1,
        ),
      ],
    ),
  );
}

List<Widget> internetpack = [
  InternetBuyContainer('10 gb', '10 days', '69'),
  InternetBuyContainer('10 gb', '10 days', '10'),
  InternetBuyContainer('10 gb', '10 days', '10'),
  InternetBuyContainer('10 gb', '10 days', '10'),
  InternetBuyContainer('10 gb', '10 days', '10')
];

class MobileTopUpWithMoney extends StatefulWidget {


  @override
  _MobileTopUpWithMoneyState createState() => _MobileTopUpWithMoneyState();
}

class _MobileTopUpWithMoneyState extends State<MobileTopUpWithMoney>
    with TickerProviderStateMixin {
  TabController tabcontroller;
  @override
  void initState() {
    tabcontroller = TabController(initialIndex: 0, length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TabController(length: 4, vsync: this);
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
                  TextField(
                    decoration: InputDecoration(
                        suffix: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Type your mobile number here'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTransparentButton(
                          text: '20', height: 60, width: 30),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomTransparentButton(
                          text: '50', height: 60, width: 30),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomTransparentButton(
                          text: '100', height: 70, width: 30),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomTransparentButton(
                          text: '200', height: 70, width: 30),
                    ],
                  ),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFC4C4C4).withOpacity(.35),
                        borderRadius: BorderRadius.circular(10)),
                    height: 30,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Internet'),
                          Text('Minutes'),
                          Text('Call Rate'),
                          Text('Bandles')
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: internetpack.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                            height: 81,
                            width: 146,
                            child: Card(child: internetpack[index]));
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
