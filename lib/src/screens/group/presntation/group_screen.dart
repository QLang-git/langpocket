import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/group/utils/group_appbar.dart';

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
        body: Container(
          child: Text('groupscreen ${widget.groupId}'),
        ),
      ),
    );
  }
}
