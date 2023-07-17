import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/screens/group/app_bar/group_appbar.dart';
import 'package:langpocket/src/screens/group/controller/group_controller.dart';
import 'package:langpocket/src/screens/group/widgets/words_list.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class GroupScreen extends ConsumerStatefulWidget {
  final int groupId;
  final String groupName;
  final DateTime creatingTime;
  const GroupScreen(
      {super.key,
      required this.groupName,
      required this.groupId,
      required this.creatingTime});

  @override
  ConsumerState<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends ConsumerState<GroupScreen> {
  late GroupController groupController;

  @override
  void initState() {
    groupController = GroupController(ref: ref, groupId: widget.groupId);
    groupController.initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
        child: AsyncValueWidget(
            value: groupController.getWordsInGroupById(widget.groupId),
            child: (wordsList) {
              final wordRecords =
                  wordsList.map((word) => word.decoding()).toList();
              return Scaffold(
                appBar: GroupAppBar(
                  groupController: groupController,
                  groupName: widget.groupName,
                  creatingTime: widget.creatingTime,
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  child: WordsGroups(
                      groupController: groupController, words: wordRecords),
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
                      label: ' Listen to the Audio Clips : Group Practice',
                      onTap: () => context.pushNamed(
                        AppRoute.audioClip.name,
                        pathParameters: {
                          'wordId': wordRecords.first.id.toString(),
                        },
                        queryParameters: {'groupName': widget.groupName},
                      ),
                    ),
                    SpeedDialChild(
                        child: const Icon(Icons.spellcheck_rounded, size: 30),
                        label: 'Master Your Spelling: Group Practice',
                        onTap: () {
                          context.pushNamed(AppRoute.spelling.name,
                              pathParameters: {
                                'wordId': wordRecords.first.id.toString(),
                                'groupId': widget.groupId.toString(),
                              },
                              queryParameters: {
                                'groupId': widget.groupId.toString(),
                              });
                        }),
                    SpeedDialChild(
                        child: const Icon(Icons.record_voice_over, size: 30),
                        label: 'Perfect Your Pronunciation: Group Practice',
                        onTap: () {
                          context.pushNamed(AppRoute.pronunciation.name,
                              pathParameters: {
                                'wordId': wordRecords.first.id.toString(),
                              },
                              queryParameters: {
                                'groupId': widget.groupId
                              });
                        }),
                  ],
                ),
              );
            }));
  }
}
