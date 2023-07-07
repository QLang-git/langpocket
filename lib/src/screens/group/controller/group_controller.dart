import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/data/services/word_service.dart';
import 'package:langpocket/src/screens/home/widgets/groups_list/controller/groups_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class GroupController {
  final GroupData groupData;
  final WidgetRef ref;
  late AsyncValue<List<WordData>> _wordList;

  GroupController({required this.ref, required this.groupData});

  AsyncValue<List<WordData>> getListOfWordsAsync() {
    _wordList = ref.watch(watchWordsListbyIdProvider(groupData.id));
    return _wordList;
  }

  List<WordRecord> getListOfWordsData() {
    return _wordDecoding(_wordList.value!);
  }

  List<WordRecord> _wordDecoding(List<WordData> wordsData) {
    return wordsData
        .map((word) => WordRecord(
              id: word.id,
              foreignWord: word.foreignWord,
              wordMeans: word.meansList(),
              wordImages:
                  word.imagesList().map((e) => base64Decode(e)).toList(),
              wordExamples: word.examplesList(),
              wordNote: word.wordNote,
            ))
        .toList();
  }

  void deleteWord(int wordId) async {
    await ref.watch(wordsServicesProvider).deleteWordById(wordId, groupData.id);
  }

// app bar
  bool? editGroupName(
    TextEditingController controller,
    BuildContext context,
    GlobalKey<FormState> inputKey,
    ValueChanged<bool> onEditModeActivating,
  ) {
    if (groupData.groupName != controller.text) {
      return _updateGroupName(controller.text, inputKey, context);
      // newGroupName(controller.text);
    }
    onEditModeActivating(false);
    return null;
  }

  String generateGroupDate() {
    final DateTime(:day, :month, :year) = groupData.creatingTime;
    return '$day/$month/$year';
  }

  bool? _updateGroupName(
      String newName, GlobalKey<FormState> inputKey, BuildContext context) {
    if (!inputKey.currentState!.validate()) {
      return null;
    }
    final res = ref.read(
        _updateGroupNameProvider((groupId: groupData.id, groupName: newName)));
    return !res.hasError;
  }

  final _updateGroupNameProvider =
      FutureProvider.family<void, ({int groupId, String groupName})>(
          (ref, groupInfo) async {
    await ref
        .watch(wordsServicesProvider)
        .updateGroupName(groupInfo.groupId, groupInfo.groupName);
  });

  void spellingWithGroup() {}
}
