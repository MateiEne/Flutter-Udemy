import 'package:expense_planner/models/expense.dart';
import 'package:flutter/material.dart';

class OverlayScreen extends StatefulWidget {
  const OverlayScreen({
    Key? key,
    required this.onAddExpense,
  }) : super(key: key);

  final void Function(Expense expense) onAddExpense;

  @override
  _OverlayScreenState createState() => _OverlayScreenState();
}

class _OverlayScreenState extends State<OverlayScreen> {
  final TextEditingController _expenseTitleController = TextEditingController();
  final TextEditingController _expenseAmountController = TextEditingController();

  DateTime? _selectedDate;

  ExpenseCategory _category = ExpenseCategory.leisure;

  void _openCalendarModal() async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(
      now.year - 1,
      now.month,
      now.day,
    );
    final DateTime lastDate = DateTime(
      now.year + 1,
      now.month,
      now.day,
    );

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  bool _isValidInput() {
    final double? amount = double.tryParse(_expenseAmountController.text.trim());
    final bool isNotValidAmount = amount == null || amount <= 0;

    if (_expenseTitleController.text.trim().isEmpty || isNotValidAmount || _selectedDate == null) {
      return false;
    }

    return true;
  }

  void _presentAlertDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Invalid Input'),
        content: const Text('Please make sure that all of the fields are completed!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  void _saveExpense(BuildContext context) {
    if (!_isValidInput()) {
      _presentAlertDialog();
    } else {
      setState(() {
        widget.onAddExpense(
          Expense(
            title: _expenseTitleController.text,
            amount: double.tryParse(_expenseAmountController.text)!,
            date: _selectedDate!,
            category: _category,
          ),
        );
      });

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _expenseAmountController.dispose();
    _expenseTitleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _expenseTitleController,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
            maxLength: 50,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _expenseAmountController,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    prefixText: 'RON: ',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null ? 'No date selected' : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _openCalendarModal,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              DropdownButton(
                value: _category,
                items: ExpenseCategory.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value == null) {
                      return;
                    }

                    _category = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  _saveExpense(context);
                },
                child: const Text('Save expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
