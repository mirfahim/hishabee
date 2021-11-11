import 'package:flutter/material.dart';

Widget ShopContainer(String image, String shopName, String address) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      // margin: const EdgeInsets.all(10),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFFEBEFF2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 5,
          ),
          Image.asset(image),
          const SizedBox(
            height: 20,
          ),
          Text(shopName),
          Text(address),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Enter'),
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
                primary: const Color(0xFF185ADB)),
          )
        ],
      ),
    ),
  );
}

List<Widget> shops = [
  ShopContainer('images/shopPic.jpg', 'Tushar', '889/1, Dampara, Chittagong'),
  ShopContainer('images/shopPic.jpg', 'Tushar', '889/1, Dampara, Chittagong'),
  ShopContainer('images/shopPic.jpg', 'Tushar', '889/1, Dampara, Chittagong'),
  ShopContainer('images/shopPic.jpg', 'Tushar', '889/1, Dampara, Chittagong'),
  ShopContainer('images/shopPic.jpg', 'Tushar', '889/1, Dampara, Chittagong'),
  ShopContainer('images/shopPic.jpg', 'Tushar', '889/1, Dampara, Chittagong'),
  ShopContainer('images/shopPic.jpg', 'Tushar', '889/1, Dampara, Chittagong'),
  ShopContainer('images/shopPic.jpg', 'Tushar', '889/1, Dampara, Chittagong'),
];

class SelectShop extends StatefulWidget {

  @override
  State<SelectShop> createState() => _SelectShopState();
}

class _SelectShopState extends State<SelectShop> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Hi',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'Select Your Shop',
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 10, right: 15, bottom: 5),
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: const [
                    Icon(
                      Icons.add_box_outlined,
                      color: Color(0xFF185ADB),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'New Shop',
                      style: TextStyle(color: Color(0xFF185ADB)),
                    )
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    width: 2,
                    color: Color(0xFF185ADB),
                  ),
                  primary: Colors.amber,
                  // minimumSize: Size(40, 10),
                  // fixedSize: Size(40, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              SizedBox(
                height: 500,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: shops.length,
                    itemBuilder: (BuildContext context, int index) {
                      return shops[index];
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: 15, bottom: 5),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Edit your shop',
                    style: TextStyle(color: Color(0xFF185ADB)),
                  ),
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 2,
                      color: Color(0xFF185ADB),
                    ),
                    primary: Colors.white,
                    // minimumSize: Size(40, 10),
                    fixedSize: Size(350, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
