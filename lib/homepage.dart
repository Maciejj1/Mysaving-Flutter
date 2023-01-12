import 'package:flutter/material.dart';
import 'package:mysavingapp/pages/register/register.dart';
import 'pages/login/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Image.asset('./assets/images/login/logo.png'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Zacznijmy',
                    style: TextStyle(
                      color: Color(0xff005796),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 35),
                  Text(
                    'Zaloguj się lub zarejestruj i zacznij\n oszczędzać na swoje marzenia!',
                    style: TextStyle(
                      color: Color(0xff005796),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 40),
          Image.asset('./assets/images/login/login_background_1.png',
              width: 330, height: 227),
          SizedBox(height: 40),
          SizedBox(
            width: 280,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
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
                        'Zaloguj się',
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
            width: 280,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Register(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Zarejestruj się',
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
