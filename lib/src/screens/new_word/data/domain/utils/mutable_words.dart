import 'package:langpocket/src/screens/new_word/data/domain/group_words_model.dart';
import 'package:langpocket/src/screens/new_word/data/domain/word_model.dart';
import 'package:langpocket/src/screens/new_word/data/domain/words_domain.dart';

/// Helper extension used to mutate the groups of words .
extension MutableWords on Words {
  /// update the given group to the new one by *overriding* it if already exists
  Words setGroup(GroupWords group) {
    final copy = Map<String, GroupWords>.from(groups);
    copy[group.groupWordsId] = group;
    return Words(copy);
  }

  // update or add the given group to the new one by *updating* it
  //if already exists update the group otherwise added new group
  Words addGroup(GroupWords group) {
    final copy = Map<String, GroupWords>.from(groups);
    copy.update(
      group.groupWordsId,
      // if there is already a group, update it With new one
      (groupToUpdate) => group,
      // otherwise, add the item with the given quantity
      ifAbsent: () => group,
    );
    return Words(copy);
  }

  /// update or add the given list of groups  by *updating* them  With new ones
  //if already exists update the group otherwise added new group
  Words addGroups(List<GroupWords> groupsToAdd) {
    final copy = Map<String, GroupWords>.from(groups);
    for (var group in groupsToAdd) {
      copy.update(
        group.groupWordsId,
        // if there is already a value, update it
        (value) => group,
        // otherwise, add the item with the given quantity
        ifAbsent: () => group,
      );
    }
    return Words(copy);
  }

  /// if a group with the given id is found, remove it
  Words removeGroupById(String groupId) {
    final copy = Map<String, GroupWords>.from(groups);
    copy.remove(groupId);
    return Words(copy);
  }

  /// if a group with the given id is found, remove it
  List<Word> findWordListInGroupById(String groupId) {
    List<Word> wordList = [];
    final copy = Map<String, GroupWords>.from(groups);
    copy.forEach((key, value) {
      if (key == groupId) {
        wordList = value.words;
      }
    });

    return wordList;
  }
}
