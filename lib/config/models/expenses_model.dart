import 'package:flutter/foundation.dart';

class Expenses {
  int id;
  int costs;
  List<Category> categories;

  Expenses({required this.id, required this.costs, required this.categories});
}
