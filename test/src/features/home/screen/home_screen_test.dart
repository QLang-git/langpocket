import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/features/home/widgets/groups_list.dart';

import 'home_robot.dart';

void main() {
  group('existing', () {
    testWidgets('home screen has all necessary widgets ', (tester) async {
      final r = HomeRobot(tester);
      await tester.runAsync(() async {
        await r.pumpHomeScreen();

        r.hasGroupTitle();
        r.hasIconNewWord();
        r.hasTodoButton();
      });
    });
    testWidgets('home screen render all widgets inside ', (tester) async {
      final r = HomeRobot(tester);
      await tester.runAsync(() async {
        await r.pumpHomeScreen();
        final groupList = find.byType(GroupsList);
        expect(groupList, findsOneWidget);
      });
    });
  });
  group('Actions', () {
    testWidgets('navigate to add new word screen', (tester) async {
      final r = HomeRobot(tester);
      await tester.runAsync(() async {
        await r.pumpHomeScreen();
        await r.navToAddNewWord();
      });
    });
  });
}
