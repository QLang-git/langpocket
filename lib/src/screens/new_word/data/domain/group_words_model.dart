// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:langpocket/src/screens/new_word/data/domain/word_model.dart';

class GroupWords {
  final String groupWordsId;
  final List<Word> words;

  GroupWords(this.groupWordsId, this.words);

  @override
  bool operator ==(covariant GroupWords other) {
    if (identical(this, other)) return true;

    return other.groupWordsId == groupWordsId && listEquals(other.words, words);
  }

  @override
  int get hashCode => groupWordsId.hashCode ^ words.hashCode;
}
