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

  return TodoController(service);
});

class TodoController extends StateNotifier<AsyncValue<List<TodoContents>>> {
  final WordServices wordServices;
  TodoController(this.wordServices) : super(const AsyncLoading()) {
    initialization();
  }

  void initialization() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      final groups = await wordServices.fetchAllGroups();
      final localTime = await getLocalTimeZone();
      final today = tz.TZDateTime.now(tz.getLocation(localTime));
      final myTodoList = prefs.getStringList('todoIds') ?? [];
      final myGroups = groups.where((group) {
        _updateForNewDay(prefs, today.day);
        final studyDate = group.creatingTime.whenToStudy(today);
        return studyDate != null;
      }).map((group) {
        final studyDate = group.creatingTime.whenToStudy(today)!;

        if (studyDate.compareDayMonthYearTo(today)) {
          return TodoContents(
              activeTodos: myTodoList.length,
              groupData: group,
              studyDate: studyDate,
              isToday: true,
              isChecked: !myTodoList.contains(group.id.toString()));
        } else {
          return TodoContents(
              activeTodos: myTodoList.length,
              groupData: group,
              studyDate: studyDate,
              isToday: false,
              isChecked: false);
        }
      }).toList();
      return [
        TodoContents(
            activeTodos: myTodoList.length,
            studyDate: today,
            isToday: true,
            isChecked: !myTodoList.contains('x')),
        ...myGroups
      ];
    });
  }

  void checkController(String todoIds) async {
    final prefs = await SharedPreferences.getInstance();
    var myTodoList = prefs.getStringList('todoIds') ?? [];

    if (myTodoList.contains(todoIds)) {
      myTodoList = myTodoList.where((t) => t != todoIds).toList();
      prefs.setStringList('todoIds', myTodoList);
      state = AsyncData(updateTodoList(todoIds, true, myTodoList));
    } else {
      prefs.setStringList('todoIds', [...myTodoList, todoIds]);
      state =
          AsyncData(updateTodoList(todoIds, false, [...myTodoList, todoIds]));
    }
  }

  List<TodoContents> updateTodoList(
      String id, bool isChecked, List<String> myNewTodoList) {
    return state.value!.map((e) {
      if (e.groupData == null && id == 'x' ||
          e.groupData?.id.toString() == id) {
        return e.copyWith(
            isChecked: isChecked, activeTodos: myNewTodoList.length);
      } else {
        return e;
      }
    }).toList();
  }

  Future<int> getCurrentTodoNumbers() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('todoIds')?.length ?? 0;
  }

  void _updateForNewDay(SharedPreferences prefs, int dayNumber) async {
    final day = prefs.getString('today');
    if (day != dayNumber.toString() || day == null) {
      prefs.getStringList('todoIds')?.map((id) async {
        if (id != 'x') {
          await wordServices.updateGroupLevel(int.parse(id), 1);
        }
      }).toList();

      prefs.setStringList('todoIds', ['x']); // x => is the daily task
      prefs.setString('today', dayNumber.toString());
    }
  }
}

class TodoContents {
  final GroupData? groupData;
  final DateTime studyDate;
  final bool isToday;
  final bool isChecked;
  final int activeTodos;

  TodoContents(
      {this.groupData,
      required this.studyDate,
      required this.isToday,
      required this.isChecked,
      required this.activeTodos});

  TodoContents copyWith(
      {GroupData? groupData,
      DateTime? studyDate,
      bool? isToday,
      bool? isChecked,
      int? activeTodos}) {
    return TodoContents(
      activeTodos: activeTodos ?? this.activeTodos,
      groupData: groupData ?? this.groupData,
      studyDate: studyDate ?? this.studyDate,
      isToday: isToday ?? this.isToday,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
