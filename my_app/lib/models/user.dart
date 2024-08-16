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

  @HiveField(4)
  final String memberType;

  @HiveField(5)
  final int generation;

  User({
    required this.email,
    required this.name,
    required this.password,
    required this.joinYear,
    required this.memberType,
    required this.generation,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'joinYear': joinYear,
      'memberType': memberType,
      'generation': generation,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      name: map['name'],
      password: map['password'],
      joinYear: map['joinYear'],
      memberType: map['memberType'],
      generation: map['generation'],
    );
  }
}
