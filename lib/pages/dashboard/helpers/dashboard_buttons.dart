import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gap/gap.dart';

class DashboardButtons extends StatelessWidget {
  const DashboardButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 44.0,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 3, // thickness
                          color: Color(0xFF444FFF) // color
                          ),
                      // border radius
                      borderRadius: BorderRadius.circular(25)),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              onPressed: () {},
              icon: Icon(
                Icons.save,
                color: Color(0xFF444FFF),
              ),
              label: const Text(
                'Analitycs',
                style: TextStyle(color: Colors.black),
              )),
        ),
        Gap(20),
        Container(
          height: 44.0,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 3, // thickness
                          color: Color(0xFF444FFF) // color
                          ),
                      // border radius
                      borderRadius: BorderRadius.circular(25)),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              onPressed: () {},
              icon: Icon(
                Icons.save,
                color: Color(0xFF444FFF),
              ),
              label: const Text(
                'Last Month',
                style: TextStyle(color: Colors.black),
              )),
        ),
      ],
    );
  }
}
