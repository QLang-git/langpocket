import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/screens/group/app_bar/group_appbar.dart';
import 'package:langpocket/src/screens/group/widgets/words_list.dart';

class GroupScreen extends ConsumerStatefulWidget {
  final GroupData groupData;
  const GroupScreen({
    super.key,
    required this.groupData,
  });

  @override
  ConsumerState<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends ConsumerState<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    final groupDate = widget.groupData.creatingTime;
    final dateFormat = '${groupDate.day}/${groupDate.month}/${groupDate.year}';
    return ResponsiveCenter(
      child: Scaffold(
        appBar: GroupAppBar(
          groupName: widget.groupData.groupName,
          groupDate: dateFormat,
          groupId: widget.groupData.id,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          child: WordsGroups(
            groupId: widget.groupData.id,
            groupName: widget.groupData.groupName,
            date: dateFormat,
          ),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Theme.of(context).colorScheme.primary,
          buttonSize: const Size(70.0, 70.0),
          children: [
            SpeedDialChild(
              child: const Icon(
                Icons.play_arrow_rounded,
                size: 30,
              ),
              label: 'Listen to the Group\'s audio clip ',
            ),
            SpeedDialChild(
              child: const Icon(Icons.spellcheck_rounded, size: 30),
              label: 'practice spelling for Group words',
            ),
            SpeedDialChild(
              child: const Icon(Icons.speaker, size: 30),
              label: 'practice pronunciation for Group words',
            ),
          ],
        ),
      ),
    );
  }
}
