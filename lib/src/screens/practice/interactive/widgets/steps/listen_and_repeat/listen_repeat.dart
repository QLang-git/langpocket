import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/views/image_view/image_view.dart';
import 'package:langpocket/src/screens/practice/interactive/widgets/practice_stepper/step_message.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class ListenRepeat extends StatefulWidget {
  final WordRecord wordRecord;
  const ListenRepeat({super.key, required this.wordRecord});

  @override
  State<ListenRepeat> createState() => _ListenRepeatState();
}

class _ListenRepeatState extends State<ListenRepeat>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final ThemeData(:colorScheme) = Theme.of(context);
    final WordRecord(:wordImages) = widget.wordRecord;
    super.build(context);
    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(size: 40, color: colorScheme.primary),
      ),
      child: Column(
        children: [
          const StepMessage(message: 'Echo Mastery: Listen and Repeat'),
          const SizedBox(height: 50),
          ImageView(imageList: wordImages),
          const SizedBox(height: 80),
          Container(
            width: double.infinity,
            height: 60,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: colorScheme.onSecondary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.mic),
                Icon(Icons.play_arrow),
                Icon(Icons.repeat_outlined)
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
