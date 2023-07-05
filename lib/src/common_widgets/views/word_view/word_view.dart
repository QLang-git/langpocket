import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';

class WordView extends StatefulWidget {
  final String foreignWord;
  final List<String> means;
  final bool noVoiceIcon;
  const WordView(
      {super.key,
      required this.foreignWord,
      required this.means,
      this.noVoiceIcon = false});

  @override
  State<WordView> createState() => _WordViewState();
}

class _WordViewState extends State<WordView> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    final colorFount = Theme.of(context).colorScheme.outline;
    final textStyle = Theme.of(context).textTheme;
    TextToSpeech tts = TextToSpeech();
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        children: [
          ListTile(
            title: InkWell(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => setState(() {
                _showContent = !_showContent;
              }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Icon(
                        !_showContent
                            ? Icons.arrow_drop_down_circle_outlined
                            : Icons.arrow_drop_up_outlined,
                        color: colorFount,
                        size: 30,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _showContent = !_showContent;
                      });
                    },
                  ),
                  Text(
                    widget.foreignWord,
                    style: textStyle.headlineLarge?.copyWith(color: colorFount),
                    textAlign: TextAlign.right,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                  TextButton(
                    onPressed: !widget.noVoiceIcon
                        ? () {
                            tts.speak(widget.foreignWord);
                          }
                        : null,
                    child: !widget.noVoiceIcon
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Icon(
                              Icons.volume_up_outlined,
                              color: colorFount,
                              size: 30,
                            ),
                          )
                        : Container(),
                  )
                ],
              ),
            ),
          ),
          _showContent
              ? Container(
                  height: 60,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: ListView.builder(
                      itemCount: widget.means.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if (widget.means[index].isNotEmpty) {
                          if (widget.means[index] == widget.means.last ||
                              widget.means[index + 1] == '') {
                            return Text('${widget.means[index]} ',
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                style: textStyle.displayMedium
                                    ?.copyWith(color: colorFount));
                          }
                          return Text('${widget.means[index]} , ',
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: textStyle.displayMedium
                                  ?.copyWith(color: colorFount));
                        }
                        return Container();
                      }))
              : Container()
        ],
      ),
    );
  }
}
