import 'package:expense_planner/UI/addExpenseOverlay/overlay_screen.dart';
import 'package:expense_planner/UI/expenseList/expense_list.dart';
import 'package:expense_planner/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseApp extends StatefulWidget {
  const ExpenseApp({Key? key}) : super(key: key);

  @override
  _ExpenseAppState createState() => _ExpenseAppState();
}

class _ExpenseAppState extends State<ExpenseApp> {
  final List<Expense> expenses = [
    Expense(
      title: 'hamburger',
      amount: 30.5,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'plane tickets',
      amount: 80.132,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  void _openAddExpenseOverlay() {
    print('intrat');

    showModalBottomSheet(
      context: context,
      builder: (modalBottomSheetContext) => const OverlayScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('Chart'),
          Expanded(
            child: ExpenseList(expenses: expenses),
          ),
        ],
      ),
    );
  }
}
