import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/data/services/word_service.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class NewGroupInfo {
  final int groupId;
  final String groupName;

  NewGroupInfo({required this.groupId, required this.groupName});
}

final updateGroupNameProvider =
    FutureProvider.family<void, NewGroupInfo>((ref, groupInfo) async {
  await ref
      .watch(wordsServicesProvider)
      .updateGroupName(groupInfo.groupId, groupInfo.groupName);
});

final deleteWordByIdProvider =
    FutureProvider.family<void, int>((ref, wordId) async {
  await ref.watch(wordsServicesProvider).deleteWordById(wordId);
});

List<Word> wordDecoding(List<WordData> wordsData) {
  return wordsData
      .map((word) => Word(
            id: word.id,
            foreignWord: word.foreignWord,
            wordMeans: word.meansList(),
            wordImages: word.imagesList().map((e) => base64Decode(e)).toList(),
            wordExamples: word.examplesList(),
            wordNote: word.wordNote,
          ))
      .toList();
}
