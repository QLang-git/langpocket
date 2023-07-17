import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/screens/home/controller/home_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class GroupsList extends ConsumerStatefulWidget {
  const GroupsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GroupsListState();
}

class _GroupsListState extends ConsumerState<GroupsList> {
  late HomeController homeController;
  @override
  void initState() {
    homeController = HomeController(ref: ref);
    homeController.initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);
    return AsyncValueWidget(
        value: homeController.getAllGroups(),
        child: (groups) {
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
                final wordsInGroup =
                    homeController.getWordsInGroupById(groups[index].id);
                final iconDay = homeController.getLogoDay(groups[index]);
                return Padding(
                  padding: const EdgeInsets.only(left: 9, right: 8),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      key: Key('group-${groups[index].id}'),
                      onTap: () => context.goNamed(
                        AppRoute.group.name,
                        pathParameters: {
                          'groupId': groups[index].id.toString(),
                        },
                        queryParameters: {
                          'name': groups[index].groupName,
                          'time': groups[index].creatingTime.toString()
                        },
                      ),
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
                                color: iconDay.dayColor,
                              ),
                              height: double.infinity,
                              width: 90,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    iconDay.dayIcon,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  Text(
                                    iconDay.dayName,
                                    style: textTheme.headlineSmall
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
                                    style: textTheme.displayLarge
                                        ?.copyWith(color: colorScheme.outline),
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Words: ',
                                        style: textTheme.bodyMedium?.copyWith(
                                            color: colorScheme.outline),
                                      ),
                                      AsyncValueWidget(
                                          value: wordsInGroup,
                                          child: (words) {
                                            return MyWordsInGroup(
                                              words: words,
                                            );
                                          })
                                    ],
                                  ),
                                  Text(
                                    homeController.formatTime(groups[index]),
                                    style: textTheme.bodyLarge
                                        ?.copyWith(color: colorScheme.outline),
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
