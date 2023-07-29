import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/common_widgets/custom_dialog_practice.dart';
import 'package:langpocket/src/features/practice/spelling/app_bar/spelling_appbar.dart';
import 'package:langpocket/src/features/practice/spelling/controllers/spelling_group_controller.dart';
import 'package:langpocket/src/features/practice/spelling/controllers/spelling_controller.dart';
import 'package:langpocket/src/features/practice/spelling/widgets/practice_spelling.dart';
import 'package:langpocket/src/utils/constants/messages.dart';

class PracticeSpellingGroupScreen extends ConsumerStatefulWidget {
  final int groupId;

  const PracticeSpellingGroupScreen({
    super.key,
    required this.groupId,
  });

  @override
  ConsumerState<PracticeSpellingGroupScreen> createState() =>
      PracticeSpellingScreenState();
}

class PracticeSpellingScreenState
    extends ConsumerState<PracticeSpellingGroupScreen> {
  bool readOnlyWord = false;
  bool readOnlyExample = false;
  late bool isDialogShowing;
  late SpellingController<SpellingGroupState> spellingController;
  late TextEditingController inputController;
  late TextEditingController exampleInputController;

  @override
  void initState() {
    isDialogShowing = false;
    spellingController =
        ref.read(spellingGroupControllerProvider(widget.groupId).notifier);

    spellingController.setWordRecords();

    super.initState();
  }

  @override
  void dispose() {
    inputController.dispose();
    exampleInputController.dispose();

    super.dispose();
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
        ref.watch(spellingGroupControllerProvider(widget.groupId));

    final myMessage = MyMessages();

    if (spellingState.hasValue) {
      final SpellingGroupState(
        :activateExample,
        :wordIndex,
        :wordsRecord,
        :countSpelling,
        :examplePinter
      ) = spellingState.value!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        popUpDialogGroup(
            context,
            myMessage,
            wordsRecord[wordIndex].foreignWord,
            wordsRecord[wordIndex].wordExamples,
            countSpelling,
            activateExample,
            examplePinter,
            spellingState.value!);
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
            child: (spellingGroupState) {
              final wordIndex = spellingGroupState.wordIndex;
              final word = spellingGroupState.wordsRecord[wordIndex];

              return PracticeSpelling<SpellingGroupState>(
                  wordRecord: word,
                  readOnlyWord: readOnlyWord,
                  inputController: inputController,
                  spellingController: spellingController,
                  spellingState: spellingGroupState,
                  readOnlyExample: readOnlyExample,
                  exampleInputController: exampleInputController);
            },
          ),
        ),
      ),
    ));
  }

  void setStyleForCorrectness(SpellingGroupState spellingWordState) {
    final SpellingGroupState(
      :wordIndex,
      :wordsRecord,
      :activateExample,
      :correctness,
      :examplePinter
    ) = spellingWordState;
    if (mounted) {
      // the open case for word ok

      if (!activateExample && correctness) {
        setReadOnlyWord(
            (status: true, text: wordsRecord[wordIndex].foreignWord));

        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            spellingController.setCorrectness(false);
            setReadOnlyWord((status: false, text: ''));
          }
        });
      } else if (activateExample &&
          wordsRecord[wordIndex].foreignWord != inputController.text) {
        setReadOnlyWord(
            (status: true, text: wordsRecord[wordIndex].foreignWord));
      }
      if (activateExample && correctness) {
        setReadOnlyExample((
          status: true,
          text: wordsRecord[wordIndex].wordExamples[examplePinter]
        ));

        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            spellingController.setCorrectness(false);
            setReadOnlyExample((status: false, text: ''));
          }
        });
      }
    }
  }

  void popUpDialogGroup(
      BuildContext context,
      MyMessages myMessage,
      String foreignWord,
      List<String> examplesList,
      int countSpelling,
      bool activateExample,
      int pointer,
      SpellingGroupState spellingWordState) {
    if (!isDialogShowing) {
      if (countSpelling == 0) {
        if (activateExample && pointer < examplesList.length - 1) {
          spellingController.moveToNextExamples(pointer);
        } else if (!activateExample) {
          isDialogShowing = true;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogPractice(
                messages: myMessage.getPracticeMessage(
                  PracticeMessagesType.practiceSpellingGroup,
                  foreignWord,
                ),
                reload: spellingController.isThereNextWord
                    ? spellingController.moveToNextWord
                    : null,
                activateExamples: spellingController.exampleActivation,
              );
            },
          ).then((value) => isDialogShowing = false);
        } else if (countSpelling == 0 &&
            activateExample &&
            spellingController.isThereNextWord) {
          spellingController.moveToNextWord();
          return;
        } else if (countSpelling == 0 && activateExample) {
          isDialogShowing = true;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogPractice(
                messages: myMessage.getPracticeMessage(
                  PracticeMessagesType.practiceSpellingExampleCompleteGroup,
                  foreignWord,
                ),
                reload: spellingController.startOver,
                activateExamples: spellingController.exampleActivation,
              );
            },
          ).then((value) {
            setReadOnlyExample((status: false, text: ''));
            setReadOnlyWord((status: false, text: ''));
            return isDialogShowing = false;
          });
        }
      }
    }
  }
}
