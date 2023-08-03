import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
import 'package:langpocket/src/data/remote/remote_group_repository.dart';

// showing words depending on auth to shows the local or remote words
class WordServices {
  final LocalGroupRepository localGroupRepository;
  final RemoteGroupRepository remoteGroupRepository;

  WordServices(
      {required this.localGroupRepository,
      required this.remoteGroupRepository});

  // get the group of words depending on the user auth
  var user = false;
  Stream<List<GroupData>> watchGroups() {
    if (user) {
      return remoteGroupRepository.watchGroups(0);
    } else {
      return localGroupRepository.watchGroups();
    }
  }

// save the words depending on auth
  Future<void> addNewWordInGroup(WordCompanion word) async {
    if (user) {
      await remoteGroupRepository.addNewWordInGroup(word, 0);
    } else {
      await localGroupRepository.addNewWordInGroup(word);
    }
  }

  //sets the geven group in the local or remote db depending on user satate
  // in remote or local
  Future<GroupData> createGroup(GroupCompanion newGroup) async {
    if (user) {
      return await remoteGroupRepository.createGroup(newGroup, 0);
    } else {
      return await localGroupRepository.createGroup(newGroup);
    }
  }

  Future<GroupData> fetchGroupByTime(DateTime now) async {
    if (user) {
      return await remoteGroupRepository.fetchGroupByTime(now, 0);
    } else {
      return await localGroupRepository.fetchGroupByTime(now);
    }
  }

  Stream<List<WordData>> watchWordsGroupId(int groupId) {
    if (user) {
      return remoteGroupRepository.watchWordsByGroupId(0);
    } else {
      return localGroupRepository.watchWordsByGroupId(groupId);
    }
  }

  Future<List<WordData>> fetchWordsByGroupId(int groupId) async {
    if (user) {
      return await remoteGroupRepository.fetchWordsByGroupId(0);
    } else {
      return await localGroupRepository.fetchWordsByGroupId(groupId);
    }
  }

  Future<void> updateGroupName(int groupId, String newName) async {
    if (user) {
      await remoteGroupRepository.updateGroupName(groupId, newName);
    } else {
      await localGroupRepository.updateGroupName(groupId, newName);
    }
  }

  Future<void> deleteWordById(int wordId, int groupId) async {
    if (user) {
      await remoteGroupRepository.deleteWordById(wordId);
    } else {
      await localGroupRepository.deleteWordById(wordId, groupId);
    }
  }

  Future<void> updateWordInfo(int wordId, WordCompanion wordCompanion) async {
    if (user) {
      await remoteGroupRepository.upadateWordInf(wordId, wordCompanion);
    } else {
      await localGroupRepository.updateWordInf(wordId, wordCompanion);
    }
  }

  Stream<WordData> watchWordById(int wordId) {
    if (user) {
      return remoteGroupRepository.watchWordById(wordId);
    } else {
      return localGroupRepository.watchWordById(wordId);
    }
  }

  Future<WordData> fetchWordById(int wordId) {
    if (user) {
      return remoteGroupRepository.fetchWordById(wordId);
    } else {
      return localGroupRepository.fetchWordById(wordId);
    }
  }

  Future<GroupData> fetchGroupById(int groupId) {
    if (user) {
      return remoteGroupRepository.fetchGroupById(groupId, 0);
    } else {
      return localGroupRepository.fetchGroupById(groupId);
    }
  }

  Future<List<WordData>> fetchAllWords() {
    if (user) {
      return remoteGroupRepository.fetchAllWords();
    } else {
      return localGroupRepository.fetchAllWords();
    }
  }
}

final wordsServicesProvider = Provider<WordServices>((ref) {
  final localRepository = ref.watch(localGroupRepositoryProvider);
  final remoteRepository = ref.watch(remoteGroupRepositoryProvider);
  return WordServices(
    localGroupRepository: localRepository,
    remoteGroupRepository: remoteRepository,
  );
});
