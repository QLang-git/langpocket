import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:langpocket/src/features/word_edit/screen/edit_mode_word_screen.dart';

class EditWordImage extends StatefulWidget {
  final List<Uint8List> currentImages;
  const EditWordImage({
    Key? key,
    required this.currentImages,
  }) : super(key: key);

  @override
  State<EditWordImage> createState() => _EditWordImageState();
}

class _EditWordImageState extends State<EditWordImage> {
  late List<Uint8List> images;
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
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.memory(images[index], fit: BoxFit.cover),
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
              style: ElevatedButton.styleFrom(
                  disabledBackgroundColor:
                      Theme.of(context).colorScheme.onBackground,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor: images.length < 5
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onBackground,
                  textStyle: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.white)),
              onPressed: images.length < 5
                  ? () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (image == null) return;
                      final bytes = await image.readAsBytes();

                      setState(() {
                        images.add(bytes);
                      });
                      states.updateWordImages(images);
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Add descriptive image',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
