import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
import 'package:langpocket/src/data/remote/remote_group_repository.dart';

// showing words depending on auth to shows the local or remote words
class WordsServices {
  final Ref ref;

  WordsServices({required this.ref});

  _StatesDependencies _initialStates() {
    final local = ref.watch(localGroupRepositoryProvider);
    final remote = ref.watch(remoteGroupRepositoryProvider);
    return _StatesDependencies(
      localGroupRepository: local,
      remoteGroupRepository: remote,
    );
  }

  // get the group of words depending on the user auth
  var user = false;
  Future<List<GroupData>> fetchGrops() async {
    final states = _initialStates();
    if (user) {
      return await states.remoteGroupRepository.fetchGroups(0);
    } else {
      return await states.localGroupRepository.fetchGroups();
    }
  }

// save the words depending on auth
  Future<void> addNewWordInGroup(WordCompanion word) async {
    final states = _initialStates();
    if (user) {
      await states.remoteGroupRepository.addNewWordInGroup(word, 0);
    } else {
      await states.localGroupRepository.addNewWordInGroup(word);
    }
  }

  //sets the geven group in the local or remote db depending on user satate
  // in remote or local
  Future<GroupData> createGroup(GroupCompanion newGroup) async {
    final states = _initialStates();
    if (user) {
      return await states.remoteGroupRepository.createGroup(newGroup, 0);
    } else {
      return await states.localGroupRepository.createGroup(newGroup);
    }
  }

  Future<GroupData> fetchGroupByTime(DateTime now) async {
    final states = _initialStates();
    if (user) {
      return await states.remoteGroupRepository.fetchGroupByTime(now, 0);
    } else {
      return await states.localGroupRepository.fetchGroupByTime(now);
    }
  }
}

final wordsServicesProvider =
    Provider.autoDispose<WordsServices>((ref) => WordsServices(ref: ref));

class _StatesDependencies {
  final LocalGroupRepository localGroupRepository;
  final RemoteGroupRepository remoteGroupRepository;

  _StatesDependencies(
      {required this.localGroupRepository,
      required this.remoteGroupRepository});
}
