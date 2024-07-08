import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final int joinYear;

  User({
    required this.email,
    required this.name,
    required this.password,
    required this.joinYear,
  });

  int get generation => joinYear - 1979 + 1;
}
