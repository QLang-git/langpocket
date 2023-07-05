import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
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
void deleteWord(int wordId, int groupId) {
  safe_acess_local_db.deleteWordById(wordId, groupId);
}

List<WordRecord> wordDecoding(List<WordData> wordsData) {
  return wordsData
      .map((word) => WordRecord(
            id: word.id,
            foreignWord: word.foreignWord,
            wordMeans: word.meansList(),
            wordImages: word.imagesList().map((e) => base64Decode(e)).toList(),
            wordExamples: word.examplesList(),
            wordNote: word.wordNote,
          ))
      .toList();
}
