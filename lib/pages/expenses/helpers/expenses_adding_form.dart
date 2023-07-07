import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mysavingapp/data/repositories/expenses_repository.dart';

import '../../../common/styles/mysaving_styles.dart';
import '../../../common/utils/mysaving_colors.dart';
import '../config/cubit/expense_cubit.dart';

class ExpensesAddingForm extends StatefulWidget {
  ExpensesAddingForm({Key? key});
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

  late ExpenseCubit expenseCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var msstyles = MySavingStyles(context);
    return BlocProvider(
      create: (context) =>
          ExpenseCubit(expensesRepository: ExpensesRepository()),
      child: Center(
        child: Column(
          children: [
            Text(
              'Dodaj Wydatek',
              style: TextStyle(color: MySavingColors.defaultGreyText),
            ),
            Gap(15),
            SizedBox(
              width: 250,
              child: Material(
                borderRadius: BorderRadius.circular(15),
                elevation: 5.0,
                shadowColor: MySavingColors.defaultBlueButton,
                child: DropdownButtonFormField<String>(
                  value: dropdownValue,
                  elevation: 6,
                  icon: Icon(Icons.arrow_downward),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: MySavingColors.defaultCategories,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    border: msstyles.mysavingExpensesAddingFormInputBorder,
                  ),
                  style: TextStyle(
                    color: MySavingColors.defaultExpensesText,
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
                shadowColor: MySavingColors.defaultBlueButton,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nazwa',
                    filled: true,
                    fillColor: MySavingColors.defaultCategories,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    border: msstyles.mysavingExpensesAddingFormInputBorder,
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
                shadowColor: MySavingColors.defaultBlueButton,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Koszt',
                    suffix: Text('.PLN'),
                    suffixStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: MySavingColors.defaultGreyText),
                    filled: true,
                    fillColor: MySavingColors.defaultCategories,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    border: msstyles.mysavingExpensesAddingFormInputBorder,
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
              decoration: msstyles.mysavingButtonContainerStyles,
              child: ElevatedButton(
                style: msstyles.mysavingButtonStyles,
                onPressed: () {
                  final name = ''; // Pobierz wartość nazwy z pola tekstowego
                  final cost = 0; // Pobierz wartość kosztu z pola tekstowego
                  final categoryId = 0; // Pobierz wartość kategorii z dropdownu
                  expenseCubit.addExpense(name, cost, categoryId);
                },
                child: Text('Dodaj'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
