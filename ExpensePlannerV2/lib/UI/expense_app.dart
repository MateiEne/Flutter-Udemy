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
      title: 'test',
      amount: 25,
      date: DateTime.now(),
      category: ExpenseCategory.food,
    ),
    Expense(
      title: 'test2',
      amount: 25,
      date: DateTime.now(),
      category: ExpenseCategory.food,
    ),
  ];

  Widget? mainScreen;

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (modalBottomSheetContext) => OverlayScreen(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = expenses.indexOf(expense);

    setState(() {
      expenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              expenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (expenses.isNotEmpty) {
      mainScreen = ExpenseList(
        expenses: expenses,
        onRemoveExpense: _removeExpense,
      );
    } else {
      mainScreen = const Center(
        child: Text('No expenses added yet. Start adding some!'),
      );
    }

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
            child: mainScreen!,
          ),
        ],
      ),
    );
  }
}
