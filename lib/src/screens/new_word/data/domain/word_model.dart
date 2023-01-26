// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class Word {
  final String wordId;
  final List<String> images;
  final String foreign;
  final List<String> means;
  final List<String> examples;
  final String note;

  Word(
      {required this.wordId,
      required this.images,
      required this.foreign,
      required this.means,
      required this.examples,
      required this.note});

  @override
  bool operator ==(covariant Word other) {
    if (identical(this, other)) return true;

    return other.wordId == wordId &&
        listEquals(other.images, images) &&
        other.foreign == foreign &&
        listEquals(other.means, means) &&
        listEquals(other.examples, examples) &&
        other.note == note;
  }

  @override
  int get hashCode {
    return wordId.hashCode ^
        images.hashCode ^
        foreign.hashCode ^
        means.hashCode ^
        examples.hashCode ^
        note.hashCode;
  }
}
