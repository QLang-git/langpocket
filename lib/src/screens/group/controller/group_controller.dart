import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/services/word_service.dart';

class NewGroupInfo {
  final int groupId;
  final String groupName;

  NewGroupInfo({required this.groupId, required this.groupName});
}

final updateGroupNameProvider =
    FutureProvider.family<void, NewGroupInfo>((ref, groupInfo) async {
  await ref
      .watch(wordsServicesProvider)
      .updateGroupName(groupInfo.groupId, groupInfo.groupName);
});
