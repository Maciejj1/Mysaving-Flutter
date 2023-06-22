import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../common/utils/mysaving_colors.dart';

class ExpensesAddingForm extends StatefulWidget {
  ExpensesAddingForm({super.key});
  static const List<String> list = <String>[
    'Home',
    'Addictions',
    'Smoke',
    'Device',
    'Food'
  ];

  @override
  State<ExpensesAddingForm> createState() => _ExpensesAddingFormState();
}

class _ExpensesAddingFormState extends State<ExpensesAddingForm> {
  String dropdownValue = ExpensesAddingForm.list.first;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Dodaj Wydatek'),
          Gap(15),
          SizedBox(
            width: 250,
            child: Material(
              borderRadius: BorderRadius.circular(15),
              elevation: 5.0,
              shadowColor: Colors.blue,
              child: DropdownButtonFormField<String>(
                value: dropdownValue,
                elevation: 6,
                icon: Icon(Icons.arrow_downward),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                style: TextStyle(
                  color: MySavingColors.defaultBlueButton,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: ExpensesAddingForm.list
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: SizedBox(
                      width: 190,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(value),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Gap(10),
          SizedBox(
            width: 250,
            child: Material(
              borderRadius: BorderRadius.circular(15),
              elevation: 5.0,
              shadowColor: Colors.blue,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Nazwa',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ),
          Gap(10),
          SizedBox(
            width: 250,
            child: Material(
              borderRadius: BorderRadius.circular(15),
              elevation: 5.0,
              shadowColor: Colors.blue,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Koszt',
                  suffix: Text('.PLN'),
                  suffixStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 44,
            width: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF444FFF)),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                onPressed: () {},
                child: Text('Dodaj')),
          )
        ],
      ),
    );
  }
}
