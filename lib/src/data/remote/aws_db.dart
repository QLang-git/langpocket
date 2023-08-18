import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/models/Group.dart';
import 'package:langpocket/models/Word.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';

class AwsDatabase {
  Future<void> syncDataToCloud(
      List<GroupData> groups, List<WordData> words) async {
    for (var group in groups) {
      try {
        // Update the group
        await _updateGroupInCloud(group.toCloudData());
      } catch (e) {
        // Create the group
        await _createGroupInCloud(group.toCloudData());
      }

      final groupWords = words.where((word) => word.group == group.id);
      for (var word in groupWords) {
        try {
          // Update the word
          await _updateWordInCloud(word.toCloudData(group.toCloudData()));
        } catch (e) {
          // Create the word
          await _createWordInCloud(word.toCloudData(group.toCloudData()));
        }
      }
    }
  }

  Future<Group?> _createGroupInCloud(Group group) async {
    try {
      final request = ModelMutations.create(group);
      final response = await Amplify.API.mutate(request: request).response;

      final createdGroup = response.data;
      if (createdGroup == null) {
        print('errors: ${response.errors}');
        return null;
      }
      return createdGroup;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
    }
    return null;
  }

  Future<Group?> _updateGroupInCloud(Group group) async {
    final request = ModelMutations.update(group);
    final response = await Amplify.API.mutate(request: request).response;
    return response.data;
  }

  Future<Word?> _createWordInCloud(Word word) async {
    final request = ModelMutations.update(word);
    final response = await Amplify.API.mutate(request: request).response;
    return response.data;
  }

  Future<Word?> _updateWordInCloud(Word word) async {
    final request = ModelMutations.update(word);
    final response = await Amplify.API.mutate(request: request).response;
    return response.data;
  }

  Future<List<Group>> syncDataFromCloud() async {
    final List<Group> groups = [];
    final request = ModelQueries.list(Group.classType);
    final response = await Amplify.API.query(request: request).response;
    for (var element in response.data?.items ?? []) {
      if (element != null) {
        groups.add(element);
      }
    }
    return groups;
  }
}

final awsDBProvider = Provider<AwsDatabase>((ref) {
  return AwsDatabase();
});
