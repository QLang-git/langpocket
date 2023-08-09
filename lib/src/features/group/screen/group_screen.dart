import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/features/group/app_bar/group_appbar.dart';
import 'package:langpocket/src/features/group/controller/group_controller.dart';
import 'package:langpocket/src/features/group/widgets/words_list.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class GroupScreen extends ConsumerStatefulWidget {
  final int groupId;
  const GroupScreen({
    super.key,
    required this.groupId,
  });

  @override
  ConsumerState<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends ConsumerState<GroupScreen> {
  late GroupController groupController;

  @override
  void initState() {
    groupController =
        ref.read(groupControllerProvider(widget.groupId).notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(groupControllerProvider(widget.groupId));
    return ResponsiveCenter(
        child: AsyncValueWidget(
            value: data,
            child: (wordsGroup) {
              final wordsList = wordsGroup.wordsData;
              return Scaffold(
                appBar: GroupAppBar(
                  creatingTime: wordsGroup.groupData.creatingTime,
                  groupName: wordsGroup.groupData.groupName,
                  groupController: groupController,
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  child: WordsList(
                      words: wordsList, groupController: groupController),
                ),
                floatingActionButton: SpeedDial(
                  animatedIcon: AnimatedIcons.menu_close,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  buttonSize: const Size(70.0, 75.0),
                  children: [
                    SpeedDialChild(
                        child: const Icon(Icons.spellcheck_rounded, size: 30),
                        label: 'Master Your Spelling',
                        onTap: () {
                          context.pushNamed(AppRoute.spelling.name,
                              pathParameters: {
                                'wordId': wordsList.first.id.toString(),
                                'groupId': widget.groupId.toString(),
                              },
                              queryParameters: {
                                'groupId': widget.groupId.toString(),
                              });
                        }),
                    SpeedDialChild(
                        child: const Icon(Icons.record_voice_over, size: 30),
                        label: 'Perfect Your Pronunciation',
                        onTap: () {
                          context.pushNamed(AppRoute.pronunciation.name,
                              pathParameters: {
                                'wordId': wordsList.first.id.toString(),
                                'groupId': widget.groupId.toString(),
                              },
                              queryParameters: {
                                'groupId': widget.groupId.toString(),
                              });
                        }),
                  ],
                ),
              );
            }));
  }
}
