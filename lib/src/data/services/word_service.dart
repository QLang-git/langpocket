import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
import 'package:langpocket/src/utils/auth/auth_repository.dart';
import 'package:langpocket/src/utils/background_works.dart';

// showing words depending on auth to shows the local or remote words
class WordServices {
  final LocalGroupRepository localGroupRepository;
  final BackgroundWorks backgroundWorks;
  final AuthRepository authRepository;

  WordServices(
      {required this.localGroupRepository,
      required this.backgroundWorks,
      required this.authRepository});

  // get the group of words depending on the user auth
  var user = false;
  Stream<List<GroupData>> watchGroups() {
    backgroundWorks.pullOut();
    return localGroupRepository.watchGroups();
  }

// todo: 10 words => no account
// todo: 25 words => free account
  Future<void> addNewWordInGroup(WordCompanion word) async {
    await localGroupRepository.addNewWordInGroup(word);
    backgroundWorks.pushIn();
  }

// todo: 5 words => no account
// todo: 30 words => free account
  Future<GroupData> createGroup(GroupCompanion newGroup) async {
    return await localGroupRepository.createGroup(newGroup);
  }

  Future<GroupData> fetchGroupByTime(DateTime now) async {
    return await localGroupRepository.fetchGroupByTime(now);
  }

  Stream<List<WordData>> watchWordsGroupId(int groupId) {
    return localGroupRepository.watchWordsByGroupId(groupId);
  }

  Future<List<WordData>> fetchWordsByGroupId(int groupId) async {
    return await localGroupRepository.fetchWordsByGroupId(groupId);
  }

//!change
  Future<void> updateGroupName(int groupId, String newName) async {
    await localGroupRepository.updateGroupName(groupId, newName);
    backgroundWorks.pushIn();
  }

//! change
  Future<void> deleteWordById(int wordId, int groupId) async {
    await localGroupRepository.deleteWordById(wordId, groupId);
    backgroundWorks.pushIn();
  }

//! change
  Future<void> updateWordInfo(int wordId, WordCompanion wordCompanion) async {
    await localGroupRepository.updateWordInf(wordId, wordCompanion);
    backgroundWorks.pushIn();
  }

  Stream<WordData> watchWordById(int wordId) {
    return localGroupRepository.watchWordById(wordId);
  }

  Future<WordData> fetchWordById(int wordId) {
    return localGroupRepository.fetchWordById(wordId);
  }

  Future<GroupData> fetchGroupById(int groupId) {
    return localGroupRepository.fetchGroupById(groupId);
  }

  Future<List<WordData>> fetchAllWords() {
    return localGroupRepository.fetchAllWords();
  }

  Future<List<GroupData>> fetchAllGroups() {
    return localGroupRepository.fetchAllGroups();
  }

//! change
  Future<void> updateGroupLevel(
      int groupId, GroupCompanion groupCompanion) async {
    await localGroupRepository.updateGroupLevel(groupId, groupCompanion);
    backgroundWorks.pushIn();
  }

  //todo :: serve the ads to free users
}

final wordsServicesProvider = Provider<WordServices>((ref) {
  final localRepository = ref.watch(localGroupRepositoryProvider);
  final auth = ref.watch(authRepositoryProvider);
  return WordServices(
      localGroupRepository: localRepository,
      backgroundWorks: BackgroundWorks(),
      authRepository: auth);
});
