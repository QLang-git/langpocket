import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/features/group/controller/group_controller.dart';

//PreferredSizeWidget
class GroupAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GroupController groupController;
  final String groupName;
  final DateTime creatingTime;
  const GroupAppBar({
    super.key,
    required this.creatingTime,
    required this.groupName,
    required this.groupController,
  });

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
  late String currentGroupName;
  @override
  void initState() {
    final GroupAppBar(:groupName) = widget;
    controller.text = groupName;
    currentGroupName = groupName;
    controller.selection =
        TextSelection.collapsed(offset: (groupName.length / 2).round());
    focus.addListener(() {
      if (!focus.hasFocus && editModeActivate) {
        focus.requestFocus();
      }
    });
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
    void setEditMode(bool state) => setState(() {
          editModeActivate = state;
        });

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
              widget.groupController.generateGroupDate(widget.creatingTime),
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
              child: Consumer(
                builder: (context, ref, child) {
                  return IconButton(
                    onPressed: () async {
                      if (editModeActivate) {
                        await widget.groupController
                            .editGroupName(widget.groupName, controller,
                                context, inputKey, setEditMode)
                            .then((res) => showSnackBar(res, context))
                            .then((_) => setEditMode(false));
                      } else {
                        setEditMode(true);
                      }
                    },
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: editModeActivate
                          ? Icon(Icons.save_rounded,
                              size: 25, color: Colors.white, key: UniqueKey())
                          : Icon(Icons.edit,
                              size: 25, color: Colors.white, key: UniqueKey()),
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }

  void showSnackBar(bool res, BuildContext context) async {
    if (res) {
      final snackBarContent = res
          ? 'The name of the group has been changed'
          : 'Error: Please try again';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(snackBarContent)),
      );
    }
  }
}
