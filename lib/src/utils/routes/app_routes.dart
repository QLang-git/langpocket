// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/screens/group/screen/group_screen.dart';
import 'package:langpocket/src/screens/home/screen/home_screen.dart';
import 'package:langpocket/src/screens/new_word/screen/new_word_screen.dart';
import 'package:langpocket/src/screens/practice/audio/screen/audio_screen.dart';
import 'package:langpocket/src/screens/practice/interactive/screen/practice_interactive_screen.dart';
import 'package:langpocket/src/screens/practice/pronunciation/screen/practice_pron_screen.dart';
import 'package:langpocket/src/screens/practice/spelling/screen/practice_spelling_screen.dart';
import 'package:langpocket/src/screens/word_edit/screen/edit_mode_word_screen.dart';
import 'package:langpocket/src/screens/word_previewer/screen/word_previewer_screen.dart';
import 'package:langpocket/src/screens/word_view/screen/word_view_screen.dart';
import 'package:langpocket/src/utils/routes/error_nav_screen.dart';
import 'package:langpocket/src/utils/routes/not_found_screen.dart';

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
  audioClip
}

class WordRecord {
  final int? id;
  final String foreignWord;
  final List<String> wordMeans;
  final List<Uint8List> wordImages;
  final List<String> wordExamples;
  final String wordNote;

  WordRecord({
    this.id,
    required this.foreignWord,
    required this.wordMeans,
    required this.wordImages,
    required this.wordExamples,
    required this.wordNote,
  });

  @override
  String toString() {
    return 'Word(id: $id, foreignWord: $foreignWord, wordMeans: $wordMeans, wordImages: $wordImages, wordExamples: $wordExamples, wordNote: $wordNote)';
  }
}

final GoRouter goroute = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
  routes: appScreens,
  errorPageBuilder: (context, state) => _navGoUp(const NotFoundScreen(), state),
  errorBuilder: (context, state) => const NotFoundScreen(),
);

final appScreens = [
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
                    final word = state.extra as WordRecord?;

                    if (word is WordRecord) {
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
                path: 'word/:id',
                name: AppRoute.word.name,
                pageBuilder: (context, state) {
                  final wordId = state.pathParameters['id'];
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
                      final word = state.extra as WordRecord?;
                      if (word is WordRecord) {
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
                      final word = state.extra as WordRecord?;
                      if (word != null) {
                        final groupId = state.queryParameters['groupId'];

                        return _navGoUp(
                            PracticeSpellingScreen(
                              word: word,
                              groupId: groupId,
                            ),
                            state);
                      } else {
                        return _navGoUp(const ErrorNavScreen(), state);
                      }
                    },
                  ),
                  GoRoute(
                    path: 'pronunciation',
                    name: AppRoute.pronunciation.name,
                    pageBuilder: (context, state) {
                      final word = state.extra as WordRecord?;
                      if (word != null) {
                        final groupId = state.queryParameters['groupId'];
                        return _navGoUp(
                            PracticePronScreen(
                              key: ValueKey(
                                  DateTime.now().millisecondsSinceEpoch),
                              word: word,
                              groupId: groupId,
                            ),
                            state);
                      } else {
                        return _navGoUp(const ErrorNavScreen(), state);
                      }
                    },
                  ),
                  GoRoute(
                    path: 'interactively',
                    name: AppRoute.interactive.name,
                    pageBuilder: (context, state) {
                      final word = state.extra as WordRecord?;
                      if (word != null) {
                        return _navGoUp(
                            PracticeInteractiveScreen(
                              key: ValueKey(
                                  DateTime.now().millisecondsSinceEpoch),
                              wordRecord: word,
                            ),
                            state);
                      } else {
                        return _navGoUp(const ErrorNavScreen(), state);
                      }
                    },
                  ),
                  GoRoute(
                    path: 'audio',
                    name: AppRoute.audioClip.name,
                    pageBuilder: (context, state) {
                      final words = state.extra as List<WordRecord>?;
                      if (words != null) {
                        final groupName = state.queryParameters['groupName'];
                        return _navGoUp(
                            AudioScreen(
                              groupName: groupName!,
                              words: words,
                            ),
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
];

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
