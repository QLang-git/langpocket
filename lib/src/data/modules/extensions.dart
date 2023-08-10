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
