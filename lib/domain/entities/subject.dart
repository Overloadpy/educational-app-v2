class Subject {
  final String id;
  final String name;
  final String grade;
  final String? stream;
  final String iconUrl;

  Subject({
    required this.id,
    required this.name,
    required this.grade,
    this.stream,
    required this.iconUrl,
  });
}