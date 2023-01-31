import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/screens/home/presntation/utils/groups/groups_list.dart';
import 'package:langpocket/src/screens/home/utils/home_app_bar/presentation/home_appbar.dart';
import 'package:langpocket/src/screens/home/presntation/utils/statistics/statistics.dart';
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Column(
              children: const [Statistics(), GroupsList()],
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
