import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String email;

  @HiveField(1)
  String grade;

  @HiveField(2)
  String? stream;

  UserModel({
    required this.email,
    required this.grade,
    this.stream,
  });
}