import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/services/word_service.dart';
import 'package:langpocket/src/screens/word_edit/screen/edit_mode_word_screen.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class NewWordInfo {
  final int wordId;
  final WordCompanion wordCompanion;

  NewWordInfo(this.wordId, this.wordCompanion);
}

final updateWordInfoProvider =
    FutureProvider.family<void, NewWordInfo>((ref, wordNew) async {
  await ref
      .watch(wordsServicesProvider)
      .updateWordInfo(wordNew.wordId, wordNew.wordCompanion);
});
Future<void> saveNewUpdate(
    {required WidgetRef ref,
    required FormState currentState,
    required EditModeWordScreenState states,
    required BuildContext context}) async {
  if (currentState.validate()) {
    final imagesbase64 =
        states.newImages.map((img) => base64Encode(img)).toList();
    final newInfo = NewWordInfo(
        1,
        WordCompanion(
          foreignWord: Value(states.newforeignWord),
          wordMeans: Value(states.newMeans.join('-')),
          wordImages: Value(imagesbase64.join('-')),
          wordExamples: Value(states.newExample.join('-')),
          wordNote: Value(states.newNote),
        ));

    final res = ref.read(updateWordInfoProvider(newInfo));
    if (!res.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('The word has been updated')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Server Error, try again')),
      );
    }
    currentState.reset();
    context.pop();
  }
}

List<String> _cleanList(List<String> list) {
  return list.where((element) => element.isNotEmpty).toList();
}

bool isWordInfoSimilar(
    {required EditModeWordScreenState states, required Word wordData}) {
  final isUpdatedforeignWord = states.newforeignWord == wordData.foreignWord;
  final isUpdatedMeans =
      listEquals(_cleanList(states.newMeans), _cleanList(wordData.wordMeans));
  final isUpdatedExample = listEquals(
      _cleanList(states.newExample), _cleanList(wordData.wordExamples));
  final isUpdatedImage = listEquals(states.newImages, wordData.wordImages);
  final isUpdatedNote = states.newNote == wordData.wordNote;
  if (isUpdatedforeignWord &&
      isUpdatedMeans &&
      isUpdatedExample &&
      isUpdatedImage &&
      isUpdatedNote) {
    return true;
  } else {
    return false;
  }
}
