import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
import 'package:langpocket/src/screens/group/controller/group_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:mocktail/mocktail.dart';

class MockDriftGroupRepository extends Mock implements DriftGroupRepository {}

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
      WordRecord(
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
  test('update Group Name Provider', () async {
    final db = MockDriftGroupRepository();
    final container = ProviderContainer(
      overrides: [localGroupRepositoryProvider.overrideWithValue(db)],
    );
    expect(
        container.read(updateGroupNameProvider(
            NewGroupInfo(groupId: 1, groupName: 'newName'))),
        const AsyncValue<void>.loading());

    verify(() => db.updateGroupName(1, 'newName')).called(1);
  });
}
