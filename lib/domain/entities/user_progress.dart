class UserProgress {
  final String id;
  final String userId;
  final String entityType;
  final String entityId;
  final int? score;
  final DateTime completedAt;
  final int timeSpent;

  UserProgress({
    required this.id,
    required this.userId,
    required this.entityType,
    required this.entityId,
    this.score,
    required this.completedAt,
    required this.timeSpent,
  });
}