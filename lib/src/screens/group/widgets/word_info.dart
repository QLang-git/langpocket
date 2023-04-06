import 'dart:math';

import 'package:flutter/material.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class WordInfo extends StatelessWidget {
  final Word word;
  const WordInfo({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    final getRandomExample = Random().nextInt(word.wordExamples.length);
    return Row(
      children: [
        SizedBox(
          height: double.infinity,
          width: 90,
          child: word.wordImages.isNotEmpty
              ? Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Image.memory(
                    word.wordImages.first,
                    fit: BoxFit.fill,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 50,
                      color: Colors.white,
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
                    word.wordMeans.join(','),
                    overflow: TextOverflow.ellipsis,
                    style: bodyLargeBold(secondaryColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Example: ', style: bodyLarge(primaryFontColor)),
                  Text(
                    word.wordExamples[getRandomExample],
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
