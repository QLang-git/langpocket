import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
import 'package:langpocket/src/utils/auth/auth_repository.dart';

// showing words depending on auth to shows the local or remote words
class WordServices {
  final LocalGroupRepository localGroupRepository;
  final AuthRepository authRepository;

  WordServices({
    required this.localGroupRepository,
    required this.authRepository,
  });

  Stream<List<GroupData>> watchGroups() {
    // backgroundWorks.pullOut();
    // authRepository.getCurrentUser();
    return localGroupRepository.watchGroups();
  }

  Future<void> addNewWordInGroup(WordCompanion word) async {
    final user = await authRepository.getCurrentUser();
    if (user != null && user.isPro) {
      await localGroupRepository.addNewWordInGroup(word);
      return;
    }
    final currentWord = await fetchAllWords();

    if (user != null && !user.isPro) {
      if (currentWord.length > 25) {
        throw Exception(
            'To add more than 25 words, please subscribe to support and improve the app.');
      } else {
        await localGroupRepository.addNewWordInGroup(word);
      }
    }
    if (user == null) {
      if (currentWord.length > 10) {
        throw Exception('You must be logged in to add more than 10 words');
      } else {
        await localGroupRepository.addNewWordInGroup(word);
      }
    }
  }

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
  }

//! change
  Future<void> deleteWordById(int wordId, int groupId) async {
    await localGroupRepository.deleteWordById(wordId, groupId);
  }

//! change
  Future<void> updateWordInfo(int wordId, WordCompanion wordCompanion) async {
    await localGroupRepository.updateWordInf(wordId, wordCompanion);
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
  }

  //todo :: serve the ads to free users
}

final wordsServicesProvider = Provider<WordServices>((ref) {
  final localRepository = ref.watch(localGroupRepositoryProvider);
  final auth = ref.watch(authRepositoryProvider);
  return WordServices(
      localGroupRepository: localRepository, authRepository: auth);
});
