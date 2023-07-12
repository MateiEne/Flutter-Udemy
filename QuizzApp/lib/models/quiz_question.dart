class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> getAnswersShuffled() {
    List<String> shuffledAnswers = [];
    for (int i = 0; i < answers.length; i++) {
      shuffledAnswers.add(answers[i]);
    }
    shuffledAnswers.shuffle();

    return shuffledAnswers;
  }
}