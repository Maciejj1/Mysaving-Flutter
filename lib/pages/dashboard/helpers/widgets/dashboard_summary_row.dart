import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DashboardSummaryRow extends StatelessWidget {
  const DashboardSummaryRow(
      {super.key,
      required this.titleText,
      required this.costs,
      required this.icon});
  final String titleText;
  final String costs;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Text(
            titleText,
          ),
          Row(
            children: [Icon(icon), Text(costs)],
          )
        ],
      ),
    );
  }
}
