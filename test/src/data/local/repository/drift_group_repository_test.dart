import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';

void main() {
  late DriftGroupRepository database;
  final group = GroupCompanion(
      groupName: const Value('new group'), creatingTime: Value(DateTime.now()));
  final word = WordCompanion(
    group: const Value(1),
    foreignWord: const Value('test'),
    wordMeans: const Value('test-test'),
    wordImages: const Value(''),
    wordExamples: const Value('exampleTest-exampleTest'),
    wordNote: const Value(''),
    wordDate: Value(DateTime.now()),
  );
  setUp(() {
    database = DriftGroupRepository(NativeDatabase.memory());
  });
  tearDown(() async {
    await database.close();
  });
  test('creating a new group and fetch it by Id', () async {
    final newGroup = await database.createGroup(group);
    final getGroup = await database.fetchGroupById(newGroup.id);

    expect(getGroup.id, 1);
    expect(getGroup.groupName, 'new group');
  });
  test('add new word in group fetch the group', () async {
    await database.createGroup(group);
    await database.addNewWordInGroup(word);
    final getWord = await database.fetchWordbyId(1);

    expect(getWord.id, 1);
    expect(getWord.foreignWord, 'test');
    expect(getWord.wordMeans, 'test-test');
    expect(getWord.wordExamples, 'exampleTest-exampleTest');
  });
  test('fetch list of groups', () async {
    await database.createGroup(group);
    await database.createGroup(GroupCompanion(
        groupName: const Value('new group 2'),
        creatingTime: Value(DateTime.now())));
    final groups = await database.fetchGroups();

    expect(groups.length, 2);
    expect(groups.first.groupName, 'new group');
    expect(groups.last.groupName, 'new group 2');
  });
  test('fetch group by time', () async {
    // setup
    final time = DateTime.now();
    await database.createGroup(
      GroupCompanion(
        groupName: const Value('new group 2'),
        creatingTime: Value(time),
      ),
    );
    final myGroup = await database.fetchGroupByTime(time);

    expect(myGroup.groupName, 'new group 2');
  });
  test('fetch words by group id', () async {
    // setup
    await database.createGroup(group);
    await database.addNewWordInGroup(word);
    final myWords = await database.fetchWordsByGroupId(1);

    expect(myWords.length, 1);
    expect(myWords.first.foreignWord, word.foreignWord.value);
    expect(myWords.first.wordMeans, word.wordMeans.value);
    expect(myWords.first.wordExamples, word.wordExamples.value);
    // expect(myGroup.creatingTime, time);
  });
  test('update group name ', () async {
    // setup
    await database.createGroup(group);
    final oldName = await database.fetchGroupById(1);
    await database.updateGroupName(1, 'my new name');
    final newName = await database.fetchGroupById(1);
    expect(oldName.groupName, group.groupName.value);
    expect(newName.groupName, 'my new name');
  });
  test('delete word by id ', () async {
    // setup

    await database.createGroup(group);
    await database.addNewWordInGroup(word);
    await database.deleteWordById(1, 1);

    expect(() async => await database.fetchWordbyId(1), throwsStateError);
  });
  test('update word info ', () async {
    // setup
    await database.createGroup(group);
    await database.addNewWordInGroup(word);
    final newWord = WordCompanion(
      group: const Value(1),
      foreignWord: const Value('test2'),
      wordMeans: const Value('test2-test2'),
      wordImages: const Value(''),
      wordExamples: const Value('exampleTest-exampleTest'),
      wordNote: const Value(''),
      wordDate: Value(DateTime.now()),
    );

    await database.upadateWordInf(1, newWord);

    final getWord = await database.fetchWordbyId(1);

    expect(getWord.foreignWord, 'test2');
    expect(getWord.wordMeans, 'test2-test2');
    expect(getWord.wordExamples, word.wordExamples.value);
  });
  test('watch WordBy Id', () async {
    await database.createGroup(group);
    await database.addNewWordInGroup(word);
    expect(database.watchWordById(1).map((word) => word.foreignWord),
        emits(word.foreignWord.value));
    expect(database.watchWordById(1).map((word) => word.wordMeans),
        emits(word.wordMeans.value));
    expect(database.watchWordById(1).map((word) => word.wordExamples),
        emits(word.wordExamples.value));
  });
  test('watch Words By GroupId', () async {
    // setup
    await database.createGroup(group);
    await database.addNewWordInGroup(word);
    expect(
        database.watchWordsByGroupId(1).map((list) => list.length), emits(1));
    expect(
        database.watchWordsByGroupId(1).map((list) => list.first.foreignWord),
        emits(word.foreignWord.value));
    expect(database.watchWordsByGroupId(1).map((list) => list.first.wordMeans),
        emits(word.wordMeans.value));
    expect(
        database.watchWordsByGroupId(1).map((list) => list.first.wordExamples),
        emits(word.wordExamples.value));
  });
  test('watch Groups', () async {
    // setup
    await database.createGroup(group);
    await database.createGroup(GroupCompanion(
        groupName: const Value('new group 2'),
        creatingTime: Value(DateTime.now())));

    expect(database.watchGroups().map((list) => list.length), emits(2));
    expect(database.watchGroups().map((list) => list.first.groupName),
        emits('new group'));
    expect(database.watchGroups().map((list) => list.last.groupName),
        emits('new group 2'));
  });
  test('watch Group By Id', () async {
    // setup
    await database.createGroup(group);
    await database.createGroup(GroupCompanion(
        groupName: const Value('new group 2'),
        creatingTime: Value(DateTime.now())));

    expect(database.watchGroupById(1).map((list) => list.groupName),
        emits(group.groupName.value));
    expect(database.watchGroupById(2).map((list) => list.groupName),
        emits('new group 2'));
  });
}
