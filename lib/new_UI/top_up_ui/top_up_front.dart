import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget ListOfPeople(String name, String number, String imagePath) {
  return ListTile(
    leading: ClipOval(
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: 50,
        height: 50,
      ),
    ),
    title: Text(name),
    subtitle: Text(number),
  );
}

List<Widget> people = [
  ListOfPeople('Samin Yeaser', '01830736470', 'images/sharukh2.jpeg'),
  ListOfPeople('Samin Yeaser', '01830736470', 'images/sharukh2.jpeg'),
  ListOfPeople('Samin Yeaser', '01830736470', 'images/sharukh2.jpeg'),
  ListOfPeople('Samin Yeaser', '01830736470', 'images/sharukh2.jpeg'),
  ListOfPeople('Samin Yeaser', '01830736470', 'images/sharukh2.jpeg'),
  ListOfPeople('Samin Yeaser', '01830736470', 'images/sharukh2.jpeg'),
  ListOfPeople('Samin Yeaser', '01830736470', 'images/sharukh2.jpeg'),
  ListOfPeople('Samin Yeaser', '01830736470', 'images/sharukh2.jpeg'),
  ListOfPeople('Samin Yeaser', '01830736470', 'images/sharukh2.jpeg'),
];

class TopUpFront extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            SvgPicture.asset('images/svg/exclamination.svg')
            // Icon(Icons.flag)
          ],
          title: const Text('Samin'),
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
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
                      height: 30,
                    ),
                    const Text(
                      'Name or mobila Number',
                      style: TextStyle(fontSize: 15),
                    ),
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
                      height: 10,
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 4,
                color: const Color(0xFFc4c4c4).withOpacity(.35),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Latest Transaction'),
                        ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(
                                Icons.more_time,
                                color: Color(0xFF185ADB),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                'History',
                                style: TextStyle(color: Color(0xFF185ADB)),
                              )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                width: 1, color: Color(0xFF185ADB)),
                            primary: Colors.white,
                            fixedSize: const Size(120, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 300,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return people[index];
                        },
                        itemCount: people.length,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.access_time,
            color: Colors.white,
          ),
          backgroundColor: const Color(0xFF185ADB),
        ),
      ),
    );
  }
}
