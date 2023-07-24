import 'package:flutter_test/flutter_test.dart';
import 'package:langpocket/src/features/new_word/controller/validation_input.dart';

void main() {
  late ValidationInput validationInput;
  setUp(() {
    validationInput = ValidationInput();
  });
  group('validate foreign word input', () {
    test('input empty', () {
      // setup
      final valid = validationInput.foreignWordValidation('');
      final valid2 = validationInput.foreignWordValidation('   ');
      // test
      expect(valid2.status, false);
      expect(valid2.message, 'The word field can\'t be empty.');

      expect(valid.status, false);
      expect(valid.message, 'The word field can\'t be empty.');
    });
    test('input more then one word', () {
      // setup
      final valid = validationInput.foreignWordValidation('jazz songs');
      // test
      expect(valid.status, false);
      expect(valid.message, 'Keep it one word in this field');
    });
    test('input too Long word', () {
      // setup
      final valid = validationInput
          .foreignWordValidation('jazzSongsKeepInMaidAndDoLikeIt');
      // test
      expect(valid.status, false);
      expect(valid.message, 'Word Too long');
    });
    test('input correct value', () {
      // setup
      final valid = validationInput.foreignWordValidation('jazz');
      // test
      expect(valid.status, true);
      expect(valid.message, '');
    });
  });

  group('validate wordMeanings', () {
    test('input empty', () {
      //setup
      final valid1 = validationInput.meaningWordsValidation([]);
      final valid2 = validationInput.meaningWordsValidation(['', '', ' ']);
      //testing
      expect(valid1.status, false);
      expect(valid1.message, 'This field can\'t be empty.');
      expect(valid2.status, false);
      expect(valid2.message, 'This field can\'t be empty.');
    });
    test('Too Long input', () {
      //setup
      final valid1 = validationInput.meaningWordsValidation([
        'keep the definition of the word smaller , keep the definition of the word smaller'
      ]);
      final valid2 = validationInput.meaningWordsValidation([
        'this',
        'keep the definition of the word smaller,keep the definition of the word smaller',
        ' '
      ]);
      //testing
      expect(valid1.status, false);
      expect(valid1.message, 'keep the definition of the word smaller');
      expect(valid2.status, false);
      expect(valid2.message, 'keep the definition of the word smaller');
    });
    test('correct input', () {
      //setup
      final valid1 = validationInput.meaningWordsValidation([
        'keep the definition of the word smaller',
        'keep the definition of the word smaller',
        'keep the definition of the word smaller'
      ]);
      final valid2 = validationInput.meaningWordsValidation(
          ['', 'keep the definition of the word smaller', '']);
      //testing
      expect(valid1.status, true);
      expect(valid1.message, '');
      expect(valid2.status, true);
      expect(valid2.message, '');
    });
    test('bug , save more then 3 meanings in DB', () {
      //setup
      final valid1 = validationInput.meaningWordsValidation([
        'keep the definition of the word',
        'keep the definition of the word',
        'keep the definition of the word',
        'keep the definition of the word',
      ]);
      //testing
      expect(valid1.status, false);
      expect(valid1.message, 'Invalid text');
    });
  });

  group('validate Examples', () {
    test('input empty', () {
      //setup
      final valid1 = validationInput.exampleWordsValidation([]);
      final valid2 = validationInput.exampleWordsValidation(['', '', ' ', '']);
      //testing
      expect(valid1.status, false);
      expect(valid1.message, 'This field can\'t be empty.');
      expect(valid2.status, false);
      expect(valid2.message, 'This field can\'t be empty.');
    });
    test('Too Long input', () {
      //setup
      final valid1 = validationInput.exampleWordsValidation([
        'keep the definition of the word smaller , keep the definition of the word smaller'
      ]);
      final valid2 = validationInput.exampleWordsValidation([
        'this',
        'keep the definition of the word smaller,keep the definition of the word smaller',
        ' '
      ]);
      //testing
      expect(valid1.status, false);
      expect(valid1.message,
          'That\'s quite a lengthy sentence! Please try to make it shorter.');
      expect(valid2.status, false);
      expect(valid2.message,
          'That\'s quite a lengthy sentence! Please try to make it shorter.');
    });
    test('correct input', () {
      //setup
      final valid1 = validationInput.exampleWordsValidation([
        'keep the definition of the word',
        'keep the definition of the word',
        'keep the definition of the word',
        'keep the definition of the word',
        'keep the definition of the word',
      ]);
      final valid2 = validationInput.exampleWordsValidation(
          ['', 'keep the definition of the word smaller', '']);
      //testing
      expect(valid1.status, true);
      expect(valid1.message, '');
      expect(valid2.status, true);
      expect(valid2.message, '');
    });
    test('bug , save more then 5 examples in DB', () {
      //setup
      final valid1 = validationInput.exampleWordsValidation([
        'keep the definition of the word',
        'keep the definition of the word',
        'keep the definition of the word',
        'keep the definition of the word',
        'keep the definition of the word',
        'keep the definition of the word',
      ]);
      //testing
      expect(valid1.status, false);
      expect(valid1.message, 'Invalid text');
    });
  });
  group('validate notes', () {
    test('notes To long', () {
      // setup
      final valid = validationInput.notesWordsValidation(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam accumsan elementum dolor, ornare imperdiet leo commodo aliquam. Ut pellentesque turpis sem, et facilisis libero ultrices in. Nunc gravida, dolor vitae auctor vestibulum, massa arcu suscipit dolor, tristique consequat tellus ante euismod elit. Nulla ac facilisis augue. Aenean hendrerit dignissim neque ac euismod. Morbi vulputate egestas massa sed convallis. Ut non dignissim felis, at congue odio. Nulla ut nunc ut nunc porttitor egestas non efficitur ex. Sed non dapibus odio. Pellentesque semper dictum turpis non placerat. Quisque pulvinar nunc ut erat pellentesque, non euismod lorem bibendum. Aliquam sit amet condimentum tortor, et.');
      // test

      expect(valid.status, false);
      expect(valid.message, 'keep your notes short and concise ');
    });
    test('notes To long', () {
      // setup
      final valid = validationInput.notesWordsValidation(
          'Lorem Veniam nostrud cupidatat dolor magna aute culpa non ullamco mollit sint ex ea amet.');
      // test

      expect(valid.status, true);
      expect(valid.message, '');
    });
  });
}
