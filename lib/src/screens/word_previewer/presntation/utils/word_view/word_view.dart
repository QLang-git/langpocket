import 'package:flutter/material.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:text_to_speech/text_to_speech.dart';

class WordView extends StatefulWidget {
  final String foreignWord;
  final List<String> means;
  const WordView({super.key, required this.foreignWord, required this.means});

  @override
  State<WordView> createState() => _WordViewState();
}

class _WordViewState extends State<WordView> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    TextToSpeech tts = TextToSpeech();
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Icon(
                      Icons.volume_up_outlined,
                      color: primaryColor,
                    ),
                  ),
                  onPressed: () {
                    tts.speak(widget.foreignWord);
                  },
                ),
                Text(
                  widget.foreignWord,
                  style: headline2Bold(primaryFontColor),
                ),
              ],
            ),
            trailing: TextButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Icon(
                  !_showContent
                      ? Icons.arrow_drop_down_circle_outlined
                      : Icons.arrow_drop_up_outlined,
                  color: primaryColor,
                ),
              ),
              onPressed: () {
                setState(() {
                  _showContent = !_showContent;
                });
              },
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
                                style: headline3(primaryFontColor));
                          }
                          return Text('${widget.means[index]} , ',
                              style: headline3(primaryFontColor));
                        }
                        return Container();
                      }))
              : Container()
        ],
      ),
    );
  }
}
