import 'package:hive/hive.dart';

part 'course.g.dart';

@HiveType(typeId: 1)
class Course {
  @HiveField(0)
  String name;

  @HiveField(1)
  String location;

  @HiveField(2)
  String code;

  Course(this.name, this.location, this.code);
}