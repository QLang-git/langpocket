import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/local/repository/local_group_repository.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

class GroupRobot {
  final WidgetTester tester;
  GroupRobot(this.tester);
  Future<void> pumpHomeScreen([DriftGroupRepository? db]) async {
    tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    if (db != null) {
      await tester.pumpWidget(ProviderScope(
        overrides: [localGroupRepositoryProvider.overrideWithValue(db)],
        child: MaterialApp.router(
          routerConfig: GoRouter(initialLocation: '/group', routes: appScreens),
        ),
      ));
    } else {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
              routerConfig:
                  GoRouter(initialLocation: '/group', routes: appScreens)),
        ),
      );
    }
    await tester.pump();
  }
}
