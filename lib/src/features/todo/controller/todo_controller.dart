import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:langpocket/src/common_controller/helper_functions.dart';
import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/modules/extensions.dart';
import 'package:langpocket/src/data/services/word_service.dart';

final todoControllerProvider = StateNotifierProvider.autoDispose<TodoController,
    AsyncValue<List<TodoContents>>>((ref) {
  final service = ref.watch(wordsServicesProvider);

  return TodoController(service, ref);
});

class TodoController extends StateNotifier<AsyncValue<List<TodoContents>>> {
  final WordServices wordServices;
  final Ref ref;
  TodoController(this.wordServices, this.ref) : super(const AsyncLoading()) {
    initialization();
  }

  void initialization() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      var groups = await wordServices.fetchAllGroups();
      final localTime = await getLocalTimeZone();
      final today = tz.TZDateTime.now(tz.getLocation(localTime))
          .add(const Duration(days: 5));
      groups = await _updateForNewDay(prefs, today.weekday, groups, today);

      final myGroups = _getGroupsToStudy(groups, today, prefs);

      return [
        TodoContents(
            isLate: false, isToday: true, isChecked: _isChecked('x', prefs)),
        ...myGroups
      ];
    });
  }

  bool _isChecked(String id, SharedPreferences prefs) {
    return prefs.getStringList('todoIds') != null &&
        prefs.getStringList('todoIds')!.contains(id) &&
        prefs.getString('today') != null;
  }

  List<TodoContents> _getGroupsToStudy(
      List<GroupData> groups, tz.TZDateTime today, SharedPreferences prefs) {
    int todayCount = 1;
    final sortedGroups = groups.map((group) {
      var isToday = group.studyTime.compareDayMonthYearTo(today);
      var isLate = group.studyTime.isBefore(today);
      if (isToday || isLate) {
        todayCount += 1;
      }
      return TodoContents(
          isLate: isLate,
          groupData: group,
          isToday: isToday && isLate,
          isChecked:
              (isToday || isLate) && _isChecked(group.id.toString(), prefs));
    }).toList();
    if (prefs.getStringList('todoIds')?.isEmpty ?? false) {
      prefs.setInt('todoCount', todayCount);
    }
    return sortedGroups;
  }

  Future<void> checkController(String todoIds) async {
    final prefs = await SharedPreferences.getInstance();
    var myTodoList = prefs.getStringList('todoIds') ?? [];
    var currentTodo = prefs.getInt('todoCount');

    if (myTodoList.contains(todoIds)) {
      myTodoList = myTodoList.where((t) => t != todoIds).toList();
      prefs.setStringList('todoIds', myTodoList);
      if (currentTodo != null) {
        prefs.setInt('todoCount', currentTodo + 1);
      }

      state = AsyncData(updateTodoList(todoIds, false));
    } else {
      myTodoList = [...myTodoList, todoIds];
      if (currentTodo != null) {
        prefs.setInt('todoCount', currentTodo - 1);
      }

      prefs.setStringList('todoIds', myTodoList);
      state = AsyncData(updateTodoList(todoIds, true));
    }
  }

  List<TodoContents> updateTodoList(String id, bool isChecked) {
    return state.value!.map((e) {
      if (e.groupData == null && id == 'x' ||
          e.groupData?.id.toString() == id) {
        return e.copyWith(isChecked: isChecked);
      } else {
        return e;
      }
    }).toList();
  }

  Future<int> getCurrentTodoNumbers() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('todoIds')?.length ?? 0;
  }

  Future<List<GroupData>> _updateForNewDay(SharedPreferences prefs,
      int dayNumber, List<GroupData> groups, DateTime today) async {
    final checkedList = prefs.getStringList('todoIds') ?? [];
    final updatedGroups = await Future.wait(groups.map((group) async {
      if (checkedList.contains(group.id.toString())) {
        final newTime = whenToStudy(group.level, today);
        final newData = GroupCompanion(
            level: Value(group.level + 1), studyTime: Value(newTime));
        await wordServices.updateGroupLevel(group.id, newData);
        return group.copyWith(
            level: group.level + 1,
            studyTime: newTime); // Assuming you have a copyWith method
      }
      return group;
    }));

    prefs.setStringList('todoIds', []); // x => is the daily task
    prefs.setString('today', dayNumber.toString());

    return updatedGroups;
  }
}

DateTime whenToStudy(int level, DateTime studyTime) {
  if (level == 0) {
    return studyTime;
  }
  if (level == 1) {
    return studyTime.add(const Duration(days: 1));
  }
  if (level == 2) {
    return studyTime.add(const Duration(days: 3));
  }
  if (level == 3) {
    return studyTime.add(const Duration(days: 7));
  }
  if (level == 4) {
    return studyTime.add(const Duration(days: 14));
  }
  if (level == 5) {
    return studyTime.add(const Duration(days: 30));
  }
  if (level == 6) {
    return studyTime.add(const Duration(days: 90));
  }
  if (level == 7) {
    return studyTime.add(const Duration(days: 180));
  }

  return studyTime.add(const Duration(days: 360));
}

class TodoContents {
  final bool isLate;
  final GroupData? groupData;
  final bool isToday;
  final bool isChecked;

  TodoContents({
    this.groupData,
    required this.isLate,
    required this.isToday,
    required this.isChecked,
  });

  TodoContents copyWith(
      {GroupData? groupData,
      DateTime? studyDate,
      bool? isToday,
      bool? isLate,
      bool? isChecked,
      int? activeTodos}) {
    return TodoContents(
      isLate: isLate ?? this.isLate,
      groupData: groupData ?? this.groupData,
      isToday: isToday ?? this.isToday,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
