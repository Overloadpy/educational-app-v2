class QuizQuestion {
  final String id;
  final String topicId;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;
  final String difficulty;

  QuizQuestion({
    required this.id,
    required this.topicId,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
    required this.difficulty,
  });
}