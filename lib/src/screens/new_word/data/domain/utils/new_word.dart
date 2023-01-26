import 'package:langpocket/src/screens/new_word/data/domain/word_model.dart';

extension NewWord on Word {
  //TODO: implement the id maker
  String makeUID() => 'FAKEUId';

  Word getNewWord() {
    return Word(
        wordId: makeUID(),
        images: images,
        foreign: foreign,
        examples: examples,
        means: means,
        note: note);
  }
}
