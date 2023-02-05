import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/services/word_service.dart';

final groupsControllerProvider = StreamProvider<List<GroupData>>((ref) {
  final groups = ref.watch(wordsServicesProvider).watchGroups();
  return groups;
});
final featchWordsListbyIdProvider =
    FutureProvider.family<List<WordData>, int>((ref, groupId) async {
  final words =
      await ref.watch(wordsServicesProvider).fetchWordsByGroupId(groupId);

  return words;
});
final watchWordsListbyIdProvider =
    StreamProvider.family<List<WordData>, int>((ref, groupId) {
  final words = ref.watch(wordsServicesProvider).watchWordsGroupId(groupId);

  return words;
});

class DayLogo {
  final Color dayColor;
  final Icon dayIcon;
  final String dayName;

  DayLogo(this.dayColor, this.dayIcon, this.dayName);
}

DayLogo setDayLogo(DateTime dateTime) {
  final today = dateTime.weekday;
  switch (today) {
    case 1:
      return DayLogo(
          Colors.red[400]!,
          const Icon(
            Icons.coffee_rounded,
            color: Colors.white,
          ),
          'Mon');

    case 2:
      return DayLogo(
          Colors.brown[300]!,
          const Icon(
            Icons.sports_basketball_rounded,
            color: Colors.white,
          ),
          'Tue');
    case 3:
      return DayLogo(
          Colors.purple[400]!,
          const Icon(
            Icons.local_movies_rounded,
            color: Colors.white,
          ),
          'Web');
    case 4:
      return DayLogo(
          Colors.green[400]!,
          const Icon(
            Icons.music_note_rounded,
            color: Colors.white,
          ),
          'Thu');
    case 5:
      return DayLogo(
          Colors.blue[400]!,
          const Icon(
            Icons.sports_baseball_rounded,
            size: 30,
            color: Colors.white,
          ),
          'Fri');
    case 6:
      return DayLogo(
          Colors.indigo[400]!,
          const Icon(
            Icons.airplanemode_active_rounded,
            color: Colors.white,
          ),
          'Sat');
    case 7:
      return DayLogo(
          Colors.amber[600]!,
          const Icon(
            Icons.wb_sunny_rounded,
            color: Colors.white,
          ),
          'Sun');

    default:
      return DayLogo(
          Colors.red[400]!,
          const Icon(
            Icons.coffee_rounded,
            color: Colors.white,
          ),
          '-');
  }
}
