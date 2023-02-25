import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/screens/group/screen/group_screen.dart';
import 'package:langpocket/src/screens/home/screen/home_screen.dart';
import 'package:langpocket/src/screens/new_word/screen/new_word_screen.dart';
import 'package:langpocket/src/screens/practice/spelling/screen/practice_spelling_screen.dart';
import 'package:langpocket/src/screens/word_edit/screen/edit_mode_word_screen.dart';
import 'package:langpocket/src/screens/word_previewer/screen/word_previewer_screen.dart';
import 'package:langpocket/src/screens/word_view/screen/word_view_screen.dart';
import 'package:langpocket/src/utils/routes/error_nav_screen.dart';
import 'package:langpocket/src/utils/routes/not_found_screen.dart';

enum AppRoute { home, newWord, wordView, group, word, editMode, spelling }

class WordDataToView {
  final String foreignWord;
  final List<String> wordMeans;
  final List<String> wordImages;
  final List<String> wordExamples;
  final String wordNote;

  WordDataToView({
    required this.foreignWord,
    required this.wordMeans,
    required this.wordImages,
    required this.wordExamples,
    required this.wordNote,
  });
}

final GoRouter goroute = GoRouter(
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
                      final word = state.extra as WordDataToView?;

                      if (word is WordDataToView) {
                        return _navGoRight(
                            WordPreviewerScreen(wordData: word), state);
                      } else {
                        return _navGoUp(const ErrorNavScreen(), state);
                      }
                    })
              ]),
          GoRoute(
              path: 'group',
              name: AppRoute.group.name,
              pageBuilder: (context, state) {
                final groupData = state.extra as GroupData?;
                if (groupData is GroupData) {
                  return _navGoRight(GroupScreen(groupData: groupData), state);
                } else {
                  return _navGoUp(const ErrorNavScreen(), state);
                }
              },
              routes: [
                GoRoute(
                  path: 'word',
                  name: AppRoute.word.name,
                  pageBuilder: (context, state) {
                    final word = state.extra as WordData?;
                    if (word is WordData) {
                      return _navGoRight(WordViewScreen(word: word), state);
                    } else {
                      return _navGoUp(const ErrorNavScreen(), state);
                    }
                  },
                  routes: [
                    GoRoute(
                      path: 'edit-mode',
                      pageBuilder: (context, state) {
                        final word = state.extra as WordData?;
                        if (word is WordData) {
                          return _navGoRight(
                              EditModeWordScreen(
                                wordData: word,
                              ),
                              state);
                        } else {
                          return _navGoUp(const ErrorNavScreen(), state);
                        }
                      },
                    ),
                    GoRoute(
                      path: 'spelling',
                      name: AppRoute.spelling.name,
                      pageBuilder: (context, state) {
                        final word = state.extra as WordData?;
                        if (word != null) {
                          return _navGoUp(
                              PracticeSpellingScreen(
                                  imageList: word.imagesList(),
                                  foreignWord: word.foreignWord,
                                  meanList: word.meansList(),
                                  examplesList: word.examplesList()),
                              state);
                        } else {
                          return _navGoUp(const ErrorNavScreen(), state);
                        }
                      },
                    )
                  ],
                )
              ]),
        ]),
  ],
  errorPageBuilder: (context, state) => _navGoUp(const NotFoundScreen(), state),
  errorBuilder: (context, state) => const NotFoundScreen(),
);

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
