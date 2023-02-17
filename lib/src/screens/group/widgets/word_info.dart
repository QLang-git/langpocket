import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class WordInfo extends StatelessWidget {
  final WordData word;
  const WordInfo({super.key, required this.word});

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
