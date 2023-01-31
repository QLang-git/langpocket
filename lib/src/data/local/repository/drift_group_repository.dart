import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:langpocket/src/data/local/entities/word_entity.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
import 'package:langpocket/src/data/modules/word_module.dart';
import 'package:langpocket/src/data/modules/group_module.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:drift/drift.dart';

import 'package:langpocket/src/data/local/entities/group_entity.dart';

part 'drift_group_repository.g.dart';

@DriftDatabase(tables: [Group, Word])
class DriftGroupRepository extends _$DriftGroupRepository
    implements LocalGroupRepository {
  // we tell the database where to store the data with this constructor
  DriftGroupRepository(QueryExecutor e) : super(e);

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  @override
  Future<WordData> addNewWordInGroup(WordCompanion newWord) async {
    return into(word).insertReturning(newWord);
  }

  @override
  Future<GroupData> createGroup(GroupCompanion newGroup) async {
    return into(group).insertReturning(newGroup);
  }

  @override
  Future<GroupData> fetchGroupById(int groupId) {
    return (select(group)..where((group) => group.id.equals(groupId)))
        .getSingle();
  }

  @override
  Future<List<GroupData>> fetchGroups() => select(group).get();
  @override
  Future<WordData> fetchWordbyId(int wordId) =>
      (select(word)..where((word) => word.id.equals(wordId))).getSingle();

  @override
  Stream<GroupData> watchGroupById(int groupId) =>
      (select(group)..where((tbl) => tbl.id.equals(groupId))).watchSingle();

  @override
  Stream<List<GroupData>> watchGroups() => select(group).watch();

  @override
  Future<GroupData> fetchGroupByTime(DateTime now) {
    // get the group
    return (select(group)
          ..where((group) => group.creatingTime.day.equals(now.day))
          ..where((group) => group.creatingTime.month.equals(now.month))
          ..where((group) => group.creatingTime.year.equals(now.year)))
        .getSingle();
  }
}
