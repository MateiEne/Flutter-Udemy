import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/results_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(this.selectedAnswers, this.onRestartButtonPressed, {Key? key}) : super(key: key);

  final List<String> selectedAnswers;
  final void Function() onRestartButtonPressed;

  List<Map<String, Object>> getSummaryData() {
    List<Map<String, Object>> summary = [];

    for (int i = 0; i < selectedAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'selected_answer': selectedAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> summaryData = getSummaryData();

    final int numOfAnswers = selectedAnswers.length;
    final int numOfCorrectAnswers = summaryData.where((data) {
      return data['correct_answer'] == data['selected_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have answered $numOfCorrectAnswers out of $numOfAnswers questions correctly!',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white60),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            ResultsSummary(
              summaryData: summaryData,
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: onRestartButtonPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(
                Icons.refresh,
              ),
              label: const Text(
                'Restart Quiz',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
