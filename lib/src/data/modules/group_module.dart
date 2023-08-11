// ignore_for_file: public_member_api_docs, sort_constructors_first
class GroupModule {
  int id;
  String groupName;
  DateTime creatingTime;
  int level;
  DateTime studyTime;

  GroupModule(
      {required this.id,
      required this.groupName,
      required this.creatingTime,
      required this.level,
      required this.studyTime});
}
