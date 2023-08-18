import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/data/modules/word_module.dart';
import 'package:langpocket/src/data/services/word_service.dart';
import 'package:langpocket/src/features/word_edit/controller/word_editor_controller.dart';

// Define a class to hold your state
class InfoState {
  final List<WordRecord> wordsData;
  final GroupData groupData;

  InfoState({required this.wordsData, required this.groupData});
}

final groupControllerProvider =
    StateNotifierProvider.autoDispose<GroupController, AsyncValue<InfoState?>>(
        (ref) {
  final wordService = ref.watch(wordsServicesProvider);
  ref.watch(wordEditorProvider);
  return GroupController(wordService: wordService);
});

class GroupController extends StateNotifier<AsyncValue<InfoState?>> {
  WordServices wordService;
  GroupController({required this.wordService}) : super(const AsyncLoading());

  void getWords(int groupId) async {
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

  void deleteWord(int wordId, int groupId) async {
    await wordService.deleteWordById(wordId, groupId);
    state = const AsyncData(null);
  }

  // app bar
  Future<bool> editGroupName(
    String groupName,
    int groupId,
    TextEditingController controller,
    BuildContext context,
    GlobalKey<FormState> inputKey,
    ValueChanged<bool> onEditModeActivating,
  ) async {
    if (groupName != controller.text) {
      return await _updateGroupName(
          controller.text, inputKey, context, groupId);
      // newGroupName(controller.text);
    }
    onEditModeActivating(false);
    return false;
  }

  Future<bool> _updateGroupName(String newName, GlobalKey<FormState> inputKey,
      BuildContext context, int groupId) async {
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
