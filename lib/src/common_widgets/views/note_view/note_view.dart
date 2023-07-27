import 'package:flutter/material.dart';

class NoteView extends StatefulWidget {
  final String note;
  const NoteView({super.key, required this.note});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    final colorFount = Theme.of(context).colorScheme.outline;
    final textStyle = Theme.of(context).textTheme;
    return widget.note.isNotEmpty
        ? Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                ListTile(
                  title: Text('Note',
                      style: textStyle.displayLarge?.copyWith(
                          color: colorFount,
                          decoration: TextDecoration.underline)),
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
                          style:
                              textStyle.bodyMedium?.copyWith(color: colorFount),
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
