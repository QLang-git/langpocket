import 'package:flutter/material.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';

//TODO:
class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: secondaryColor,
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: Center(
          child: Text(
            'Statistics coming soon',
            style: headline2Bold(backgroundColor),
          ),
        ),
      ),
    );
  }
}
