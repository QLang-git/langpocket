import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
import 'package:langpocket/src/features/new_word/controller/new_word_controller.dart';
import 'package:langpocket/src/features/new_word/screen/new_word_screen.dart';
import 'package:langpocket/src/features/new_word/widgets/image_picker/images_dashboard.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:mocktail/mocktail.dart';

class NewWordRobot {
  final WidgetTester tester;
  NewWordRobot(this.tester);
  Future<void> renderNewWordScreen(
      {DriftGroupRepository? db, NewWordController? controller}) async {
    await _pumpHomeScreen(db, controller);
    await _navToAddNewWord();
  }

  void hasIconPreviewer() {
    final icon = find.byIcon(Icons.preview_outlined);
    expect(icon, findsOneWidget);
  }

  void hasTitle() {
    final title = find.text('New word');
    expect(title, findsOneWidget);
  }

  void hasIconBack() {
    final icon = find.byIcon(Icons.arrow_back);
    expect(icon, findsOneWidget);
  }

  void hasImageDashboard() {
    final title = find.byType(ImagesDashboard);
    expect(title, findsOneWidget);
  }

  void hasNewWordForm() {
    final title = find.byType(ImagesDashboard);
    expect(title, findsOneWidget);
  }

  void hasSaveButton() {
    final title = find.text('Save');
    expect(title, findsOneWidget);
  }

  Future<void> saveWithEmptyForm() async {
    final button = find.text('Save');
    await tester.tap(button);
    await tester.pump();
    final newWordScreen = find.byType(NewWordScreen);
    final errorText1 = find.text('The word field can\'t be empty.');
    final errorText2 = find.text('This field can\'t be empty.');
    expect(errorText1, findsOneWidget);
    expect(errorText2, findsWidgets);
    expect(newWordScreen, findsOneWidget);
  }

  Future<void> saveWithValidForm(
      NewWordController controller, DriftGroupRepository db) async {
    // Define the behavior of your mock before the interactions
    when(() => controller.saveNewWord(any()))
        .thenAnswer((_) => Future<void>.value()); // Return a completed Future

    when(() => db.addNewWordInGroup(any())).thenAnswer((_) => Future.value());

    final foreignWord = find.byKey(const Key('ForeignWord'));
    final meanWord0 = find.byKey(const Key('MeanWord0'));
    final exampleWord0 = find.byKey(const Key('ExampleWord0'));
    final exampleWord1 = find.byKey(const Key('ExampleWord1'));
    final notesWord = find.byKey(const Key('NotesWord'));

    await tester.enterText(foreignWord, 'newWord');
    await tester.enterText(meanWord0, 'testing here');
    await tester.enterText(exampleWord0, 'first example testing');
    await tester.enterText(exampleWord1, 'second example testing');
    await tester.enterText(notesWord, 'notes');

    final button = find.text('Save');
    await tester.tap(button);

    await tester.pump();

    // verify(() => controller.saveNewWord(any())).called(1);
    // verify(() => controller.saveForeignWord(any())).called(1);
    // verify(() => controller.saveWordMeans(any(), any())).called(1);
    // verify(() => controller.saveWordExample(any(), any())).called(1);
  }

  // final newWordScreen = find.byType(NewWordScreen);
  //expect(newWordScreen, findsNothing);
  Future<void> _pumpHomeScreen(
      [DriftGroupRepository? db, NewWordController? newWordController]) async {
    // simulate a larger screen size
    // await tester.binding.setSurfaceSize(const Size(1280, 720));

    await tester.pumpWidget(ProviderScope(
      overrides: [
        if (db != null) localGroupRepositoryProvider.overrideWithValue(db),
        if (newWordController != null)
          newWordControllerProvider.overrideWith((ref) => newWordController)
      ],
      child: MaterialApp.router(
        routerConfig: goroute,
      ),
    ));

    await tester.pump();
  }

  Future<void> _navToAddNewWord() async {
    final icon = find.byIcon(Icons.add);
    expect(icon, findsWidgets);
    await tester.tap(icon);
    await tester.pumpAndSettle();
  }
}
