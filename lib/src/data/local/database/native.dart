import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:path_provider/path_provider.dart';

DriftGroupRepository constructDb() {
  final db = LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
  return DriftGroupRepository(db);
}
