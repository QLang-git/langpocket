import 'dart:typed_data';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final List<Uint8List> imageList;
  const ImageView({super.key, required this.imageList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 250,
        child: imageList.isNotEmpty
            ? Swiper(
                loop: false,
                itemCount: imageList.length,
                itemBuilder: (context, index) => Image.memory(
                  imageList[index],
                  fit: BoxFit.fill,
                ),
                viewportFraction: 0.8,
                scale: 0.9,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  color: Theme.of(context).colorScheme.onBackground,
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
              ));
  }
}
