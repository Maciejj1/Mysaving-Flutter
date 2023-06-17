import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gap/gap.dart';

class DashboardSummaryRow extends StatelessWidget {
  const DashboardSummaryRow(
      {super.key,
      required this.titleText,
      required this.costs,
      required this.icon,
      required this.iconColor,
      required this.textcolor});
  final String titleText;
  final String costs;
  final IconData icon;
  final Color iconColor;
  final Color textcolor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  titleText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF969696),
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 25,
              ),
              Gap(7),
              Text(
                costs,
                style: TextStyle(color: textcolor, fontSize: 21),
              )
            ],
          )
        ],
      ),
    );
  }
}
