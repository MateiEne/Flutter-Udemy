import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_questions_screen.dart';
import 'package:quiz_app/result_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Widget? currentScreen;

  @override
  void initState() {
    currentScreen = StartScreen(
      onStartQuizButtonTap: changeScreen,
    );

    super.initState();
  }

  void onQuestionsEnded(List<String> answers) {
    setState(() {
      currentScreen = ResultScreen(answers);
    });
  }

  void changeScreen() {
    setState(() {
      currentScreen = QuizQuestionsScreen(
        onQuestionsEnded: onQuestionsEnded,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.deepPurple,
                Colors.deepPurpleAccent,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: currentScreen,
        ),
      ),
    );
  }
}
