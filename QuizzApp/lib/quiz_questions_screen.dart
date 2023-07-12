import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/models/quiz_question.dart';
import 'package:quiz_app/question_answer.dart';

class QuizQuestionsScreen extends StatefulWidget {
  QuizQuestionsScreen({required this.onQuestionsEnded, Key? key}) : super(key: key);

  void Function(List<String> anserws) onQuestionsEnded;

  @override
  _QuizQuestionsScreenState createState() => _QuizQuestionsScreenState();
}

class _QuizQuestionsScreenState extends State<QuizQuestionsScreen> {
  int currentQuestionIndex = 0;

  final List<String> selectedAnswers = [];

  void changeQuestion(String answer) {
    setState(() {
      currentQuestionIndex++;

      selectedAnswers.add(answer);

      if (selectedAnswers.length == questions.length) {
        widget.onQuestionsEnded(selectedAnswers);
      }
    });
  }

  // TO DO: save the results ansewers in a list

  @override
  Widget build(BuildContext context) {
    QuizQuestion currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              currentQuestion.text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ...currentQuestion.getAnswersShuffled().map((answer) {
              return QuestionAnswer(text: answer, onAnswerTap: changeQuestion);
            }),
          ],
        ),
      ),
    );
  }
}
