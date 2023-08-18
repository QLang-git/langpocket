import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/features/todo/controller/todo_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoStyleButton extends ConsumerWidget {
  const TodoStyleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(todoControllerProvider);
    final ThemeData(:textTheme, :colorScheme) = Theme.of(context);
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          // Return a loading indicator or an alternative widget while waiting for SharedPreferences
          return LoadingAnimationWidget.hexagonDots(
              color: colorScheme.primary, size: 20);
        }

        final prefs = snapshot.data;
        final countTodo = prefs?.getInt('todoCount') ?? 0;

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
  }
}
