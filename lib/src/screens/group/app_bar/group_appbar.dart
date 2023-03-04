import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/group/app_bar/group_appbar_controller.dart';
import 'package:langpocket/src/screens/group/controller/group_controller.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class GroupAppBar extends StatefulWidget with PreferredSizeWidget {
  final String groupName;
  final String groupDate;
  final int groupId;
  const GroupAppBar(
      {super.key,
      required this.groupName,
      required this.groupDate,
      required this.groupId});

  @override
  State<GroupAppBar> createState() => _GroupAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _GroupAppBarState extends State<GroupAppBar> {
  final inputKey = GlobalKey<FormState>();
  bool activateTextField = false;
  String input = '';
  bool state = false;
  final focus = FocusNode();
  final controller = TextEditingController();

  @override
  void initState() {
    focus.addListener(() {
      if (!focus.hasFocus && activateTextField) {
        focus.requestFocus();
        activateTextField = false;
      }
    });
    controller.text = widget.groupName;
    controller.selection =
        TextSelection.collapsed(offset: (widget.groupName.length / 2).round());
    super.initState();
  }

  @override
  void dispose() {
    focus.dispose();
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: AppBar(
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 70,
        flexibleSpace: Column(
          children: [
            GestureDetector(
              onLongPress: () => setState(() {
                state = true;
                activateTextField = true;
              }),
              child: Form(
                key: inputKey,
                child: TextFormField(
                  decoration: const InputDecoration(border: InputBorder.none),
                  textAlign: TextAlign.center,
                  onChanged: (value) => setState(() {
                    input = value;
                  }),
                  autofocus: state,
                  focusNode: focus,
                  enabled: state,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This Field is required ';
                    } else if (value.startsWith('0')) {
                      return 'Group name should not start with 0';
                    } else {
                      return null;
                    }
                  },
                  controller: controller,
                  style: headline2Bold(primaryFontColor),
                ),
              ),
            ),
            Text(
              widget.groupDate,
              style: bodySmallBold(primaryColor),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: primaryFontColor,
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.groupName != controller.text
                  ? Consumer(
                      builder: (context, ref, child) {
                        return IconButton(
                          onPressed: () => updateGroupName(widget.groupId,
                              controller.text, ref, inputKey, context),
                          icon: Icon(Icons.save_rounded,
                              size: 25, color: primaryFontColor),
                        );
                      },
                    )
                  : null)
        ],
      ),
    );
  }
}
