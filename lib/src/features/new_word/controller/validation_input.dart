class ValidationInput {
  ({String message, bool status}) foreignWordValidation(String? foreignWord) {
    if (foreignWord == null || foreignWord.trim().isEmpty) {
      return (message: 'The word field can\'t be empty.', status: false);
    }
    if (foreignWord.split(' ').length != 1) {
      return (message: 'Keep it one word in this field', status: false);
    }
    if (foreignWord.length > 20) {
      return (message: 'Word Too long', status: false);
    }
    return (message: '', status: true);
  }

  ({String message, bool status}) meaningWordsValidation(
      List<String> wordMeans) {
    if (wordMeans.isEmpty) {
      return (message: 'This field can\'t be empty.', status: false);
    }
    if (!_isNotEmptyList(wordMeans)) {
      return (message: 'This field can\'t be empty.', status: false);
    }
    for (var wordMean in wordMeans) {
      if (wordMean.length > 40) {
        return (
          message: 'keep the definition of the word smaller',
          status: false
        );
      }
    }
    if (wordMeans.length > 3) {
      return (message: 'Invalid text', status: false);
    }
    return (message: '', status: true);
  }

  ({String message, bool status}) exampleWordsValidation(
      List<String> wordExamples) {
    if (wordExamples.isEmpty) {
      return (message: 'This field can\'t be empty.', status: false);
    }
    if (!_isNotEmptyList(wordExamples)) {
      return (message: 'This field can\'t be empty.', status: false);
    }

    if (wordExamples.length > 5) {
      return (message: 'Invalid text', status: false);
    }
    for (var wordExample in wordExamples) {
      if (wordExample.trim().length > 40) {
        return (
          message:
              'That\'s quite a lengthy sentence! Please try to make it shorter.',
          status: false
        );
      }
    }
    return (message: '', status: true);
  }

  ({String message, bool status}) notesWordsValidation(String wordNote) {
    if (wordNote.length > 100) {
      return (message: 'keep your notes short and concise ', status: false);
    }
    return (message: '', status: true);
  }

  bool _isNotEmptyList(List<String> list) {
    for (String item in list) {
      if (item.trim().isNotEmpty) {
        return true;
      }
    }
    return false;
  }
}
