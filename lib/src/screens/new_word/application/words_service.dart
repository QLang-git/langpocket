import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/new_word/data/domain/group_words_model.dart';
import 'package:langpocket/src/screens/new_word/data/domain/utils/mutable_words.dart';
import 'package:langpocket/src/screens/new_word/data/domain/word_model.dart';
import 'package:langpocket/src/screens/new_word/data/domain/words_domain.dart';
import 'package:langpocket/src/screens/new_word/data/local/local_words_group_repository.dart';
import 'package:langpocket/src/screens/new_word/data/remote/remote_words_repository.dart';

// showing words depending on auth to shows the local or remote words
class WordsServices {
  //! you should add also auth repo here
  final LocalWordsRepository localWordsRepository;
  final RemoteWordsRepository remoteWordsRepository;
  var user;
  WordsServices(
      {required this.localWordsRepository,
      required this.remoteWordsRepository});

  // get the group of words depending on the user auth

  Future<Words> _fetchWords() {
    if (user) {
      return remoteWordsRepository.fetchWordsGroup('user id');
    } else {
      return localWordsRepository.fetchWordsGroup();
    }
  }

// save the words depending on auth
  Future<void> _setWords(Words words) async {
    if (user) {
      await remoteWordsRepository.setWordsGroup('user id', words);
    } else {
      await localWordsRepository.setWordsGroup(words);
    }
  }

  //sets the geven group in the local or remote db depending on user satate
  // in remote or local
  Future<void> setGroupWords(GroupWords group) async {
    final words = await _fetchWords();
    final updated = words.setGroup(group);
    await _setWords(updated);
  }

  //adds the geven group in the local or remote db depending on user satate
  // in remote or local
  Future<void> addGroupWords(GroupWords group) async {
    final words = await _fetchWords();
    final updated = words.addGroup(group);
    await _setWords(updated);
  }

  //removes the geven id group in the local or remote db depending on user state
  // in remote or local
  Future<void> removeGroupWords(String groupId) async {
    final words = await _fetchWords();
    final updated = words.removeGroupById(groupId);
    await _setWords(updated);
  }

//find list of words the geven group id in the local or remote db depending on user state
  Future<List<Word>> findWordListInGroup(String groupId) async {
    final words = await _fetchWords();
    final listwords = words.findWordListInGroupById(groupId);
    return listwords;
  }
}

final wordsServicesProvider = Provider<WordsServices>((ref) {
  return WordsServices(
      localWordsRepository: ref.watch(localWordsRepoProvider),
      remoteWordsRepository: ref.watch(remoteWordsRepoProvider));
});
