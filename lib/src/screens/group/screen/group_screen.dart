import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/group/app_bar/group_appbar.dart';
import 'package:langpocket/src/screens/group/widgets/words_list.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class GroupScreen extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String date;
  const GroupScreen(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.date});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: Scaffold(
        appBar: GroupAppBar(
          groupName: widget.groupName,
          groupDate: widget.date,
          groupId: int.parse(widget.groupId),
        ),
        body: SingleChildScrollView(
            child: WordsGroups(groupId: int.parse(widget.groupId))),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: buttonColor,
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
