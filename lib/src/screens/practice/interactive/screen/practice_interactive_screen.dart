import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/practice/interactive/app_bar/practice_interactive_appbar.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/practice_stepper/practice_stepper.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/steps/listen_and_repeat/listen_repeat.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/steps/listen_and_write/listen_and_write.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/steps/read_and_speak/read_and_speak.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class PracticeInteractiveScreen extends StatefulWidget {
  final WordRecord wordRecord;
  const PracticeInteractiveScreen({
    super.key,
    required this.wordRecord,
  });

  @override
  State<PracticeInteractiveScreen> createState() => _PracticePronScreenState();
}

class _PracticePronScreenState extends State<PracticeInteractiveScreen> {
  late List<Widget> steps;

  @override
  void initState() {
    steps = [
      ListenRepeat(wordRecord: widget.wordRecord),
      ReadSpeak(wordRecord: widget.wordRecord),
      ListenWrite(wordRecord: widget.wordRecord)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: Scaffold(
        appBar: const PracticeInteractiveAppBar(),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: PracticeStepper(steps: steps),
        )),
      ),
    );
  }
}
