// ignore_for_file: library_prefixes

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/word_module.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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

  // Word toCloudData(Group group) {
  //   return Word(
  //       id: id.toString(),
  //       group: group,
  //       foreignWord: foreignWord,
  //       wordMeans: splitPaths(wordMeans),
  //       wordImages: splitPaths(wordImages),
  //       wordExamples: splitPaths(wordExamples),
  //       wordNote: wordNote,
  //       createdAt: TemporalDateTime(wordDate));
  // }
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

// extension ToLocalTime on TemporalDateTime {
//   DateTime convertTemporalToDateTime() {
//     return DateTime.parse(format());
//   }
// }

// extension ToLocalDate on TemporalDate {
//   DateTime convertTemporalToDateTime() {
//     return DateTime.parse(format());
//   }
// }

// extension LocalGroupDB on AWS.Group {
//   GroupCompanion toLocalData() {
//     return GroupCompanion.insert(
//       id: Value(int.parse(id)),
//       creatingTime: createdAt.convertTemporalToDateTime(),
//       groupName: groupName,
//       studyTime: studyTime.convertTemporalToDateTime(),
//       level: Value(level),
//       synced: const Value(true),
//     );
//   }
// }

// extension LocalWordDB on AWS.Word {
//   Future<WordCompanion> toLocalData() async {
//     final imgPaths = await _downloadAndSaveImage();
//     return WordCompanion.insert(
//         id: Value(int.parse(id)),
//         group: int.parse(group.id),
//         foreignWord: foreignWord,
//         wordMeans: wordMeans.join(';'),
//         wordExamples: wordExamples.join(';'),
//         wordImages: imgPaths.join(';'),
//         wordDate: createdAt.convertTemporalToDateTime(),
//         wordNote: wordNote ?? '');
//   }

Future<List<String>> _downloadAndSaveImage() async {
  final List<String> localPaths = [];
  var wordImages;
  for (var imageUrl in wordImages) {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      // Get the app directory
      final appDir = await getApplicationDocumentsDirectory();
      final targetPath = "${appDir.path}/images/";
      final targetDirectory = Directory(targetPath);
      if (!targetDirectory.existsSync()) {
        targetDirectory.createSync(recursive: true);
      }

      // Generate a filename based on the URL or you can use DateTime as previously shown
      final fileName = basename(imageUrl);
      final targetFile = File("$targetPath$fileName");

      // Write the image data to a file
      await targetFile.writeAsBytes(response.bodyBytes);

      localPaths.add(targetFile.path);
    } else {
      print('Failed to download image from $imageUrl');
    }
  }
  return localPaths;

  // Fetch the image data
}


// extension ToCloud on GroupData {
//   Group toCloudData() {
//     return Group(
//         id: id.toString(),
//         groupName: groupName,
//         level: level,
//         createdAt: TemporalDateTime(creatingTime),
//         studyTime: TemporalDate(studyTime));
//   }
// }
