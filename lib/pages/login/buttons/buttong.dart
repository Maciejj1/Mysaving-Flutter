import 'package:flutter/material.dart';
import '/pages/login/login.dart';

// text field nazwa

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SizedBox(
            child: Container(
              width: 350,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14),
                  isDense: true,
                  hintText: 'Nazwa',
                  hintStyle:
                      TextStyle(color: Color(0xff005796), fontFamily: 'Inter'),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(color: Colors.white)),
                ),
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 10, offset: Offset(2, 2))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// text field email

class Email extends StatelessWidget {
  const Email({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            child: Container(
              width: 350,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14),
                  isDense: true,
                  hintText: 'Email',
                  hintStyle:
                      TextStyle(color: Color(0xff005796), fontFamily: 'Inter'),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(color: Colors.white)),
                ),
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 10, offset: Offset(2, 2))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
//text field password

class Password extends StatelessWidget {
  const Password({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            child: Container(
              width: 350,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14),
                  isDense: true,
                  hintText: 'Hasło',
                  hintStyle:
                      TextStyle(color: Color(0xff005796), fontFamily: 'Inter'),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(color: Colors.white)),
                ),
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 10, offset: Offset(2, 2))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// button google

class ButtonG extends StatelessWidget {
  const ButtonG({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            width: 350,
            height: 50,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
            ),
            child: ElevatedButton(
              onPressed: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('./assets/images/login/google.png'),
                      Text(
                        'Zaloguj się przez google',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Color(0xff005796)),
                      ),
                    ],
                  ),
                ],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color(0xffFFFFFF),
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
          ),
        ),
      ],
    );
  }
}

// button apple

class ButtonA extends StatelessWidget {
  const ButtonA({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          width: 350,
          height: 50,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
          ),
          child: ElevatedButton(
            onPressed: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('./assets/images/login/apple.png'),
                    Text(
                      'Zaloguj się przez Apple',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: Color(0xff005796)),
                    ),
                  ],
                ),
              ],
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color(0xffFFFFFF),
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
        ),
      ),
    ]);
  }
}
