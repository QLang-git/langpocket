import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
import 'package:langpocket/src/data/remote/remote_group_repository.dart';

// showing words depending on auth to shows the local or remote words
class WordsServices {
  //! you should add also auth repo here
  final LocalGroupRepository _localGroupRepository;
  final RemoteGroupRepository _remoteWordsRepository;
  var user;
  WordsServices(
      {required LocalGroupRepository localGroupRepository,
      required RemoteGroupRepository remoteWordsRepository})
      : _remoteWordsRepository = remoteWordsRepository,
        _localGroupRepository = localGroupRepository;

  // get the group of words depending on the user auth

  Future<List<GroupData>> fetchGrops() async {
    if (user) {
      return await _remoteWordsRepository.fetchGroups(0);
    } else {
      return await _localGroupRepository.fetchGroups();
    }
  }

// save the words depending on auth
  Future<WordData> addNewWords(WordCompanion word) async {
    if (user) {
      return await _remoteWordsRepository.addNewWordInGroup(word, 0);
    } else {
      return await _localGroupRepository.addNewWordInGroup(word);
    }
  }

  //sets the geven group in the local or remote db depending on user satate
  // in remote or local
  Future<GroupData> createGroup(GroupCompanion newGroup) async {
    if (user) {
      return await _remoteWordsRepository.createGroup(newGroup, 0);
    } else {
      return await _localGroupRepository.createGroup(newGroup);
    }
  }

  Future<GroupData> fetchGroupByTime(DateTime now) async {
    if (user) {
      return await _remoteWordsRepository.fetchGroupByTime(now, 0);
    } else {
      return await _localGroupRepository.fetchGroupByTime(now);
    }
  }
}

final wordsServicesProvider = Provider<WordsServices>((ref) {
  return WordsServices(
      localGroupRepository: ref.watch(localGroupRepositoryProvider),
      remoteWordsRepository: ref.watch(remoteGroupRepositoryProvider));
});
