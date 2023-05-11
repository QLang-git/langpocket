import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class CustomPracticeDialog extends StatelessWidget {
  final Word wordData;
  final String groupId;

  final String name;
  final String date;
  final double padding;
  final double avatarRadius;
  const CustomPracticeDialog(
      {super.key,
      required this.padding,
      required this.avatarRadius,
      required this.name,
      required this.date,
      required this.groupId,
      required this.wordData});

  @override
  Widget build(BuildContext context) {
    final colorStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    return ResponsiveCenter(
      child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(padding),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    left: padding,
                    top: avatarRadius + padding,
                    right: padding,
                    bottom: padding),
                margin: EdgeInsets.only(top: avatarRadius),
                width: double.infinity,
                height: 270,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(padding),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorStyle.onPrimary),
                        onPressed: () {
                          context.pushNamed(AppRoute.spelling.name,
                              extra: wordData,
                              pathParameters: {'id': wordData.id.toString()});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Practice Spelling',
                                style: textStyle.labelMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                              const Icon(Icons.spellcheck_rounded)
                            ],
                          ),
                        )),
                    const Divider(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorStyle.onPrimary),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Practice Pronounciation',
                                style: textStyle.labelMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                              const Icon(Icons.speaker)
                            ],
                          ),
                        )),
                    const Divider(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorStyle.onPrimary),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Practice Listening',
                                style: textStyle.labelMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                              const Icon(Icons.audiotrack)
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              Positioned(
                  top: -17,
                  child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.asset(
                      'images/books_stack.png',
                      fit: BoxFit.fill,
                    ),
                  ))
            ],
          )),
    );
  }
}
