import 'package:flutter/foundation.dart';

class WordRecord {
  final int? id;
  final String foreignWord;
  final List<String> wordMeans;
  final List<Uint8List> wordImages;
  final List<String> wordExamples;
  final String wordNote;

  WordRecord({
    this.id,
    required this.foreignWord,
    required this.wordMeans,
    required this.wordImages,
    required this.wordExamples,
    required this.wordNote,
  });

  @override
  String toString() {
    return 'Word(id: $id, foreignWord: $foreignWord, wordMeans: $wordMeans, wordImages: $wordImages, wordExamples: $wordExamples, wordNote: $wordNote)';
  }

  WordRecord copyWith({
    int? id,
    String? foreignWord,
    List<String>? wordMeans,
    List<Uint8List>? wordImages,
    List<String>? wordExamples,
    String? wordNote,
  }) {
    return WordRecord(
      id: id ?? this.id,
      foreignWord: foreignWord ?? this.foreignWord,
      wordMeans: wordMeans ?? this.wordMeans,
      wordImages: wordImages ?? this.wordImages,
      wordExamples: wordExamples ?? this.wordExamples,
      wordNote: wordNote ?? this.wordNote,
    );
  }

  @override
  bool operator ==(covariant WordRecord other) {
    if (identical(this, other)) return true;

    bool isUint8ListEquals(List<Uint8List> list1, List<Uint8List> list2) {
      if (list1.length != list2.length) return false;
      for (int i = 0; i < list1.length; i++) {
        if (!listEquals(list1[i], list2[i])) return false;
      }
      return true;
    }

    return other.id == id &&
        other.foreignWord == foreignWord &&
        listEquals(other.wordMeans, wordMeans) &&
        isUint8ListEquals(other.wordImages, wordImages) &&
        listEquals(other.wordExamples, wordExamples) &&
        other.wordNote == wordNote;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        foreignWord.hashCode ^
        wordMeans.hashCode ^
        wordImages.hashCode ^
        wordExamples.hashCode ^
        wordNote.hashCode;
  }
}
