import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mysavingapp/common/utils/mysaving_colors.dart';

class DashboardCurrencyPicker extends StatefulWidget {
  const DashboardCurrencyPicker({super.key});

  @override
  State<DashboardCurrencyPicker> createState() =>
      _DashboardCurrencyPickerState();
}

class _DashboardCurrencyPickerState extends State<DashboardCurrencyPicker> {
  String dropdownValue = list.first;
  static const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              width: 72,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white, //background color of dropdown button

                borderRadius: BorderRadius.circular(
                    12), //border raiuds of dropdown button
              ),
              child: DropdownButton<String>(
                value: dropdownValue,
                iconSize: 0,
                elevation: 6,
                style: TextStyle(
                    color: MySavingColors.defaultBlueButton,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: SizedBox(
                      width: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(value),
                          Icon(
                            Icons.arrow_downward,
                            size: 18,
                            color: MySavingColors.defaultBlueButton,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ))
        ],
      ),
    );
  }
}
