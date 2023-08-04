import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/features/practice/spelling/app_bar/spelling_appbar.dart';
import 'package:langpocket/src/features/practice/spelling/controllers/spelling_word_controller.dart';
import 'package:langpocket/src/features/practice/spelling/controllers/spelling_controller.dart';
import 'package:langpocket/src/features/practice/spelling/dialogs/spelling_single_dialog.dart';
import 'package:langpocket/src/features/practice/spelling/widgets/practice_spelling.dart';
import 'package:langpocket/src/utils/constants/messages.dart';

class PracticeSpellingSingleScreen extends ConsumerStatefulWidget {
  final int wordId;

  const PracticeSpellingSingleScreen({
    super.key,
    required this.wordId,
  });

  @override
  ConsumerState<PracticeSpellingSingleScreen> createState() =>
      PracticeSpellingScreenState();
}

class PracticeSpellingScreenState
    extends ConsumerState<PracticeSpellingSingleScreen> {
  bool readOnlyWord = false;
  bool readOnlyExample = false;
  late bool isDialogShowing;
  late SpellingController<SpellingWordState> spellingController;
  late TextEditingController inputController;
  late TextEditingController exampleInputController;

  @override
  void initState() {
    inputController = TextEditingController();
    exampleInputController = TextEditingController();
    isDialogShowing = false;
    spellingController =
        ref.read(spellingWordControllerProvider(widget.wordId).notifier);

    spellingController.setWordRecords();

    super.initState();
  }

  void setReadOnlyWord(({bool status, String text}) record) {
    readOnlyWord = record.status;
    record.status
        ? inputController.text = record.text
        : inputController.text = '';
  }

  void setReadOnlyExample(({bool status, String text}) record) {
    readOnlyExample = record.status;
    record.status
        ? exampleInputController.text = record.text
        : exampleInputController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final spellingState =
        ref.watch(spellingWordControllerProvider(widget.wordId));

    final myMessage = MyMessages();
    if (spellingState.hasValue) {
      final SpellingWordState(
        :activateExample,
        :wordRecord,
        :countSpelling,
        :examplePinter
      ) = spellingState.value!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        popUpDialogSingle(
            context,
            myMessage,
            wordRecord.foreignWord,
            wordRecord.wordExamples,
            countSpelling,
            activateExample,
            examplePinter,
            spellingController);
      });
      setStyleForCorrectness(spellingState.value!);
    }

    return ResponsiveCenter(
        child: Scaffold(
      appBar: spellingState.hasValue
          ? SpellingAppBar(
              spellingController: spellingController,
            )
          : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: AsyncValueWidget(
            value: spellingState,
            child: (spellingWordState) {
              final word = spellingWordState.wordRecord;

              return PracticeSpelling<SpellingWordState>(
                inputController: inputController,
                exampleInputController: exampleInputController,
                wordRecord: word,
                spellingState: spellingWordState,
                readOnlyWord: readOnlyWord,
                spellingController: spellingController,
                readOnlyExample: readOnlyExample,
              );
            },
          ),
        ),
      ),
    ));
  }

  void setStyleForCorrectness(SpellingWordState spellingWordState) {
    final SpellingWordState(
      :wordRecord,
      :activateExample,
      :correctness,
      :examplePinter
    ) = spellingWordState;
    if (mounted) {
      // the open case for word ok

      if (!activateExample && correctness) {
        setReadOnlyWord((status: true, text: wordRecord.foreignWord));

        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            spellingController.setCorrectness(false);
            setReadOnlyWord((status: false, text: ''));
          }
        });
      } else if (activateExample &&
          wordRecord.foreignWord != inputController.text) {
        setReadOnlyWord((status: true, text: wordRecord.foreignWord));
      }
      if (activateExample && correctness) {
        setReadOnlyExample(
            (status: true, text: wordRecord.wordExamples[examplePinter]));

        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            spellingController.setCorrectness(false);
            setReadOnlyExample((status: false, text: ''));
          }
        });
      }
    }
  }

  void popUpDialogSingle(
    BuildContext context,
    MyMessages myMessage,
    String foreignWord,
    List<String> examplesList,
    int countSpelling,
    bool activateExample,
    int pointer,
    SpellingController<SpellingStateBase> spellingController,
  ) {
    if (!isDialogShowing) {
      if (countSpelling == 0 && !activateExample) {
        isDialogShowing = true;

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return SpellingSingleWordDialog(
                  word: foreignWord,
                  reload: spellingController.startOver,
                  activateExamples: spellingController.exampleActivation);
            }).then((value) => isDialogShowing = false);
      } else if (countSpelling == 0 && activateExample) {
        if (pointer < examplesList.length - 1) {
          spellingController.moveToNextExamples(pointer);
        } else {
          isDialogShowing = true;
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return SpellingSingleWordExampleDialog(
                  reload: spellingController.startOver,
                  activateExamples: spellingController.exampleActivation,
                );
              }).then((value) {
            setReadOnlyExample((status: false, text: ''));
            setReadOnlyWord((status: false, text: ''));
            return isDialogShowing = false;
          });
        }
      }
    }
  }
}
