import 'package:langpocket/src/data/local/entities/word_entity.dart';
import 'package:langpocket/src/data/local/repository/insert_default_data.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
import 'package:drift/drift.dart';
import 'package:langpocket/src/data/local/entities/group_entity.dart';
part 'drift_group_repository.g.dart';

@DriftDatabase(tables: [Group, Word])
class DriftGroupRepository extends _$DriftGroupRepository
    implements LocalGroupRepository {
  final bool isTesting;
  final QueryExecutor queryExecutor;
  // we tell the database where to store the data with this constructor
  DriftGroupRepository(this.queryExecutor, {this.isTesting = false})
      : super(queryExecutor);

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        // Make sure that foreign keys are enabled
        await customStatement('PRAGMA foreign_keys = ON');
        if (details.wasCreated && !isTesting) {
          await batch((batch) {
            batch.insertAll(group, defaultGroups);
            batch.insertAll(word, defaultWords);
          });
        }
      },
    );
  }

  @override
  Future<void> addNewWordInGroup(WordCompanion newWord) async {
    await word.insertOne(newWord);
    //await into(word).insert(newWord);
  }

  @override
  Future<GroupData> createGroup(GroupCompanion newGroup) async {
    return await group.insertReturning(newGroup);
    //return await into(group).insertReturning(newGroup);
  }

  @override
  Future<GroupData> fetchGroupById(int groupId) async {
    return await (select(group)..where((group) => group.id.equals(groupId)))
        .getSingle();
  }

  @override
  Future<List<GroupData>> fetchGroups() async => await select(group).get();
  @override
  Future<WordData> fetchWordById(int wordId) async =>
      await (select(word)..where((word) => word.id.equals(wordId))).getSingle();

  @override
  Stream<GroupData> watchGroupById(int groupId) =>
      (select(group)..where((tbl) => tbl.id.equals(groupId))).watchSingle();

  @override
  Stream<List<GroupData>> watchGroups() {
    return select(group).watch();
  }

  @override
  Future<GroupData> fetchGroupByTime(DateTime now) async {
    // get the group
    return await (select(group)
          ..where((group) => group.creatingTime.day.equals(now.day))
          ..where((group) => group.creatingTime.month.equals(now.month))
          ..where((group) => group.creatingTime.year.equals(now.year)))
        .getSingle();
  }

  @override
  Stream<List<WordData>> watchWordsByGroupId(int groupId) {
    return (select(word)..where((tbl) => tbl.group.equals(groupId))).watch();
  }

  @override
  Future<List<WordData>> fetchWordsByGroupId(int groupId) async =>
      await (select(word)..where((tbl) => tbl.group.equals(groupId))).get();

  @override
  Future<void> updateGroupName(int groupId, String newName) async {
    await (update(group)..where((tbl) => tbl.id.equals(groupId)))
        .write(GroupCompanion(groupName: Value(newName)));
  }

  @override
  Future<void> deleteWordById(int wordId, int groupId) async {
    await (delete(word)..where((tbl) => tbl.id.equals(wordId))).go();
    final otherWords = await fetchWordsByGroupId(groupId);
    if (otherWords.isEmpty) {
      await (delete(group)..where((tbl) => tbl.id.equals(groupId))).go();
    }
  }

  @override
  Future<void> updateWordInf(int wordId, WordCompanion wordCompanion) async {
    await (update(word)..where((tbl) => tbl.id.equals(wordId)))
        .write(wordCompanion);
  }

  @override
  Stream<WordData> watchWordById(int wordId) {
    return (select(word)..where((tbl) => tbl.id.equals(wordId))).watchSingle();
  }

  @override
  Future<List<WordData>> fetchAllWords() async {
    return await select(word).get();
  }
}
