import 'package:flutter_test/flutter_test.dart';

import 'home_robot.dart';

void main() {
  testWidgets('home screen has all necessary widgets ', (tester) async {
    final r = HomeRobot(tester);
    await r.pumpHomeScreen();
    r.hasGroupTitle();
    r.hasIconNewWord();
    r.hasTodoButton();
  });
  group('Actions', () {
    testWidgets('navigate to add new word screen', (tester) async {
      final r = HomeRobot(tester);
      await r.pumpHomeScreen();
      await r.navToAddNewWord();
    });
  });
}
