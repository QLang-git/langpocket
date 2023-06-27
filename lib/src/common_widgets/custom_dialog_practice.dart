import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:langpocket/src/utils/constants/messages.dart';

class CustomDialogPractice extends StatelessWidget {
  final PracticeWordMessages messages;
  final Function activateExamples;
  final Function reload;
  const CustomDialogPractice(
      {super.key,
      required this.messages,
      required this.activateExamples,
      required this.reload});

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            width: double.infinity,
            height: 380,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Job  ',
                      style: headline2Bold(primaryFontColor),
                    ),
                    Icon(
                      Icons.celebration_rounded,
                      size: headline2Bold(primaryFontColor).fontSize,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    messages.titleMessage,
                    softWrap: true,
                    style: headline3(primaryFontColor),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 5),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[400],
                    ),
                    onPressed: () {
                      activateExamples();
                      context.pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            messages.withSentences,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Icon(Icons.near_me, color: Colors.white)
                        ],
                      ),
                    )),
                const SizedBox(height: 15),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[700],
                    ),
                    onPressed: () {
                      reload();
                      context.pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            messages.tryAgain,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Icon(
                            Icons.refresh,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )),
                const SizedBox(height: 15),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400]),
                    onPressed: () {
                      context.pop();
                      context.pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Exit ',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.exit_to_app_rounded,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}
