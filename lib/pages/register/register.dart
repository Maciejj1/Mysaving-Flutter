import 'package:flutter/material.dart';
import 'package:mysavingapp/pages/login/buttons/buttong.dart';
import 'package:mysavingapp/mainPage.dart';

import '../tutorial/getStarted.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Image.asset('./assets/images/login/logo.png'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Witaj w MySaving',
                  style: TextStyle(
                    color: Color(0xff005796),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Zacznij oszczędzać',
                  style: TextStyle(
                    color: Color(0xff005796),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
                UserName(),
                Email(),
                Password(),
                Padding(
                  padding: const EdgeInsets.only(right: 30, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Zapomniałeś hasło?',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            color: Color(0xff005796),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: 350,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const getStarted(),
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
                                'Zarejestruj się',
                                style: TextStyle(
                                    fontFamily: 'Inter', fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xff005796),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Image.asset(
                          './assets/images/login/line.png',
                          height: 5,
                          width: 150,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'LUB',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 18,
                              color: Color(0xff005796)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Image.asset('./assets/images/login/line.png',
                            height: 5, width: 140),
                      )
                    ],
                  ),
                ),
                ButtonG(),
                ButtonA(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
