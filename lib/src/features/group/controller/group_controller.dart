import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/data/services/word_service.dart';
import 'package:langpocket/src/features/word_edit/controller/word_editor_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

// Define a class to hold your state
class InfoState {
  final List<WordRecord> wordsData;
  final GroupData groupData;

  InfoState({required this.wordsData, required this.groupData});
}

final groupControllerProvider = StateNotifierProvider.autoDispose
    .family<GroupController, AsyncValue<InfoState>, int>((ref, groupId) {
  final wordService = ref.watch(wordsServicesProvider);
  ref.watch(wordEditorProvider);
  return GroupController(wordService: wordService, groupId: groupId);
});

class GroupController extends StateNotifier<AsyncValue<InfoState>> {
  WordServices wordService;
  int groupId;
  GroupController({required this.wordService, required this.groupId})
      : super(const AsyncLoading()) {
    getWords();
  }

  void getWords() async {
    if (mounted) {
      state = const AsyncLoading();
    }
    final wordInfo = await AsyncValue.guard(() async {
      final group = await wordService.fetchGroupById(groupId);
      final wordsFuture = await wordService.fetchWordsByGroupId(groupId);
      final words = wordsFuture.map((element) => element.decoding()).toList();
      return InfoState(groupData: group, wordsData: words);
    });
    if (mounted) {
      state = wordInfo;
    }
  }

  void deleteWord(int wordId) async {
    await wordService.deleteWordById(wordId, groupId);
  }

  // app bar
  Future<bool> editGroupName(
    String groupName,
    TextEditingController controller,
    BuildContext context,
    GlobalKey<FormState> inputKey,
    ValueChanged<bool> onEditModeActivating,
  ) async {
    if (groupName != controller.text) {
      return await _updateGroupName(controller.text, inputKey, context);
      // newGroupName(controller.text);
    }
    onEditModeActivating(false);
    return false;
  }

  Future<bool> _updateGroupName(String newName, GlobalKey<FormState> inputKey,
      BuildContext context) async {
    if (!inputKey.currentState!.validate()) {
      return false;
    }
    try {
      await wordService.updateGroupName(groupId, newName);
      return true;
    } catch (e) {
      return false;
    }
  }

  String generateGroupDate(DateTime creatingTime) {
    final DateTime(:day, :month, :year) = creatingTime;
    return '$day/$month/$year';
  }
}
