import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/screens/home/widgets/groups_list/controller/groups_controller.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
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

          return Column(
              children: groups.map((group) {
            final dataName = group.creatingTime;
            final wordsInGroup =
                ref.watch(watchWordsListbyIdProvider(group.id));
            final today = dataName.weekday;

            final icontDay = setDayLogo(today);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: InkWell(
                  key: Key('group-${group.id}'),
                  onTap: () =>
                      context.goNamed(AppRoute.group.name, extra: group),
                  child: SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            color: icontDay.dayColor,
                          ),
                          height: double.infinity,
                          width: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(icontDay.dayIcon, color: Colors.white),
                              Text(
                                icontDay.dayName,
                                style: captionStyle(Colors.white),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                group.groupName,
                                style: headline3Bold(primaryFontColor),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Words: ',
                                    style: bodyLarge(primaryFontColor),
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
                                style: bodyLarge(primaryFontColor),
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
          }).toList());
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
    return Row(
      children: words.map((word) {
        if (words.last == word) {
          return Text(
            '${word.foreignWord} ',
            style: bodyLargeBold(primaryColor),
          );
        } else {
          return Text(
            '${word.foreignWord} , ',
            overflow: TextOverflow.ellipsis,
            style: bodyLargeBold(primaryColor),
          );
        }
      }).toList(),
    );
  }
}
