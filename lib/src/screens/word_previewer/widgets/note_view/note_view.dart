import 'package:flutter/material.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class NoteView extends StatefulWidget {
  final String note;
  const NoteView({super.key, required this.note});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return widget.note.isNotEmpty
        ? Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  title: Text('Note', style: headline3Bold(primaryFontColor)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: Row(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          widget.note,
                          maxLines: 15,
                          style: bodyLarge(primaryFontColor),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ]),
                )
              ],
            ),
          )
        : Container();
  }
}
