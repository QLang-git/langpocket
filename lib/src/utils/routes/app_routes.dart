// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:langpocket/src/screens/group/screen/group_screen.dart';
import 'package:langpocket/src/screens/home/screen/home_screen.dart';
import 'package:langpocket/src/screens/new_word/screen/new_word_screen.dart';
import 'package:langpocket/src/screens/practice/interactive/screen/practice_interactive_screen.dart';
import 'package:langpocket/src/screens/practice/pronunciation/screen/practice_pron_group_screen.dart';
import 'package:langpocket/src/screens/practice/pronunciation/screen/practice_pron_single_screen.dart';
import 'package:langpocket/src/screens/practice/spelling/screens/practice_spelling_group_screen.dart';
import 'package:langpocket/src/screens/practice/spelling/screens/practice_spelling_single_screen.dart';
import 'package:langpocket/src/screens/todo/screen/todo_screen.dart';
import 'package:langpocket/src/screens/word_edit/screen/edit_mode_word_screen.dart';
import 'package:langpocket/src/screens/word_previewer/screen/word_previewer_screen.dart';
import 'package:langpocket/src/screens/word_view/screen/word_view_screen.dart';
import 'package:langpocket/src/utils/routes/error_nav_screen.dart';

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
  audioClip,
  todo
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
  routes: appScreens,
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
              final groupName = state.queryParameters['name'];
              final creatingTime = state.queryParameters['time'];
              if (groupId != null &&
                  int.tryParse(groupId) != null &&
                  groupName != null &&
                  creatingTime != null &&
                  DateTime.tryParse(creatingTime) != null) {
                return _navGoRight(
                    GroupScreen(
                      groupId: int.parse(groupId),
                      groupName: groupName,
                      creatingTime: DateTime.parse(creatingTime),
                    ),
                    state);
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
                  ]),
              GoRoute(
                  path: 'spelling/:wordId',
                  name: AppRoute.spelling.name,
                  pageBuilder: (context, state) {
                    final groupId = state.queryParameters['groupId'];
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
                    final groupId = state.queryParameters['groupId'];
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
                  })
            ]
            // routes:
            // [
            //   GoRoute(
            //     path: ':wordId',
            //     name: AppRoute.word.name,
            //     pageBuilder: (context, state) {
            //       final wordId = state.pathParameters['wordId'];
            //       if (wordId != null) {
            //         return _navGoRight(
            //             WordViewScreen(wordId: int.parse(wordId)), state);
            //       } else {
            //         return _navGoUp(const ErrorNavScreen(), state);
            //       }
            //     },
            //     routes: [
            //       GoRoute(
            //         path: 'edit-mode',
            //         name: AppRoute.editMode.name,
            //         pageBuilder: (context, state) {
            //           final word = state.extra as WordRecord?;
            //           if (word is WordRecord) {
            //             return _navGoRight(
            //                 EditModeWordScreen(
            //                   wordData: word,
            //                 ),
            //                 state);
            //           } else {
            //             return _navGoUp(const ErrorNavScreen(), state);
            //           }
            //         },
            //       ),
            //       //  'groupId': groups[index].id.toString(),
            //       //     'name': groups[index].groupName,
            //       //     'time': groups[index].creatingTime.toString()
            //       GoRoute(
            //           path: 'spelling/:wordId',
            //           name: AppRoute.spelling.name,
            //           pageBuilder: (context, state) {
            //             final groupId = state.queryParameters['groupId'];
            //             final wordId = state.pathParameters['wordId'];
            //             print("wordId : $wordId ; groupId : $groupId");
            //             if (_validatePath(wordId, groupId)) {
            //               return _navGoUp(Text('gggg'), state);
            //             } else {
            //               return _navGoUp(const ErrorNavScreen(), state);
            //             }
            //           }),
            //       GoRoute(
            //         path: 'pronunciation',
            //         name: AppRoute.pronunciation.name,
            //         pageBuilder: (context, state) {
            //           final wordId = state.pathParameters['wordId'];
            //           final groupId = state.queryParameters['groupId'];

            //           if (_validatePath(wordId, groupId)) {
            //             return _navGoUp(
            //                 PracticePronScreen(
            //                   key: ValueKey(
            //                       DateTime.now().millisecondsSinceEpoch),
            //                   wordId: int.parse(wordId!),
            //                   groupId: int.parse(groupId!),
            //                 ),
            //                 state);
            //           } else {
            //             return _navGoUp(const ErrorNavScreen(), state);
            //           }
            //         },
            //       ),
            //       GoRoute(
            //         path: 'interactively',
            //         name: AppRoute.interactive.name,
            //         pageBuilder: (context, state) {
            //           final wordId = state.pathParameters['wordId'];
            //           if (wordId != null && int.tryParse(wordId) != null) {
            //             return _navGoUp(
            //                 PracticeInteractiveScreen(
            //                   key: ValueKey(
            //                       DateTime.now().millisecondsSinceEpoch),
            //                   wordId: int.parse(wordId),
            //                 ),
            //                 state);
            //           } else {
            //             return _navGoUp(const ErrorNavScreen(), state);
            //           }
            //         },
            //       ),
            //       GoRoute(
            //         path: 'audio',
            //         name: AppRoute.audioClip.name,
            //         pageBuilder: (context, state) {
            //           final words = state.extra as List<WordRecord>?;
            //           if (words != null) {
            //             final groupName = state.queryParameters['groupName'];
            //             return _navGoUp(
            //                 AudioScreen(
            //                   groupName: groupName!,
            //                   words: words,
            //                 ),
            //                 state);
            //           } else {
            //             return _navGoUp(const ErrorNavScreen(), state);
            //           }
            //         },
            //       )
            //     ],
            //   )
            // ]
            ),
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
