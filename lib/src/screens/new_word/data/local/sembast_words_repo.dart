import 'package:flutter/foundation.dart';
import 'package:langpocket/src/screens/new_word/data/domain/words_domain.dart';
import 'package:langpocket/src/screens/new_word/data/local/local_words_group_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastWordsRepo implements LocalWordsRepository {
  final Database db;
  final store = StoreRef.main();

  SembastWordsRepo(this.db);

  static Future<Database> createDatabase(String filename) async {
    if (!kIsWeb) {
      final appDocDir = await getApplicationDocumentsDirectory();
      return databaseFactoryIo.openDatabase('${appDocDir.path}/$filename');
    } else {
      return databaseFactoryWeb.openDatabase(filename);
    }
  }

// default db when you open the app
  static Future<SembastWordsRepo> makeDefault() async {
    return SembastWordsRepo(await createDatabase('default.db'));
  }

  static const groupsKey = 'newWordKey';
  @override
  Future<Words> fetchWordsGroup() async {
    final newWordJson = await store.record(groupsKey).get(db) as String?;
    if (newWordJson != null) {
      return Words.fromJson(groupsKey);
    } else {
      return const Words();
    }
  }

  @override
  Future<void> setWordsGroup(Words words) {
    return store.record(groupsKey).put(db, words.toJson());
  }

  @override
  Stream<Words> watchWordsGroup() {
    final record = store.record(groupsKey);
    return record.onSnapshot(db).map((snapshot) {
      if (snapshot != null) {
        return Words.fromJson(snapshot.value.toString());
      } else {
        return const Words();
      }
    });
  }
}
