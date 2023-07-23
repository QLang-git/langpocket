import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/features/home/controller/home_controller.dart';

void main() {
  late HomeController homeController;
  setUp(() {
    homeController = HomeController();
  });
  group('HomeController', () {
    final group1 = GroupData(
        id: 1, groupName: 'Sun_Group', creatingTime: DateTime(2023, 07, 23));
    final group2 = GroupData(
        id: 2, groupName: 'Sat_Group', creatingTime: DateTime(2023, 07, 22));
    final group3 = GroupData(
        id: 3, groupName: 'Fri_Group', creatingTime: DateTime(2023, 07, 21));
    final group4 = GroupData(
        id: 4, groupName: 'Thu_Group', creatingTime: DateTime(2023, 07, 20));
    final group5 = GroupData(
        id: 5, groupName: 'Web_Group', creatingTime: DateTime(2023, 07, 19));
    final group6 = GroupData(
        id: 6, groupName: 'Tue_Group', creatingTime: DateTime(2023, 07, 18));
    final group7 = GroupData(
        id: 7, groupName: 'Mon_Group', creatingTime: DateTime(2023, 07, 17));

    test('formatTime should return formatted time', () {
      final res1 = homeController.formatTime(group1);
      final res2 = homeController.formatTime(group2);
      expect(res1, 'Date: 23/7/2023');
      expect(res2, 'Date: 20/7/2023');
    });
    test('_setLogoDay should return the correct DayLogo', () {
      //set up
      final sun = homeController.getLogoDay(group1);
      final sat = homeController.getLogoDay(group2);
      final fri = homeController.getLogoDay(group3);
      final thu = homeController.getLogoDay(group4);
      final web = homeController.getLogoDay(group5);
      final tue = homeController.getLogoDay(group6);
      final mon = homeController.getLogoDay(group7);
      //testing 1 mon
      expect(mon.dayColor, Colors.red[400]);
      expect(mon.dayIcon, Icons.coffee_rounded);
      expect(mon.dayName, 'Mon');
      // testing 2 tue
      expect(tue.dayColor, Colors.brown[300]);
      expect(tue.dayIcon, Icons.sports_basketball_rounded);
      expect(tue.dayName, 'Tue');
      // testing 3 web
      expect(web.dayColor, Colors.purple[400]);
      expect(web.dayIcon, Icons.local_movies_rounded);
      expect(web.dayName, 'Web');
      // testing 4 thu
      expect(thu.dayColor, Colors.green[400]);
      expect(thu.dayIcon, Icons.music_note_rounded);
      expect(thu.dayName, 'Thu');
      // testing 5 fri
      expect(fri.dayColor, Colors.blue[400]);
      expect(fri.dayIcon, Icons.sports_baseball_rounded);
      expect(fri.dayName, 'Fri');
      // testing 6 sat
      expect(sat.dayColor, Colors.indigo[400]);
      expect(sat.dayIcon, Icons.airplanemode_active_rounded);
      expect(sat.dayName, 'Sat');
      // testing 7 tue
      expect(sun.dayColor, Colors.amber[600]);
      expect(sun.dayIcon, Icons.wb_sunny_rounded);
      expect(sun.dayName, 'Sun');
    });
  });
}
