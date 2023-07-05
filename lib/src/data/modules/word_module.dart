// ignore_for_file: public_member_api_docs, sort_constructors_first
class WordModule {
  String wordId;
  String groupId;
  String foreignWord;
  List<String> images;
  List<String> means;
  List<String> examples;
  String note;
  WordModule({
    required this.wordId,
    required this.groupId,
    required this.foreignWord,
    required this.images,
    required this.means,
    required this.examples,
    required this.note,
  });
}
