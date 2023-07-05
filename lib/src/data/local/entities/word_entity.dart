import 'package:drift/drift.dart';
import 'package:langpocket/src/data/local/entities/group_entity.dart';

class Word extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get group => integer().references(Group, #id)();
  TextColumn get foreignWord => text().named('foreign_word')();
  TextColumn get wordMeans => text().named('means')();
  TextColumn get wordImages => text().named('images')();
  TextColumn get wordExamples => text().named('examples')();
  TextColumn get wordNote => text().named('note')();
  DateTimeColumn get wordDate => dateTime().named('date')();
}
