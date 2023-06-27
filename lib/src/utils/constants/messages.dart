class PracticeWordMessages {
  final String titleMessage;
  final String withSentences;
  final String tryAgain;

  PracticeWordMessages({
    required this.titleMessage,
    required this.withSentences,
    required this.tryAgain,
  });
}

enum MessagesType {
  practiceSpelling,
  practicePronunciation,
  practiceSpellingExampleComplete,
  practicePronExampleComplete,
}

class MyMessages {
  PracticeWordMessages getPracticeMessage(MessagesType messages, String word) {
    if (messages == MessagesType.practiceSpelling) {
      return PracticeWordMessages(
        titleMessage:
            'You wrote " $word " 5 times correctly.\nKeep practicing  spelling several times for better results.',
        withSentences: 'Spell this word with sentences ',
        tryAgain: 'Try spell it again ',
      );
    }
    if (messages == MessagesType.practiceSpellingExampleComplete) {
      return PracticeWordMessages(
        titleMessage:
            'You\'ve completed your spelling practice for the word examples also .\nKeep going...',
        withSentences: 'Spell with sentences again ',
        tryAgain: 'Start over',
      );
    }

    if (messages == MessagesType.practicePronunciation) {
      return PracticeWordMessages(
        titleMessage:
            'You pronounced " $word " 5 times correctly.\nKeep practicing  pronunciation several times for better results.',
        withSentences: 'Pronounce this word with sentences ',
        tryAgain: 'Try pronounce it again ',
      );
    }
    if (messages == MessagesType.practicePronExampleComplete) {
      return PracticeWordMessages(
          titleMessage:
              'You\'ve completed your pronunciation task for this word .\nKeep going...',
          withSentences: 'Pronounce with sentences again ',
          tryAgain: 'Start over');
    } else {
      return PracticeWordMessages(
        titleMessage: 'default massage',
        withSentences: 'default massage',
        tryAgain: 'default massage',
      );
    }
  }
}
