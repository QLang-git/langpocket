import 'dart:typed_data';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageView extends StatelessWidget {
  final List<Uint8List> imageList;
  final List<String> meanings;
  const ImageView({super.key, required this.imageList, required this.meanings});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 250,
        child: imageList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Swiper(
                  loop: false,
                  itemCount: imageList.length,
                  itemBuilder: (context, index) => Image.memory(
                    imageList[index],
                    fit: BoxFit.cover,
                  ),
                  viewportFraction: 0.8,
                  scale: 0.9,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  decoration: BoxDecoration(color: Colors.indigo[600]),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Center(
                      child: Text(meanings.first,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              letterSpacing: 1.5,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ));
  }
}
