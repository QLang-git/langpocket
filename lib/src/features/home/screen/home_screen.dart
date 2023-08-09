import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/features/home/controller/home_controller.dart';
import 'package:langpocket/src/features/home/widgets/groups_list.dart';
import 'package:langpocket/src/features/home/app_bar/home_appbar.dart';
import 'package:langpocket/src/features/todo/controller/todo_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);
    return ResponsiveCenter(
      child: Scaffold(
        backgroundColor: colorScheme.background,
        appBar: HomeAppBar(
          screenHeight: sizeHeight,
          userName: 'User',
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Groups',
                          style: textTheme.headlineLarge
                              ?.copyWith(color: colorScheme.outline)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.onPrimary,
                          ),
                          onPressed: () => context.goNamed(AppRoute.todo.name),
                          child: const TodoStyleButton())
                    ],
                  ),
                ),
                const GroupsList()
              ],
            ),
          ),
        ),
        floatingActionButton: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
          ),
          child: const Icon(
            Icons.add,
            size: 55,
            color: Colors.white,
          ),
          onPressed: () => context.goNamed(AppRoute.newWord.name),
        ),
      ),
    );
  }
}

class TodoStyleButton extends StatelessWidget {
  const TodoStyleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData(:textTheme) = Theme.of(context);
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueWidget(
          value: ref.watch(todoControllerProvider),
          child: (todos) {
            final countTodo = todos.first.activeTodos;
            print(countTodo);
            return badges.Badge(
              position: badges.BadgePosition.topEnd(top: -25, end: 43),
              showBadge: countTodo != 0,
              ignorePointer: false,
              badgeContent: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  countTodo.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              badgeAnimation: const badges.BadgeAnimation.rotation(
                loopAnimation: true,
                animationDuration: Duration(seconds: 5),
                disappearanceFadeAnimationDuration: Duration(seconds: 3),
              ),
              badgeStyle: badges.BadgeStyle(
                shape: badges.BadgeShape.circle,
                badgeColor: const Color.fromARGB(255, 150, 44, 37),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Todo',
                style: textTheme.labelMedium?.copyWith(color: Colors.white),
              ),
            );
          },
        );
      },
    );
  }
}
