
import 'package:hive/hive.dart';
import 'package:ums/models/schedule_model.dart';

class ScheduleBoxes {
  static Box<ScheduleModel> getData() => Hive.box<ScheduleModel>('schedule');
}