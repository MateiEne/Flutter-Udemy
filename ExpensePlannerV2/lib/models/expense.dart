import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

final formatter = DateFormat.yMd();

enum ExpenseCategory {
  food,
  travel,
  leisure,
  work,
}

final Map<ExpenseCategory, IconData> categoryIcons = {
  ExpenseCategory.food: Icons.lunch_dining,
  ExpenseCategory.travel: Icons.flight_takeoff,
  ExpenseCategory.leisure: Icons.movie,
  ExpenseCategory.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;

  String get formattedDate => formatter.format(date);
}
