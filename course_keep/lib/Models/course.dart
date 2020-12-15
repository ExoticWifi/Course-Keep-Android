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

  @HiveField(3)
  String section;

  @HiveField(4)
  int hours;

  @HiveField(5)
  bool sunday;

  @HiveField(6)
  bool monday;

  @HiveField(7)
  bool tuesday;

  @HiveField(8)
  bool wednesday;

  @HiveField(9)
  bool thursday;

  @HiveField(10)
  bool friday;

  @HiveField(11)
  bool saturday;

  @HiveField(12)
  String startTime;

  @HiveField(13)
  String endTime;

  Course(this.name, this.location, this.code, this.hours, this.section, this.sunday, this.monday, this.tuesday, this.wednesday, this.thursday, this.friday, this.saturday, this.startTime, this.endTime);
}