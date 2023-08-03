import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/features/home/controller/home_controller.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);

    return ThemeData(
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white, // specify your color here
        ),
      ),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.white),
      inputDecorationTheme: InputDecorationTheme(
          focusColor: Colors.white,
          //cursorColor: Colors.white,

          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white70,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          hintStyle: textTheme.bodySmall?.copyWith(color: Colors.white70),
          labelStyle: textTheme.bodySmall?.copyWith(color: Colors.white70),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          )),
      scaffoldBackgroundColor: colorScheme.background,
      iconTheme: const IconThemeData(color: Colors.white, size: 37),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(38),
                bottomRight: Radius.circular(38))),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 75,
      ),
    );

    //     foregroundColor: Colors.white,
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final HomeController(:searchControllerProvider) = HomeController();

    return Consumer(
      builder: (context, ref, child) {
        final words = ref.watch(searchControllerProvider);
        return ResponsiveCenter(
          child: AsyncValueWidget(
              value: words,
              child: (wordList) {
                final res = wordList
                    .where((w) => w.foreignWord
                        .toLowerCase()
                        .startsWith(query.toLowerCase()))
                    .toList();

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _SearchResult(
                    words: res,
                  ),
                );
              }),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final HomeController(:searchControllerProvider) = HomeController();

    return Consumer(
      builder: (context, ref, child) {
        final words = ref.watch(searchControllerProvider);

        return AsyncValueWidget(
            value: words,
            child: (wordList) {
              final res = wordList
                  .where((w) => w.foreignWord
                      .toLowerCase()
                      .startsWith(query.toLowerCase()))
                  .toList();

              return ListView.builder(
                  itemCount: res.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('- ${res[index].foreignWord}'),
                          const Divider()
                        ],
                      ),
                      onTap: () {
                        context.pushNamed(AppRoute.word.name, pathParameters: {
                          "groupId": res[index].group.toString(),
                          'wordId': res[index].id.toString()
                        });
                      },
                    );
                  });
            });
      },
    );
  }
}

class _SearchResult extends StatelessWidget {
  final List<WordData> words;
  const _SearchResult({required this.words});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: words.length,
      itemBuilder: (context, index) {
        final word = words[index];
        final imgs = word.decoding().wordImages;
        final randomExample = Random().nextInt(word.examplesList().length);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 15),
          elevation: 7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              context.pushNamed(AppRoute.word.name, pathParameters: {
                "groupId": word.group.toString(),
                'wordId': word.id.toString()
              });
            },
            child: Container(
              color: Colors.white,
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: imgs.isNotEmpty
                        ? Image.memory(
                            imgs.first,
                            fit: BoxFit.fill,
                          )
                        : Container(
                            decoration:
                                BoxDecoration(color: Colors.indigo[500]),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Center(
                                child: Text(word.meansList().first,
                                    overflow: TextOverflow.fade,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.rubik(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13,
                                        letterSpacing: 1.5,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            word.foreignWord,
                            style: GoogleFonts.rubik(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 0.15,
                              color: const Color(0xFF040E32),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 13),
                          Row(
                            children: [
                              Text('Means: ',
                                  style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    letterSpacing: 0.5,
                                  )),
                              Expanded(
                                // And this
                                child: Text(
                                  word.meansList().join(','),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    letterSpacing: 0.5,
                                    color: const Color(0xFF040E32),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 9),
                          Row(
                            children: [
                              Text('Example: ',
                                  style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    letterSpacing: 0.5,
                                  )),
                              Expanded(
                                // And this
                                child: Text(
                                  word.examplesList()[randomExample],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    letterSpacing: 0.5,
                                    color: const Color(0xFF040E32),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
