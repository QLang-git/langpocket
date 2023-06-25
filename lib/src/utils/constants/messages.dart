class PracticeWordMessages {
  final Function reload;
  final Function enableExamples;
  final String titleMessage;
  final String withSentences;
  final String tryAgain;

  PracticeWordMessages(
      {required this.titleMessage,
      required this.withSentences,
      required this.tryAgain,
      required this.reload,
      required this.enableExamples});
}

enum MessagesType {
  practiceSpelling,
  practicePronunciation,
  practiceSpellingExampleComplete,
}

class MyMessages {
  PracticeWordMessages getPracticeMessage(
      MessagesType messages, String word, reload, enableExamples) {
    if (messages == MessagesType.practiceSpelling) {
      return PracticeWordMessages(
          titleMessage:
              'You wrote " $word " 5 times correctly.\nKeep practicing  spelling several times for better results.',
          withSentences: 'Spell this word with sentences ',
          tryAgain: 'Try spell it again ',
          enableExamples: enableExamples,
          reload: reload);
    }
    if (messages == MessagesType.practiceSpellingExampleComplete) {
      return PracticeWordMessages(
          titleMessage:
              'You\'ve completed your spelling practice for the word examples also .\nKeep going...',
          withSentences: 'Spell with sentences again ',
          tryAgain: 'Try spell it again ',
          enableExamples: enableExamples,
          reload: reload);
    }

    if (messages == MessagesType.practicePronunciation) {
      return PracticeWordMessages(
          titleMessage:
              'You pronounced " $word " 5 times correctly.\nKeep practicing  pronunciation several times for better results.',
          withSentences: 'Pronounce this word with sentences ',
          tryAgain: 'Try pronounce it again ',
          enableExamples: enableExamples,
          reload: reload);
    } else {
      return PracticeWordMessages(
          titleMessage: 'default massage',
          withSentences: 'default massage',
          tryAgain: 'default massage',
          reload: reload,
          enableExamples: enableExamples);
    }
  }
}
