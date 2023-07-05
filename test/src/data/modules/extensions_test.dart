import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';

void main() {
  test('get clean list of meaning,examples, images from db string', () {
    final image = File('test/images_testing/img_test.png');
    final imgDecode = image.readAsBytesSync();
    final imgcode = base64Encode(imgDecode);
    final word = WordData(
        id: 1,
        group: 1,
        foreignWord: 'test',
        wordMeans: 'test1----',
        wordImages: '--$imgcode--',
        wordExamples: '--test01-test02--',
        wordNote: 'word note',
        wordDate: DateTime.now());
    expect(word.meansList(), ['test1']);
    expect(word.imagesList(), [imgcode]);
    expect(word.examplesList(), ['test01', 'test02']);
  });
}
