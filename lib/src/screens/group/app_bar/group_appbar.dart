import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/group/app_bar/group_appbar_controller.dart';

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
  Size get preferredSize => const Size.fromHeight(80);
}

class _GroupAppBarState extends State<GroupAppBar> {
  final inputKey = GlobalKey<FormState>();
  late String originalText;
  String input = '';
  bool editModeActivate = false;
  final focus = FocusNode();
  final controller = TextEditingController();

  @override
  void initState() {
    focus.addListener(() {
      if (!focus.hasFocus && editModeActivate) {
        focus.requestFocus();
      }
    });
    controller.text = widget.groupName;
    originalText = widget.groupName;
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
    final sizeWith = MediaQuery.of(context).size.width;

    return ResponsiveCenter(
      child: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 37),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(38),
                bottomRight: Radius.circular(38))),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 70,
        title: Column(
          children: [
            Form(
              key: inputKey,
              child: SizedBox(
                width: sizeWith * 0.5,
                child: TextFormField(
                  readOnly: !editModeActivate,
                  cursorColor: Colors.white,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (value) => setState(() {
                    input = value;
                  }),
                  autofocus: editModeActivate,
                  focusNode: focus,
                  enabled: editModeActivate,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This Field is required';
                    } else if (value.length > 20) {
                      return 'The name is too long';
                    } else {
                      return null;
                    }
                  },
                  controller: controller,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
            Text(
              widget.groupDate,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Colors.white),
            )
          ],
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: editModeActivate
                  ? Consumer(
                      builder: (context, ref, child) {
                        return IconButton(
                          onPressed: () {
                            if (originalText != controller.text) {
                              updateGroupName(widget.groupId, controller.text,
                                  ref, inputKey, context);
                              setState(() {
                                editModeActivate = false;
                                originalText = controller.text;
                              });
                            } else {
                              setState(() {
                                editModeActivate = false;
                              });
                            }
                          },
                          icon: const Icon(Icons.save_rounded,
                              size: 25, color: Colors.white),
                        );
                      },
                    )
                  : IconButton(
                      onPressed: () => setState(() {
                        editModeActivate = true;
                      }),
                      icon:
                          const Icon(Icons.edit, size: 25, color: Colors.white),
                    ))
        ],
      ),
    );
  }
}
