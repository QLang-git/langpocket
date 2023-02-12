import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:langpocket/src/screens/word_edit/screen/edit_mode_word_screen.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

class EditWordImage extends StatefulWidget {
  final List<String> currentImages;
  const EditWordImage({
    Key? key,
    required this.currentImages,
  }) : super(key: key);

  @override
  State<EditWordImage> createState() => _EditWordImageState();
}

class _EditWordImageState extends State<EditWordImage> {
  late List<String> images;
  @override
  void initState() {
    images = [...widget.currentImages];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final states = context.findAncestorStateOfType<EditModeWordScreenState>()!;

    return Column(
      children: [
        if (images.isNotEmpty)
          SizedBox(
            width: double.infinity,
            height: 170,
            child: ListView.builder(
                itemCount: images.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 140,
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.memory(base64Decode(images[index]),
                            fit: BoxFit.cover),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              images.removeAt(index);
                            });
                            states.updateWordImages(images);
                          },
                          icon: const Icon(
                            Icons.close_outlined,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        const SizedBox(
          height: 15,
        ),
        Consumer(
          builder: (context, ref, child) {
            return ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: images.length < 5
                      ? MaterialStateProperty.all<Color>(buttonColor)
                      : null,
                  textStyle: MaterialStateProperty.all<TextStyle>(
                      buttonStyle(primaryFontColor))),
              onPressed: images.length < 5
                  ? () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (image == null) return;
                      final bytes = await image.readAsBytes();
                      final base64 = base64Encode(bytes);
                      setState(() {
                        images.add(base64);
                      });
                      states.updateWordImages(images);
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.add_a_photo_outlined),
                  ),
                  Text('Add descriptive image'),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
