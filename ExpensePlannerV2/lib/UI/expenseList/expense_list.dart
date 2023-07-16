import 'package:expense_planner/UI/expenseList/expense_list_item.dart';
import 'package:expense_planner/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    Key? key,
    required this.expenses,
    required this.onRemoveExpense,
  }) : super(key: key);

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[index].id),
        child: ExpenseListItem(expense: expenses[index]),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
      ),
    );
  }
}
