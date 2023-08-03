import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/features/home/controller/home_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GroupsList extends ConsumerStatefulWidget {
  const GroupsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GroupsListState();
}

class _GroupsListState extends ConsumerState<GroupsList> {
  late HomeController homeController;
  @override
  void initState() {
    super.initState();
    homeController = HomeController();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);

    final HomeController(
      :groupsListStreamProvider,
      :getLogoDay,
      :formatTime,
      :wordsListStreamProvider
    ) = homeController;
    final groups = ref.watch(groupsListStreamProvider);
    final sizeHeight = MediaQuery.of(context).size.height;
    return AsyncValueWidget(
        value: groups,
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: groups.length,
              itemBuilder: (BuildContext context, int index) {
                final wordsInGroup =
                    ref.watch(wordsListStreamProvider(groups[index].id));
                final iconDay = getLogoDay(groups[index]);
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
                          'groupId': groups[index].id.toString()
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
                            Flexible(
                              fit: FlexFit.loose,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        groups[index].groupName,
                                        style: textTheme.displayLarge?.copyWith(
                                            color: colorScheme.outline),
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                            'Words: ',
                                            style: textTheme.bodyMedium
                                                ?.copyWith(
                                                    color: colorScheme.outline),
                                          ),
                                          wordsInGroup.when(
                                              data: (words) {
                                                String text = words
                                                    .map((word) =>
                                                        word.foreignWord)
                                                    .join(", ");
                                                return Expanded(
                                                  child: Text(
                                                    text,
                                                    style: textTheme.bodyLarge
                                                        ?.copyWith(
                                                            color: colorScheme
                                                                .outline),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: false,
                                                  ),
                                                );
                                              },
                                              loading: () =>
                                                  LoadingAnimationWidget
                                                      .waveDots(
                                                          color: colorScheme
                                                              .outline,
                                                          size: 20),
                                              error: (error, stackTrace) =>
                                                  const Text(
                                                    'Failed Loading the words',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        formatTime(groups[index]),
                                        style: textTheme.bodyLarge?.copyWith(
                                            color: colorScheme.outline),
                                      ),
                                    ),
                                  ],
                                ),
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
