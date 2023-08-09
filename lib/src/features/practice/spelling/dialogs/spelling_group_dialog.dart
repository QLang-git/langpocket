import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';

class SpellingGroupDialog extends StatelessWidget {
  final Function activateExamples;
  final Function? moveNext;
  final String word;
  const SpellingGroupDialog(
      {super.key,
      required this.word,
      required this.activateExamples,
      required this.moveNext});

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: FractionallySizedBox(
        heightFactor:
            moveNext == null ? 0.6 : 0.7, // take up 78% of screen height

        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Column(
            children: [
              // header of the dialog which contains the image and big title
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // the image of the dialog
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            'assets/images/notification.gif',
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ),

                      // the big header text
                      const Expanded(
                        child: Text(
                          'Good Job',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            height: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // the body of the dialog which contains the title and the body
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // the title or head of the body section
                          // if the title widget not passed we show our widget and take the header title
                          Text(
                            'You wrote " $word " 5 times correctly.\nKeep practicing  spelling several times for better results.',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),
                          const Divider(),
                          const SizedBox(height: 5),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[400]),
                              onPressed: () {
                                activateExamples();
                                context.pop();
                              },
                              child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          'Spell this word with sentences ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(color: Colors.white),
                                          maxLines: 2,
                                          softWrap: true,
                                        ),
                                      ),
                                      const Expanded(
                                          flex: 1,
                                          child: Icon(Icons.near_me,
                                              color: Colors.white))
                                    ],
                                  ))),

                          moveNext != null
                              ? SizedBox(height: moveNext != null ? 5 : 0)
                              : Container(),

                          moveNext != null
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[700],
                                  ),
                                  onPressed: () {
                                    moveNext!();
                                    context.pop();
                                  },
                                  child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              'Move to next one',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .copyWith(
                                                      color: Colors.white),
                                              maxLines: 2,
                                              softWrap: true,
                                            ),
                                          ),
                                          const Expanded(
                                              flex: 1,
                                              child: Icon(
                                                Icons.navigate_next,
                                                color: Colors.white,
                                              ))
                                        ],
                                      )),
                                )
                              : Container(),
                          const SizedBox(height: 5),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[400],
                            ),
                            onPressed: () {
                              context.pop();
                              context.pop();
                            },
                            child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        'Exit ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(color: Colors.white),
                                        maxLines: 2,
                                        softWrap: true,
                                      ),
                                    ),
                                    const Expanded(
                                        flex: 1,
                                        child: Icon(
                                          Icons.exit_to_app_rounded,
                                          color: Colors.white,
                                        ))
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//! complete example
class SpellingGroupExampleDialog extends StatelessWidget {
  final Function activateExamples;
  final Function reload;

  const SpellingGroupExampleDialog(
      {super.key, required this.activateExamples, required this.reload});

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: FractionallySizedBox(
        heightFactor: 0.65, // take up 65% of screen height

        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Column(
            children: [
              // header of the dialog which contains the image and big title
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // the image of the dialog
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            'assets/images/success.gif',
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ),

                      // the big header text
                      const Expanded(
                        child: Text(
                          'Good Job',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            height: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // the body of the dialog which contains the title and the body
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // the title or head of the body section
                          // if the title widget not passed we show our widget and take the header title
                          const Text(
                            'You\'ve completed your spelling practice for this group .\nKeep going...',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),
                          const Divider(),
                          const SizedBox(height: 5),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[400]),
                              onPressed: () {
                                activateExamples();
                                context.pop();
                              },
                              child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          'Spell this word with sentences',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(color: Colors.white),
                                          maxLines: 2,
                                          softWrap: true,
                                        ),
                                      ),
                                      const Expanded(
                                          flex: 1,
                                          child: Icon(Icons.near_me,
                                              color: Colors.white))
                                    ],
                                  ))),

                          const SizedBox(height: 5),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber[700],
                            ),
                            onPressed: () {
                              reload();
                              context.pop();
                            },
                            child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        'Start over',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(color: Colors.white),
                                        maxLines: 2,
                                        softWrap: true,
                                      ),
                                    ),
                                    const Expanded(
                                        flex: 1,
                                        child: Icon(
                                          Icons.refresh,
                                          color: Colors.white,
                                        ))
                                  ],
                                )),
                          ),
                          const SizedBox(height: 5),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[400],
                            ),
                            onPressed: () {
                              context.pop();
                              context.pop();
                            },
                            child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        'Exit ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(color: Colors.white),
                                        maxLines: 2,
                                        softWrap: true,
                                      ),
                                    ),
                                    const Expanded(
                                        flex: 1,
                                        child: Icon(
                                          Icons.exit_to_app_rounded,
                                          color: Colors.white,
                                        ))
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
