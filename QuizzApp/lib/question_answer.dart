import 'package:flutter/material.dart';

class QuestionAnswer extends StatelessWidget {
  const QuestionAnswer({
    required this.text,
    required this.onAnswerTap,
    Key? key,
  }) : super(key: key);

  final String text;
  final void Function(String answer) onAnswerTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
        onPressed: () {
          onAnswerTap(text);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black38,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
