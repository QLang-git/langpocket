import 'dart:io';

import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/timezone.dart' as tz;

Future<String> getLocalTimeZone() async {
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
  return timeZoneName;
}

Future<List<String>> saveImagesFiles(List<String> wordImages) async {
  final List<String> pathList = [];
  for (var path in wordImages) {
    final img = File(path);
    final appDir = await getApplicationDocumentsDirectory();
    final targetPath = "${appDir.path}/images/";
    final targetDirectory = Directory(targetPath);
    if (!targetDirectory.existsSync()) {
      targetDirectory.createSync(recursive: true);
    }
    final fileName = basename(img.path);
    final targetFile = File("$targetPath$fileName");
    await img.copy(targetFile.path);

    pathList.add(targetFile.path);
  }
  return pathList;
}
