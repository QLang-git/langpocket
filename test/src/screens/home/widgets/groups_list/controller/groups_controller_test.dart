import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/screens/home/widgets/groups_list/controller/groups_controller.dart';

void main() {
  group('the logo of the day group', () {
    test('mon', () {
      final newDate = DateTime.now();

      DateTime mon = newDate.copyWith(day: -1);
      final logo = setDayLogo(mon);
      expect(logo.dayName, 'Mon');
      expect(logo.dayColor, Colors.red[400]);
      expect(logo.dayIcon, Icons.coffee_rounded);
    });
    test('Tue', () {
      final newDate = DateTime.now();

      DateTime tue = newDate.copyWith(day: 0);
      final logo = setDayLogo(tue);
      expect(logo.dayName, 'Tue');
      expect(logo.dayColor, Colors.brown[300]);
      expect(logo.dayIcon, Icons.sports_basketball_rounded);
    });
    test('Web', () {
      final newDate = DateTime.now();

      DateTime web = newDate.copyWith(day: 1);
      final logo = setDayLogo(web);
      expect(logo.dayName, 'Web');
      expect(logo.dayColor, Colors.purple[400]);
      expect(logo.dayIcon, Icons.local_movies_rounded);
    });
    test('Thu', () {
      final newDate = DateTime.now();

      DateTime thu = newDate.copyWith(day: 2);
      final logo = setDayLogo(thu);
      expect(logo.dayName, 'Thu');
      expect(logo.dayColor, Colors.green[400]);
      expect(logo.dayIcon, Icons.music_note_rounded);
    });
    test('Fri', () {
      final newDate = DateTime.now();

      DateTime fri = newDate.copyWith(day: 3);
      final logo = setDayLogo(fri);
      expect(logo.dayName, 'Fri');
      expect(logo.dayColor, Colors.blue[400]);
      expect(logo.dayIcon, Icons.sports_baseball_rounded);
    });
    test('Sat', () {
      final newDate = DateTime.now();

      DateTime sat = newDate.copyWith(day: 4);
      final logo = setDayLogo(sat);
      expect(logo.dayName, 'Sat');
      expect(logo.dayColor, Colors.indigo[400]);
      expect(logo.dayIcon, Icons.airplanemode_active_rounded);
    });
    test('Sun', () {
      final newDate = DateTime.now();

      DateTime sun = newDate.copyWith(day: 5);
      final logo = setDayLogo(sun);
      expect(logo.dayName, 'Sun');
      expect(logo.dayColor, Colors.amber[600]);
      expect(logo.dayIcon, Icons.wb_sunny_rounded);
    });
  });
}
