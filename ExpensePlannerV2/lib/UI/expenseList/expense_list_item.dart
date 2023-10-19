import 'package:expense_planner/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({
    Key? key,
    required this.expense,
  }) : super(key: key);

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text('RON ${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Icon(
                  categoryIcons[expense.category],
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Text(expense.formattedDate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
