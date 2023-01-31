// web.dart
import 'package:drift/web.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';

DriftGroupRepository constructDb() {
  return DriftGroupRepository(WebDatabase('db'));
}
