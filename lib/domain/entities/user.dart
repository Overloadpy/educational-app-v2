class User {
  final String id;
  final String email;
  final String grade;
  final String? stream;
  final String subscriptionStatus;
  final DateTime subscriptionExpiry;
  final int streakCount;
  final int totalPoints;

  User({
    required this.id,
    required this.email,
    required this.grade,
    this.stream,
    required this.subscriptionStatus,
    required this.subscriptionExpiry,
    required this.streakCount,
    required this.totalPoints,
  });
}