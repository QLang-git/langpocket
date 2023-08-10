import 'package:drift/drift.dart';

class Group extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get groupName => text().named('group_name')();
  IntColumn get level => integer().withDefault(const Constant(0))();
  DateTimeColumn get studyTime => dateTime().named('studyTime_time')();
  DateTimeColumn get creatingTime => dateTime().named('creating_time')();
}
