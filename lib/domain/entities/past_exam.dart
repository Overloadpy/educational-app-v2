class PastExam {
  final String id;
  final String subjectId;
  final String title;
  final int year;
  final int totalQuestions;
  final String? fileUrl;

  PastExam({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.year,
    required this.totalQuestions,
    this.fileUrl,
  });
}