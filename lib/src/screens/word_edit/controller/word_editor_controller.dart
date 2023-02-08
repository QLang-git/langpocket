import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

// todo
class WordUpdatedNotifier extends StateNotifier<WordDataToView> {
  WordUpdatedNotifier()
      : super(WordDataToView(
            foreignWord: '',
            wordMeans: [],
            wordImages: [],
            wordExamples: [],
            wordNote: ''));
}
