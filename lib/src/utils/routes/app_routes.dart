import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/screens/group/screen/group_screen.dart';
import 'package:langpocket/src/screens/home/screen/home_screen.dart';
import 'package:langpocket/src/screens/new_word/screen/new_word_screen.dart';
import 'package:langpocket/src/screens/word_previewer/screen/word_previewer_screen.dart';
import 'package:langpocket/src/utils/routes/not_found_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_routes.g.dart';

enum AppRoute { home, newWord, wordView, group }

class WordDataToView {
  final String foreignWord;
  final List<String> wordMeans;
  final List<String> wordImages;
  final List<String> wordExamples;
  final String wordNote;

  WordDataToView(
      {required this.foreignWord,
      required this.wordMeans,
      required this.wordImages,
      required this.wordExamples,
      required this.wordNote});
}

@Riverpod(keepAlive: true)
GoRouter goRoute(GoRouteRef ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    routes: [
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
                        final word = state.extra as WordDataToView;
                        return _navGoRight(
                            WordPreviewerScreen(
                              imageList: word.wordImages,
                              foreignWord: word.foreignWord,
                              means: word.wordMeans,
                              examples: word.wordExamples,
                              note: word.wordNote,
                            ),
                            state);
                      })
                ]),
            GoRoute(
              path: 'group/:id/:name/:date',
              name: AppRoute.group.name,
              pageBuilder: (context, state) {
                final groupId = state.params['id']!;
                final groupName = state.params['name']!;
                final groupDate = state.params['date']!;

                return _navGoRight(
                    GroupScreen(
                      groupId: groupId,
                      groupName: groupName,
                      date: groupDate,
                    ),
                    state);
              },
            )
          ]),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
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
