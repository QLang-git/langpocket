import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/data_flow/data_flow.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class GroupController {
  final int groupId;
  final WidgetRef ref;

  GroupController({required this.ref, required this.groupId});
  late DataFlow dataFlow;

  void initial() {
    dataFlow = DataFlow(ref: ref);
  }

  AsyncValue<List<WordData>> getWordsInGroupById(int currentGroupId) {
    return dataFlow.watchWordsListbyId(currentGroupId);
  }

  List<WordRecord> wordDecoder(List<WordData> wordsData) {
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

  void deleteWord(int wordId) => dataFlow.deleteWordInGroup(wordId, groupId);
// app bar
  bool? editGroupName(
    String groupName,
    TextEditingController controller,
    BuildContext context,
    GlobalKey<FormState> inputKey,
    ValueChanged<bool> onEditModeActivating,
  ) {
    if (groupName != controller.text) {
      return _updateGroupName(controller.text, inputKey, context);
      // newGroupName(controller.text);
    }
    onEditModeActivating(false);
    return null;
  }

  String generateGroupDate(DateTime creatingTime) {
    final DateTime(:day, :month, :year) = creatingTime;
    return '$day/$month/$year';
  }

  bool? _updateGroupName(
      String newName, GlobalKey<FormState> inputKey, BuildContext context) {
    if (!inputKey.currentState!.validate()) {
      return null;
    }
    final res = dataFlow.updateGroupNameProvider(groupId, newName);
    return !res.hasError;
  }
}
