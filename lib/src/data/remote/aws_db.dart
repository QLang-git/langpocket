import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:langpocket/models/Group.dart';
import 'package:langpocket/models/Word.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';

class AwsDatabase {
  void saveNewGroupWithWords(
      List<GroupData> groups, List<WordData> words) async {
    for (var group in groups) {
      final groupData = Group(
          id: group.id.toString(),
          groupName: group.groupName,
          level: group.level,
          studyTime: TemporalDateTime(group.studyTime));
      try {
        await Amplify.DataStore.save<Group>(groupData);
        await _saveWordInGroup(words, groupData);
      } catch (e) {
        print("Error saving words $e ");
      }
    }
  }

  Future<void> _saveWordInGroup(List<WordData> words, Group groupData) async {
    for (var w in words) {
      final word = w.decoding();
      List<String> awsImageKeys = [];

      // Concurrent image uploads for a word
      var uploadTasks = word.wordImages.map((img) async {
        try {
          final uploadedFile = Amplify.Storage.uploadFile(
              localFile: AWSFile.fromPath(img), key: img);
          awsImageKeys.add(uploadedFile.request.key);
        } catch (e) {
          print("Error uploading image: $e");
          // Handle or rethrow the error as necessary
        }
      }).toList();

      // Wait for all image uploads for the current word to complete
      await Future.wait(uploadTasks);

      final wordData = Word(
        id: word.id.toString(),
        group: groupData,
        foreignWord: word.foreignWord,
        wordMeans: word.wordMeans,
        wordImages: awsImageKeys,
        wordExamples: word.wordExamples,
        wordNote: word.wordNote,
      );

      try {
        await Amplify.DataStore.save<Word>(wordData);
      } catch (e) {
        print("Error saving word: $e");
        // Handle or rethrow the error as necessary
      }
    }
  }

  Future<List<Group>> fetchAllGroups() async {
    return await Amplify.DataStore.query(Group.classType);
  }
}
