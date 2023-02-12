import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/home/widgets/groups_list/groups_list.dart';
import 'package:langpocket/src/screens/home/app_bar/presentation/home_appbar.dart';
import 'package:langpocket/src/screens/home/widgets/statistics/statistics.dart';
import 'package:langpocket/src/utils/constants/breakpoints.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: Scaffold(
        appBar: const HomeAppBar(),
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Column(
              children: [
                const Statistics(),
                const SizedBox(height: 15),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Groups',
                          style: GoogleFonts.robotoFlex(
                            color: primaryFontColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Todo',
                            style: buttonStyle(Colors.white),
                          ))
                    ],
                  ),
                ),
                const GroupsList()
              ],
            ),
          ),
        ),
        floatingActionButton: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: buttonColor,
            shape: const CircleBorder(),
          ),
          child: const Icon(
            Icons.add,
            size: 70,
            color: Colors.white,
          ),
          onPressed: () => context.goNamed(AppRoute.newWord.name),
        ),
      ),
    );
  }
}