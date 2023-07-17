import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/data_flow/data_flow.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';

class HomeController {
  final WidgetRef ref;
  late DataFlow dataFlow;

  HomeController({required this.ref});

  void initial() {
    dataFlow = DataFlow(ref: ref);
  }

  AsyncValue<List<GroupData>> getAllGroups() => dataFlow.watchAllGroups();
  AsyncValue<List<WordData>> getWordsInGroupById(int currentGroupId) {
    return dataFlow.watchWordsListbyId(currentGroupId);
  }

  DayLogo getLogoDay(GroupData groupData) {
    return _setLogoDay(groupData.creatingTime.weekday);
  }

  String formatTime(GroupData groupData) {
    final DateTime(:day, :month, :year) = groupData.creatingTime;
    return 'Date: $day/$month/$year';
  }

  DayLogo _setLogoDay(int dayNumber) {
    switch (dayNumber) {
      case 1:
        return DayLogo(Colors.red[400]!, Icons.coffee_rounded, 'Mon');

      case 2:
        return DayLogo(
            Colors.brown[300]!, Icons.sports_basketball_rounded, 'Tue');
      case 3:
        return DayLogo(Colors.purple[400]!, Icons.local_movies_rounded, 'Web');
      case 4:
        return DayLogo(Colors.green[400]!, Icons.music_note_rounded, 'Thu');
      case 5:
        return DayLogo(Colors.blue[400]!, Icons.sports_baseball_rounded, 'Fri');
      case 6:
        return DayLogo(
            Colors.indigo[400]!, Icons.airplanemode_active_rounded, 'Sat');
      case 7:
        return DayLogo(Colors.amber[600]!, Icons.wb_sunny_rounded, 'Sun');

      default:
        return DayLogo(Colors.red[400]!, Icons.coffee_rounded, '-');
    }
  }
}

class DayLogo {
  final Color dayColor;
  final IconData dayIcon;
  final String dayName;

  DayLogo(this.dayColor, this.dayIcon, this.dayName);

  @override
  String toString() =>
      'DayLogo(dayColor: $dayColor, dayIcon: $dayIcon, dayName: $dayName)';
}
