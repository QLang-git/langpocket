import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/new_word/data/domain/words_domain.dart';

abstract class RemoteWordsRepository {
  Future<Words> fetchWordsGroup(String uid);
  Stream<Words> watchWordsGroup(String uid);
  Future<void> setWordsGroup(String uid, Words newWords);
}

final remoteWordsRepoProvider = Provider<RemoteWordsRepository>((ref) {
  // * Override this in the main method
  throw UnimplementedError();
});
