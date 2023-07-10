import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/screens/group/app_bar/group_appbar.dart';
import 'package:langpocket/src/screens/group/controller/group_controller.dart';
import 'package:langpocket/src/screens/group/widgets/words_list.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

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
  late GroupController groupController;

  late ({
    String dataFormat,
    String groupName,
  }) groupInfo;
  @override
  void initState() {
    groupController = GroupController(ref: ref, groupData: widget.groupData);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: Scaffold(
        appBar: GroupAppBar(groupController: groupController),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          child: WordsGroups(groupController: groupController),
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
              onTap: () => context.pushNamed(AppRoute.audioClip.name,
                  pathParameters: {
                    'id': GroupController.currentWordList!.first.id.toString(),
                  },
                  extra: GroupController.currentWordList),
            ),
            SpeedDialChild(
                child: const Icon(Icons.spellcheck_rounded, size: 30),
                label: 'Master Your Spelling: Group Practice',
                onTap: () {
                  context.pushNamed(AppRoute.spelling.name,
                      extra: GroupController.currentWordList!.first,
                      pathParameters: {
                        'id': GroupController.currentWordList!.first.id
                            .toString(),
                      },
                      queryParameters: {
                        'groupId': widget.groupData.id.toString()
                      });
                }),
            SpeedDialChild(
                child: const Icon(Icons.record_voice_over, size: 30),
                label: 'Perfect Your Pronunciation: Group Practice',
                onTap: () {
                  context.pushNamed(AppRoute.pronunciation.name,
                      extra: GroupController.currentWordList!.first,
                      pathParameters: {
                        'id': GroupController.currentWordList!.first.id
                            .toString(),
                      },
                      queryParameters: {
                        'groupId': widget.groupData.id.toString()
                      });
                }),
          ],
        ),
      ),
    );
  }
}
