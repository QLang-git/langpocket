import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';
import 'package:langpocket/src/features/home/widgets/groups_list.dart';
import 'package:langpocket/src/features/home/app_bar/home_appbar.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);
    return ResponsiveCenter(
      child: Scaffold(
        backgroundColor: colorScheme.background,
        appBar: HomeAppBar(
          screenHeight: sizeHeight,
          userName: 'User',
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Groups',
                          style: textTheme.headlineLarge
                              ?.copyWith(color: colorScheme.outline)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.onPrimary,
                          ),
                          onPressed: () => context.goNamed(AppRoute.todo.name),
                          child: Text(
                            'Todo',
                            style: textTheme.labelMedium
                                ?.copyWith(color: Colors.white),
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
            backgroundColor: colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
          ),
          child: const Icon(
            Icons.add,
            size: 55,
            color: Colors.white,
          ),
          onPressed: () => context.goNamed(AppRoute.newWord.name),
        ),
      ),
    );
  }
}
