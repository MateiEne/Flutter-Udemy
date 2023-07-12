import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(this.selectedAnswers, {Key? key}) : super(key: key);

  final List<String> selectedAnswers;

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Text(
        'Result Screen',
      ),
    );
  }
}
