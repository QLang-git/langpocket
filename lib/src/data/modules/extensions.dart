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

  DateTime? whenToStudy(DateTime o) {
    if (studyToday(o)) {
      return o;
    }
    if (withDays(1).compareDayMonthYearTo(o.withDays(1))) {
      return o.withDays(1);
    }
    if (withDays(3).compareDayMonthYearTo(o.withDays(3))) {
      return o.withDays(3);
    }
    if (withDays(7).compareDayMonthYearTo(o.withDays(7))) {
      return o.withDays(7);
    }
    if (withDays(14).compareDayMonthYearTo(o.withDays(14))) {
      return o.withDays(14);
    }
    if (withDays(30).compareDayMonthYearTo(o.withDays(30))) {
      return o.withDays(30);
    }
    if (withDays(90).compareDayMonthYearTo(o.withDays(90))) {
      return o.withDays(90);
    }
    if (withDays(180).compareDayMonthYearTo(o.withDays(180))) {
      return o.withDays(180);
    }
    if (withDays(360).compareDayMonthYearTo(o.withDays(360))) {
      return o.withDays(360);
    }
    return null;
  }

  DateTime withDays(int days) => add(Duration(days: day));

  bool compareDayMonthYearTo(DateTime o) {
    return day == o.day && month == o.month && year == o.year;
  }
}
