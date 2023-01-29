import 'package:flutter_riverpod/flutter_riverpod.dart';

final numberOfMeaningProvider = StateProvider<int>((ref) {
  return 1;
});
final numberOfExamplesProvider = StateProvider<int>((ref) {
  return 2;
});
