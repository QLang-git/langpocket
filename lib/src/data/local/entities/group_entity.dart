import 'package:drift/drift.dart';

class Group extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get groupName => text().named('group_name')();
  DateTimeColumn get creatingTime => dateTime().named('creating_time')();
}
