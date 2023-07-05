import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/screens/home/widgets/groups_list/controller/groups_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class GroupsList extends ConsumerStatefulWidget {
  const GroupsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GroupsListState();
}

class _GroupsListState extends ConsumerState<GroupsList> {
  @override
  Widget build(BuildContext context) {
    final groupsList = ref.watch(groupsControllerProvider);
    final sizeHeight = MediaQuery.of(context).size.height;

    return AsyncValueWidget(
        value: groupsList,
        data: (groups) {
          if (groups.isEmpty) {
            return SizedBox(
                width: double.infinity,
                height: sizeHeight * 1.5 / 4,
                child:
                    const Center(child: Text('You don\'t have any group yet')));
          }

          return ListView.builder(
              reverse: true,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: groups.length,
              itemBuilder: (BuildContext context, int index) {
                final textStyle = Theme.of(context).textTheme;
                final fontColor = Theme.of(context).colorScheme.outline;
                final dataName = groups[index].creatingTime;
                final wordsInGroup =
                    ref.watch(watchWordsListbyIdProvider(groups[index].id));
                final today = dataName.weekday;

                final icontDay = setDayLogo(today);
                return Padding(
                  padding: const EdgeInsets.only(left: 9, right: 8),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      key: Key('group-${groups[index].id}'),
                      onTap: () => context.goNamed(AppRoute.group.name,
                          extra: groups[index]),
                      child: SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: icontDay.dayColor,
                              ),
                              height: double.infinity,
                              width: 90,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    icontDay.dayIcon,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  Text(
                                    icontDay.dayName,
                                    style: textStyle.headlineSmall
                                        ?.copyWith(color: Colors.white),
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    groups[index].groupName,
                                    style: textStyle.displayLarge
                                        ?.copyWith(color: fontColor),
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Words: ',
                                        style: textStyle.bodyMedium
                                            ?.copyWith(color: fontColor),
                                      ),
                                      AsyncValueWidget(
                                          value: wordsInGroup,
                                          data: (words) => MyWordsInGroup(
                                                words: words,
                                              ))
                                    ],
                                  ),
                                  Text(
                                    'Date: ${dataName.day}/${dataName.month}/${dataName.year}',
                                    style: textStyle.bodyLarge
                                        ?.copyWith(color: fontColor),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}

class MyWordsInGroup extends StatelessWidget {
  final List<WordData> words;
  const MyWordsInGroup({
    super.key,
    required this.words,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final fontColor = Theme.of(context).colorScheme.outline;
    return Row(
      children: words.map((word) {
        if (words.last == word) {
          return Text(
            '${word.foreignWord} ',
            style: textStyle.bodyLarge?.copyWith(color: fontColor),
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        } else {
          return Text(
            '${word.foreignWord} , ',
            style: textStyle.bodyLarge?.copyWith(color: fontColor),
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        }
      }).toList(),
    );
  }
}
