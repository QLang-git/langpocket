import 'dart:convert';

import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

extension WordExt on WordData {
  List<String> examplesList() {
    return wordExamples
        .split('-')
        .where((element) => element.isNotEmpty)
        .toList();
  }

  List<String> meansList() {
    return wordMeans.split('-').where((element) => element.isNotEmpty).toList();
  }

  List<String> imagesList() {
    return wordImages
        .split('-')
        .where((element) => element.isNotEmpty)
        .toList();
  }

  WordRecord decoding() {
    return WordRecord(
      id: id,
      foreignWord: foreignWord,
      wordMeans: meansList(),
      wordImages: imagesList().map((e) => base64Decode(e)).toList(),
      wordExamples: examplesList(),
      wordNote: wordNote,
    );
  }
}
