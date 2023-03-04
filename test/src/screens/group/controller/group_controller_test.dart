import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/screens/group/controller/group_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

void main() {
  test('decoding wordData object to word decoding', () {
    final image = File('test/images_testing/img_test.png');
    final imgDecode = image.readAsBytesSync();
    final imgcode = base64Encode(imgDecode);
    final codingWord = [
      WordData(
          id: 1,
          group: 1,
          foreignWord: 'test',
          wordMeans: 'test1-test2',
          wordImages: imgcode,
          wordExamples: 'test01-test02',
          wordNote: 'word note',
          wordDate: DateTime.now())
    ];
    final decodingWord = [
      Word(
        id: 1,
        foreignWord: 'test',
        wordMeans: ['test1', 'test2'],
        wordImages: [imgDecode],
        wordExamples: ['test01', 'test02'],
        wordNote: 'word note',
      )
    ];
    expect(wordDecoding(codingWord).first.foreignWord,
        decodingWord.first.foreignWord);
    expect(
      wordDecoding(codingWord).first.wordMeans.first,
      decodingWord.first.wordMeans.first,
    );
    expect(
      wordDecoding(codingWord).first.wordMeans.last,
      decodingWord.first.wordMeans.last,
    );
    expect(
      wordDecoding(codingWord).first.wordExamples.first,
      decodingWord.first.wordExamples.first,
    );
    expect(
      wordDecoding(codingWord).first.wordExamples.last,
      decodingWord.first.wordExamples.last,
    );
    expect(
      wordDecoding(codingWord).first.wordNote,
      decodingWord.first.wordNote,
    );
    expect(
      wordDecoding(codingWord).first.wordImages.first,
      decodingWord.first.wordImages.first,
    );
  });
}
