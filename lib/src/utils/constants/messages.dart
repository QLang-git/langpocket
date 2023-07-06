enum PracticeMessagesType {
  practiceSpelling,
  practicePronunciation,
  practiceSpellingExampleComplete,
  practicePronExampleComplete,
  practiceInteractively
}

class MyMessages {
  PracticeMessage getPracticeMessage(
      PracticeMessagesType messages, String word) {
    if (messages == PracticeMessagesType.practiceSpelling) {
      return PracticeMessage(
        titleMessage:
            'You wrote " $word " 5 times correctly.\nKeep practicing  spelling several times for better results.',
        withSentences: 'Spell this word with sentences ',
        tryAgain: 'Try spell it again ',
      );
    }
    if (messages == PracticeMessagesType.practiceSpellingExampleComplete) {
      return PracticeMessage(
        titleMessage:
            'You\'ve completed your spelling practice for the word examples also .\nKeep going...',
        withSentences: 'Spell with sentences again ',
        tryAgain: 'Start over',
      );
    }

    if (messages == PracticeMessagesType.practicePronunciation) {
      return PracticeMessage(
        titleMessage:
            'You pronounced " $word " 5 times correctly.\nKeep practicing  pronunciation several times for better results.',
        withSentences: 'Pronounce this word with sentences ',
        tryAgain: 'Try pronounce it again ',
      );
    }
    if (messages == PracticeMessagesType.practicePronExampleComplete) {
      return PracticeMessage(
          titleMessage:
              'You\'ve completed your pronunciation task for this word .\nKeep going...',
          withSentences: 'Pronounce with sentences again ',
          tryAgain: 'Start over');
    }
    if (messages == PracticeMessagesType.practiceInteractively) {
      return PracticeMessage(
          titleMessage:
              'Congratulations on completing your practice session for the word "$word"! \nYou\'ve done a great job! Keep up the momentum and continue to enhance your language skills!',
          tryAgain: 'Start over');
    } else {
      return PracticeMessage(
        titleMessage: 'default massage',
        withSentences: 'default massage',
        tryAgain: 'default massage',
      );
    }
  }
}

class PracticeMessage {
  final String titleMessage;
  final String withSentences;
  final String tryAgain;

  PracticeMessage({
    required this.titleMessage,
    this.withSentences = '',
    required this.tryAgain,
  });
}
