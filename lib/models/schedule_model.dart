import 'package:hive/hive.dart';
part 'schedule_model.g.dart';

@HiveType(typeId: 1)
class ScheduleModel extends HiveObject {
  @HiveField(0)
  String subjectName;

  @HiveField(1)
  String date;

  @HiveField(2)
  String startTime;

  @HiveField(3)
  String endTime;

  @HiveField(4)
  bool isPresent;

  ScheduleModel({required this.subjectName, required this.date, required this.startTime, required this.endTime, required this.isPresent});
}