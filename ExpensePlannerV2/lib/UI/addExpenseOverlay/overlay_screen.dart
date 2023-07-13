import 'package:flutter/material.dart';

class OverlayScreen extends StatefulWidget {
  const OverlayScreen({Key? key}) : super(key: key);

  @override
  _OverlayScreenState createState() => _OverlayScreenState();
}

class _OverlayScreenState extends State<OverlayScreen> {
  final TextEditingController _expenseTitleController = TextEditingController();
  final TextEditingController _expenseAmountController = TextEditingController();

  @override
  void dispose() {
    _expenseAmountController.dispose();
    _expenseTitleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _expenseTitleController,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
            maxLength: 50,
          ),
          TextField(
            controller: _expenseAmountController,
            decoration: const InputDecoration(
              label: Text('Amount'),
              prefixText: 'RON: ',
            ),
            keyboardType: TextInputType.number,
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  print(_expenseTitleController.text);
                  print(_expenseAmountController.text);
                },
                child: const Text('Save title'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
