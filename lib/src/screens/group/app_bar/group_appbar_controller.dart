import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/screens/group/controller/group_controller.dart';

//! widget test
void updateGroupName(int id, String newName, WidgetRef ref,
    GlobalKey<FormState> inputKey, BuildContext context) {
  if (inputKey.currentState!.validate()) {
    final newInfo = NewGroupInfo(groupId: id, groupName: newName);
    var res = ref.read(updateGroupNameProvider(newInfo));
    if (res.hasError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error : try again')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('The name of the group has been changed')),
      );
    }
  }
}
