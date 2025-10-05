import '../entities/quiz_question.dart';

abstract class QuizRepository {
  Future<List<QuizQuestion>> getQuizQuestions(String topicId);
  Future<void> saveQuizResult(String userId, String quizId, int score, int timeSpent);
}