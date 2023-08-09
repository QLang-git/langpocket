import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class CustomPracticeDialog extends StatelessWidget {
  final WordRecord wordData;
  final double padding;
  final double avatarRadius;
  final String groupId;
  const CustomPracticeDialog(
      {super.key,
      required this.groupId,
      required this.padding,
      required this.avatarRadius,
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
                          context.pushNamed(
                            AppRoute.spelling.name,
                            pathParameters: {
                              "groupId": groupId,
                              'wordId': wordData.id.toString(),
                            },
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Practice Spelling',
                            textAlign: TextAlign.center,
                            style: textStyle.labelMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        )),
                    const Divider(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorStyle.onPrimary),
                        onPressed: () {
                          context.pushNamed(
                            AppRoute.pronunciation.name,
                            pathParameters: {
                              "groupId": groupId,
                              'wordId': wordData.id.toString(),
                            },
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Practice Pronunciation',
                            textAlign: TextAlign.center,
                            style: textStyle.labelMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        )),
                    const Divider(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorStyle.onPrimary),
                        onPressed: () => context.pushNamed(
                                AppRoute.interactive.name,
                                pathParameters: {
                                  "groupId": groupId,
                                  'wordId': wordData.id.toString()
                                }),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Practice Interactively',
                            textAlign: TextAlign.center,
                            style: textStyle.labelMedium
                                ?.copyWith(color: Colors.white),
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
                      'assets/images/books_stack.png',
                      fit: BoxFit.fill,
                    ),
                  ))
            ],
          )),
    );
  }
}
