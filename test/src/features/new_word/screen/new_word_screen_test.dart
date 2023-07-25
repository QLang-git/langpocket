import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/features/new_word/controller/new_word_controller.dart';
import 'package:mocktail/mocktail.dart';

import 'new_word_robot.dart';

class MockNewWordController extends Mock implements NewWordController {}

class MockDB extends Mock implements DriftGroupRepository {}

class WordCompanionFake extends Fake implements WordCompanion {}

void main() {
  setUpAll(() {
    registerFallbackValue(WordCompanionFake());
  });
  group('existing', () {
    testWidgets('new word screen has all necessary widgets ', (tester) async {
      final r = NewWordRobot(tester);
      await tester.runAsync(() async {
        await r.renderNewWordScreen();
        // appbar
        r.hasIconPreviewer();
        r.hasTitle();
        r.hasIconBack();
        // body
        r.hasNewWordForm();
        r.hasSaveButton();
      });
    });
  });
  group('Actions', () {
    testWidgets('save with empty from showing error message', (tester) async {
      final r = NewWordRobot(tester);
      await tester.runAsync(() async {
        await r.renderNewWordScreen();
        await r.saveWithEmptyForm();
      });
    });
  });
}
