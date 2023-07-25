import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;

import 'package:langpocket/src/data/local/repository/drift_group_repository.dart';
import 'package:langpocket/src/data/services/word_service.dart';
import 'package:langpocket/src/features/new_word/controller/validation_input.dart';
import 'package:langpocket/src/utils/routes/app_routes.dart';

final newWordControllerProvider = StateNotifierProvider.autoDispose<
        NewWordController, AsyncValue<WordRecord>>(
    (ref) => NewWordController(
          wordsServices: ref.watch(wordsServicesProvider),
        ),
    dependencies: [
      wordsServicesProvider,
    ]);

class NewWordController extends StateNotifier<AsyncValue<WordRecord>> {
  final WordServices wordsServices;

  NewWordController({
    required this.wordsServices,
  }) : super(AsyncData(WordRecord(
            foreignWord: '',
            wordMeans: List.filled(3, ''),
            wordImages: [],
            wordExamples: List.filled(5, ''),
            wordNote: '')));

  Future<void> saveNewWord(DateTime now) async {
    final WordRecord(
      :foreignWord,
      :wordExamples,
      :wordMeans,
      :wordImages,
      :wordNote,
    ) = state.value!;
    // validations

    _validateForeignWord(foreignWord);
    _validateMeans(wordMeans);
    _validateWordExamples(wordExamples);
    _validateWordImage(wordImages);
    _validateNote(wordNote);

    // get the group
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final groupId = await _checkTodayGroup(now, wordsServices);
      final newWordCompanion = WordCompanion.insert(
          group: groupId,
          foreignWord: foreignWord,
          wordMeans: wordMeans.join('-'),
          wordImages: wordImages.join('-'),
          wordExamples: wordExamples.join('-'),
          wordNote: wordNote,
          wordDate: now);
      await wordsServices.addNewWordInGroup(newWordCompanion);
      //! clear states and word's form if saved succeeded
      return WordRecord(
          foreignWord: '',
          wordMeans: List.filled(3, ''),
          wordImages: [],
          wordExamples: List.filled(5, ''),
          wordNote: '');
    });
  }

  void saveForeignWord(String foreignWord) {
    state = AsyncData(state.value!.copyWith(foreignWord: foreignWord));
  }

  void saveWordMeans(String mean, int index) {
    // Create a copy of the current mean list
    List<String> updatedMeans = List.from(state.value!.wordMeans);

    // Update the specific mean
    updatedMeans[index] = mean;

    // Update the state with the modified mean list
    state = AsyncData(state.value!.copyWith(wordMeans: updatedMeans));
  }

  void saveWordImage(Uint8List image) {
    // Create a copy of the current image list
    List<Uint8List> updatedImages = List.from(state.value!.wordImages);

    // Update the specific image
    updatedImages = [...updatedImages, image];

    // Update the state with the modified image list
    state = AsyncData(state.value!.copyWith(wordImages: updatedImages));
  }

  void removeImage(int index) {
    List<Uint8List> updatedImages = List.from(state.value!.wordImages);
    updatedImages.removeAt(index);
    state = AsyncData(state.value!.copyWith(wordImages: updatedImages));
  }

  void saveWordExample(String example, int index) {
    // Create a copy of the current examples list
    List<String> updatedExamples = List.from(state.value!.wordExamples);

    // Update the specific example
    updatedExamples[index] = example;
    // Update the state with the modified examples list
    state = AsyncData(state.value!.copyWith(wordExamples: updatedExamples));
  }

  void saveWordNote(String note) {
    state = AsyncData(state.value!.copyWith(wordNote: note));
  }

  Future<int> _checkTodayGroup(DateTime now, WordServices wordsServices) async {
    try {
      final todayGroup = await wordsServices.fetchGroupByTime(now);
      return todayGroup.id;
    } catch (e) {
      final newGroup = await wordsServices.createGroup(GroupCompanion.insert(
          groupName: 'Group ${now.day}/${now.month}', creatingTime: now));
      return newGroup.id;
    }
  }

  final validate = ValidationInput();

  void _validateForeignWord(String foreignWord) {
    final valid = validate.foreignWordValidation(foreignWord);
    if (!valid.status) {
      state = AsyncValue.error(valid.message, StackTrace.current);
      return;
    }
  }

  void _validateMeans(List<String> wordMeans) {
    final valid = validate.meaningWordsValidation(wordMeans);
    if (!valid.status) {
      state = AsyncValue.error(valid.message, StackTrace.current);
      return;
    }
  }

  void _validateWordExamples(List<String> wordExamples) {
    final valid = validate.exampleWordsValidation(wordExamples);
    if (!valid.status) {
      state = AsyncValue.error(valid.message, StackTrace.current);
      return;
    }
  }

  void _validateWordImage(List<Uint8List> wordImages) {
    // Check the number of images
    if (wordImages.length > 5) {
      state = AsyncValue.error(
          'You cannot upload more than 10 images.', StackTrace.current);
      return;
    }
    // Check image sizes and formats
    for (var image in wordImages) {
      // Check the image size
      if (image.lengthInBytes > 5000000) {
        // 5MB
        state = AsyncValue.error(
            'Images must be less than 5MB in size.', StackTrace.current);
        return;
      }
      // Decode the image to check dimensions and format
      final decodedImage = img.decodeImage(image);
      if (decodedImage == null) {
        state = AsyncValue.error('Invalid Image', StackTrace.current);
        return;
      }
      // Check the image dimensions
      if (decodedImage.width < 400 || decodedImage.height < 400) {
        state = AsyncValue.error(
            'Images must be at least 400x400 pixels.', StackTrace.current);
        return;
      }
    }
  }

  void _validateNote(String wordNote) {
    final valid = validate.notesWordsValidation(wordNote);
    if (!valid.status) {
      state = AsyncValue.error(valid.message, StackTrace.current);
      return;
    }
  }
}
