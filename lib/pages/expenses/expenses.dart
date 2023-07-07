import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mysavingapp/common/helpers/mysaving_nav.dart';
import 'package:mysavingapp/data/models/expenses_model.dart';
import 'package:mysavingapp/data/repositories/expenses_repository.dart';
import 'package:mysavingapp/pages/expenses/config/cubit/expense_cubit.dart';
import 'package:mysavingapp/pages/expenses/helpers/expenses_adding_form.dart';
import 'package:mysavingapp/pages/expenses/helpers/expenses_categories_column_list.dart';
import 'package:mysavingapp/pages/expenses/helpers/expenses_categories_row_list.dart';
import 'package:flutter/services.dart';
import '../../common/styles/mysaving_styles.dart';
import '../../common/utils/mysaving_colors.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  TextEditingController _nameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _costController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MySavingColors.defaultBackgroundPage,
      body: SafeArea(
        child: SingleChildScrollView(
            child: BlocProvider<ExpenseCubit>(
          create: (context) =>
              ExpenseCubit(expensesRepository: ExpensesRepository())
                ..getSummary(),
          child: blocBody(),
        )),
      ),
    );
  }

  Widget blocBody() {
    return BlocConsumer<ExpenseCubit, ExpenseState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is ExpenseSuccess) {
          List<Expenses> expenses = state.expenses;
          List<Category> categories =
              expenses.expand((element) => element.categories).toList();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MySavingUpNav(),
              SizedBox(
                height: 20,
              ),
              ExpensesCategoriesRowList(),
              ExpensesCategoriesColumnList(),
              addingForm(categories),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget addingForm(List<Category> categories) {
    String? dropdownValue;
    var msstyles = MySavingStyles(context);
    return BlocConsumer<ExpenseCubit, ExpenseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: _formKey,
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
                    child: DropdownButtonFormField<Category>(
                      value: dropdownValue != null
                          ? categories.firstWhere((category) =>
                              category.id.toString() == dropdownValue)
                          : null,
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
                      onChanged: (Category? value) {
                        setState(() {
                          dropdownValue =
                              value != null ? value.id.toString() : null;
                        });
                      },
                      items: categories
                          .map<DropdownMenuItem<Category>>((Category category) {
                        return DropdownMenuItem<Category>(
                          value: category,
                          child: SizedBox(
                            width: 190,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(category.name!),
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
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Nazwa',
                        filled: true,
                        fillColor: MySavingColors.defaultCategories,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: msstyles.mysavingExpensesAddingFormInputBorder,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nazwa nie może być pusta.';
                        }
                        return null;
                      },
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
                      controller: _costController,
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
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Koszt nie może być pusty.';
                        }
                        return null;
                      },
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
                      if (_formKey.currentState!.validate()) {
                        final name = _nameController.text;
                        final cost = int.parse(_costController.text);
                        final categoryId = dropdownValue != null
                            ? int.parse(dropdownValue!)
                            : null;
                        if (categoryId != null) {
                          context
                              .read<ExpenseCubit>()
                              .addExpense(name, cost, categoryId);
                        }
                      }
                    },
                    child: Text('Dodaj'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
