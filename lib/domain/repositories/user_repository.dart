import '../entities/user.dart';
import '../entities/user_progress.dart';

abstract class UserRepository {
  Future<User> getUserProfile(String userId);
  Future<void> updateUserProfile(User user);
  Future<void> updateStreak(String userId, int streakCount);
  Future<List<UserProgress>> getUserProgress(String userId);
}