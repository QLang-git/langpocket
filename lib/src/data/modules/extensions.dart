import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/word_module.dart';

extension WordExt on WordData {
  WordRecord decoding() {
    return WordRecord(
      id: id,
      foreignWord: foreignWord,
      wordMeans: splitPaths(wordMeans),
      wordImages: splitPaths(wordImages),
      wordExamples: splitPaths(wordExamples),
      wordNote: wordNote,
    );
  }
}

extension Encoding on List<String> {
  String encodingData() {
    return joinPaths(this);
  }
}

extension DateT on DateTime {
  bool studyToday(DateTime today) {
    if (add(const Duration(days: 1)).compareDayMonthYearTo(today) ||
        add(const Duration(days: 3)).compareDayMonthYearTo(today) ||
        add(const Duration(days: 7)).compareDayMonthYearTo(today) ||
        add(const Duration(days: 14)).compareDayMonthYearTo(today) ||
        add(const Duration(days: 30)).compareDayMonthYearTo(today) ||
        add(const Duration(days: 90)).compareDayMonthYearTo(today) ||
        add(const Duration(days: 180)).compareDayMonthYearTo(today) ||
        add(const Duration(days: 360)).compareDayMonthYearTo(today)) {
      return true;
    } else {
      return false;
    }
  }

  DateTime withDays(int days) => add(Duration(days: day));

  bool compareDayMonthYearTo(DateTime o) {
    return day == o.day && month == o.month && year == o.year;
  }
}

String joinPaths(List<String> paths) {
  return paths.map((path) => Uri.encodeComponent(path)).join(';');
}

List<String> splitPaths(String joinedPaths) {
  return joinedPaths
      .split(';')
      .where((element) => element.isNotEmpty)
      .map((path) => Uri.decodeComponent(path))
      .toList();
}
