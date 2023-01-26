import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/new_word/data/domain/words_domain.dart';

abstract class LocalWordsRepository {
  Future<Words> fetchWordsGroup();
  Stream<Words> watchWordsGroup();
  Future<void> setWordsGroup(Words newWords);
}

final localWordsRepoProvider = Provider<LocalWordsRepository>((ref) {
  // * Override this in the main method
  throw UnimplementedError();
});
