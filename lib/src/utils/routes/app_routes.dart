// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/features/group/screen/group_screen.dart';
import 'package:langpocket/src/features/home/screen/home_screen.dart';
import 'package:langpocket/src/features/new_word/screen/new_word_screen.dart';
import 'package:langpocket/src/features/practice/interactive/screen/practice_interactive_screen.dart';
import 'package:langpocket/src/features/practice/pronunciation/screen/practice_pron_group_screen.dart';
import 'package:langpocket/src/features/practice/pronunciation/screen/practice_pron_single_screen.dart';
import 'package:langpocket/src/features/practice/spelling/screens/practice_spelling_group_screen.dart';
import 'package:langpocket/src/features/practice/spelling/screens/practice_spelling_single_screen.dart';
import 'package:langpocket/src/features/todo/screen/todo_screen.dart';
import 'package:langpocket/src/features/welcome/screen/welcome_screen.dart';
import 'package:langpocket/src/features/word_edit/screen/edit_mode_word_screen.dart';
import 'package:langpocket/src/features/word_previewer/screen/word_previewer_screen.dart';
import 'package:langpocket/src/features/word_view/screen/word_view_screen.dart';
import 'package:langpocket/src/utils/routes/error_nav_screen.dart';
import 'package:langpocket/src/utils/routes/router_controller.dart';

enum AppRoute {
  home,
  newWord,
  wordView,
  group,
  word,
  editMode,
  spelling,
  pronunciation,
  interactive,
  todo
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final controller = ref.watch(routerControllerProvider);
  return controller.when(
      data: (routing) => GoRouter(
          initialLocation: '/',
          routes: appRouting,
          redirect: ((context, state) {
            if (routing.isFirstTime) {
              return '/welcome';
            } else {
              return null;
            }
          })),
      // todo: handle Error
      error: (_, st) => GoRouter(routes: []),
      loading: () => GoRouter(initialLocation: '/', routes: [
            GoRoute(
              path: '/',
              builder: (context, state) {
                print('loading....');
                return const LinearProgressIndicator();
              },
            )
          ]));
});

List<RouteBase> appRouting = [
  GoRoute(
    path: '/welcome',
    builder: (context, state) => const WelcomeScreen(),
  ),
  GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
            path: 'new-word',
            name: AppRoute.newWord.name,
            pageBuilder: (context, state) =>
                _navGoUp(const NewWordScreen(), state),
            routes: [
              GoRoute(
                  path: 'view',
                  name: AppRoute.wordView.name,
                  pageBuilder: (context, state) {
                    return _navGoRight(const WordPreviewerScreen(), state);
                  })
            ]),
        GoRoute(
          path: 'todo',
          name: AppRoute.todo.name,
          pageBuilder: (context, state) =>
              _navGoRight(const TodoScreen(), state),
        ),
        GoRoute(
            path: 'g/:groupId',
            name: AppRoute.group.name,
            pageBuilder: (context, state) {
              final groupId = state.pathParameters['groupId'];
              final groupName = state.uri.queryParameters['name'];
              final creatingTime = state.uri.queryParameters['time'];
              if (groupId != null &&
                  int.tryParse(groupId) != null &&
                  groupName != null &&
                  creatingTime != null &&
                  DateTime.tryParse(creatingTime) != null) {
                return _navGoRight(
                    GroupScreen(groupId: int.parse(groupId)), state);
              } else {
                return _navGoUp(const ErrorNavScreen(), state);
              }
            },
            routes: [
              GoRoute(
                  path: 'w/:wordId',
                  name: AppRoute.word.name,
                  pageBuilder: (context, state) {
                    final wordId = state.pathParameters['wordId'];
                    if (wordId != null) {
                      return _navGoRight(
                          WordViewScreen(wordId: int.parse(wordId)), state);
                    } else {
                      return _navGoUp(const ErrorNavScreen(), state);
                    }
                  },
                  routes: [
                    GoRoute(
                      path: 'edit-mode',
                      name: AppRoute.editMode.name,
                      pageBuilder: (context, state) {
                        final wordId = state.pathParameters['wordId'];

                        if (wordId != null) {
                          return _navGoRight(
                              EditModeWordScreen(
                                wordId: int.parse(wordId),
                              ),
                              state);
                        } else {
                          return _navGoUp(const ErrorNavScreen(), state);
                        }
                      },
                    ),
                  ]),
              GoRoute(
                  path: 'spelling/:wordId',
                  name: AppRoute.spelling.name,
                  pageBuilder: (context, state) {
                    final groupId = state.uri.queryParameters['groupId'];
                    final wordId = state.pathParameters['wordId'];

                    if (_validatePath(wordId, groupId)) {
                      if (groupId != null) {
                        return _navGoUp(
                            PracticeSpellingGroupScreen(
                                groupId: int.parse(groupId)),
                            state);
                      } else {
                        return _navGoUp(
                            PracticeSpellingSingleScreen(
                                wordId: int.parse(wordId!)),
                            state);
                      }
                    } else {
                      return _navGoUp(const ErrorNavScreen(), state);
                    }
                  }),
              GoRoute(
                  path: 'pron/:wordId',
                  name: AppRoute.pronunciation.name,
                  pageBuilder: (context, state) {
                    final groupId = state.uri.queryParameters['groupId'];
                    final wordId = state.pathParameters['wordId'];

                    if (_validatePath(wordId, groupId)) {
                      if (groupId != null) {
                        return _navGoUp(
                            PracticePronGroupScreen(
                                groupId: int.parse(groupId)),
                            state);
                      } else {
                        return _navGoUp(
                            PracticePronSingleScreen(
                                wordId: int.parse(wordId!)),
                            state);
                      }
                    } else {
                      return _navGoUp(const ErrorNavScreen(), state);
                    }
                  }),
              GoRoute(
                  path: 'interactive/:wordId',
                  name: AppRoute.interactive.name,
                  pageBuilder: (context, state) {
                    final wordId = state.pathParameters['wordId'];
                    if (_validatePath(wordId, null)) {
                      return _navGoUp(
                          PracticeInteractiveScreen(wordId: int.parse(wordId!)),
                          state);
                    } else {
                      return _navGoUp(const ErrorNavScreen(), state);
                    }
                  }),
            ]),
      ]),
];

bool _validatePath(String? wordId, String? groupId) {
  return wordId != null && int.tryParse(wordId) != null ||
      groupId != null && int.tryParse(groupId) != null;
}

CustomTransitionPage _navGoUp(Widget screen, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

CustomTransitionPage _navGoRight(Widget screen, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1, 0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
