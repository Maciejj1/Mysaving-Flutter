import 'package:flutter/material.dart';
import 'package:mysavingapp/pages/app_tutorial/categoryPick.dart';

class howToSave extends StatefulWidget {
  const howToSave({Key? key}) : super(key: key);

  @override
  State<howToSave> createState() => _howToSaveState();
}

class _howToSaveState extends State<howToSave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Jak zacząć',
                    style: TextStyle(
                      color: Color(0xff005796),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text('oszczędzać?',
                      style: TextStyle(
                          color: Color(0xff005796),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter')),
                  SizedBox(height: 35),
                ],
              ),
            ],
          ),
          Image.asset('./assets/images/login/login_background_2.png',
              width: 330, height: 237),
          SizedBox(height: 70),
          SizedBox(
            width: 350,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const categoryPick(),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dalej',
                        style: TextStyle(fontFamily: 'Inter', fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color(0xff005796),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Color(0xff005796),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 350,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const mainPage(),
                //   ),
                // );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pomiń',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color(0xff005796),
                        fontSize: 20),
                  ),
                ],
              ),
              style: ButtonStyle(
                shadowColor: MaterialStateProperty.all(Colors.grey),
                backgroundColor: MaterialStateProperty.all(
                  Color(0xffffffff),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
