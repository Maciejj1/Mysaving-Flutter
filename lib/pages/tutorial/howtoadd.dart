import 'package:flutter/material.dart';

import '../../mainPage.dart';

class howToAdd extends StatefulWidget {
  const howToAdd({super.key});

  @override
  State<howToAdd> createState() => _howToAddState();
}

class _howToAddState extends State<howToAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Jak dodawać ',
                    style: TextStyle(
                      color: Color(0xff005796),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    'zakupy do katergorii?',
                    style: TextStyle(
                        color: Color(0xff005796),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter'),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ],
          ),
          Image.asset('./assets/images/login/phone2.png',
              width: 530, height: 437),
          SizedBox(height: 30),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Zacznij',
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
        ]),
      ),
    );
  }
}
