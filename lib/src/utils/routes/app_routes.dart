import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/screens/home/presntation/home_screen.dart';
import 'package:langpocket/src/screens/new_word/presntation/new_word_screen.dart';
import 'package:langpocket/src/screens/word_previewer/presntation/word_previewer_screen.dart';
import 'package:langpocket/src/utils/routes/not_found_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_routes.g.dart';

enum AppRoute { home, newWord, wordView }

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
