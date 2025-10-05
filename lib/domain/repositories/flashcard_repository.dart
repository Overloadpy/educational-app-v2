import '../entities/flashcard.dart';

abstract class FlashcardRepository {
  Future<List<Flashcard>> getFlashcards(String topicId);
  Future<void> markFlashcardAsStudied(String userId, String flashcardId);
}