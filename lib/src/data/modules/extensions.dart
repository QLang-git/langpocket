import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';

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
}
