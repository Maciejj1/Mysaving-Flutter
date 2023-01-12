import 'package:flutter/material.dart';
import 'package:mysavingapp/mainPage.dart';

import 'howtoadd.dart';

class categoryPick extends StatefulWidget {
  const categoryPick({super.key});

  @override
  State<categoryPick> createState() => _categoryPickState();
}

class _categoryPickState extends State<categoryPick> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Wybierz kategorię w ',
                    style: TextStyle(
                      color: Color(0xff005796),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    'której najczęściej',
                    style: TextStyle(
                        color: Color(0xff005796),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter'),
                  ),
                  Text(
                    'wydajesz!',
                    style: TextStyle(
                        color: Color(0xff005796),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter'),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ],
          ),
          Image.asset('./assets/images/login/phone.png',
              width: 530, height: 437),
          SizedBox(height: 20),
          SizedBox(
            width: 350,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const howToAdd(),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const mainPage(),
                  ),
                );
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
