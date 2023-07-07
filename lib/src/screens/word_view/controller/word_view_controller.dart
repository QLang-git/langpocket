import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/data/services/word_service.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

final watchWordbyIdProvider =
    StreamProvider.family<WordData, int>((ref, wordId) {
  final words = ref.watch(wordsServicesProvider).watchWordById(wordId);

  return words;
});
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
