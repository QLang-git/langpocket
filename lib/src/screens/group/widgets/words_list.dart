import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/async_value_widget.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/screens/home/widgets/groups_list/controller/groups_controller.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:text_to_speech/text_to_speech.dart';

class WordsGroups extends ConsumerStatefulWidget {
  final int groupId;
  const WordsGroups({super.key, required this.groupId});

  @override
  ConsumerState<WordsGroups> createState() => _WordsGroupsState();
}

class _WordsGroupsState extends ConsumerState<WordsGroups> {
  @override
  Widget build(BuildContext context) {
    final wordsList = ref.watch(watchWordsListbyIdProvider(widget.groupId));
    final tts = TextToSpeech();
    return AsyncValueWidget(
        value: wordsList,
        data: (words) {
          if (words.isEmpty) {
            return const Center(child: Text('No Word saved in This Group'));
          }
          return Column(
              children: words.map((word) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                shape: const RoundedRectangleBorder(),
                child: InkWell(
                  onTap: () => context.pushNamed(AppRoute.wordView.name,
                      extra: WordDataToView(
                          foreignWord: word.foreignWord,
                          wordMeans: word.meansList(),
                          wordImages: word.imagesList(),
                          wordExamples: word.examplesList(),
                          wordNote: word.wordNote)),
                  child: SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _WordInfo(word: word),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                              onPressed: () {
                                tts.speak(word.foreignWord);
                              },
                              icon: Icon(
                                Icons.volume_up_outlined,
                                color: primaryColor,
                                size: 25,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList());
        });
  }
}

class _WordInfo extends StatelessWidget {
  final WordData word;
  const _WordInfo({required this.word});

  @override
  Widget build(BuildContext context) {
    final getRandomExample = Random().nextInt(word.examplesList().length);
    return Row(
      children: [
        SizedBox(
          height: double.infinity,
          width: 90,
          child: word.wordImages.isNotEmpty
              ? Image.memory(
                  base64Decode(word.imagesList().first),
                  fit: BoxFit.fill,
                )
              : Container(
                  color: Colors.grey[400],
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 50,
                      color: primaryFontColor,
                    ),
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                word.foreignWord,
                style: headline3Bold(primaryFontColor),
              ),
              Row(
                children: [
                  Text('Means: ', style: bodyLarge(primaryFontColor)),
                  Text(
                    word.meansList().join(','),
                    overflow: TextOverflow.ellipsis,
                    style: bodyLargeBold(secondaryColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Example: ', style: bodyLarge(primaryFontColor)),
                  Text(
                    word.examplesList()[getRandomExample],
                    overflow: TextOverflow.ellipsis,
                    style: bodyLargeBold(secondaryColor),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
