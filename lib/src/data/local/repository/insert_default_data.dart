import 'package:drift/drift.dart';
import 'package:langpocket/src/data/local/repository/images.dart';

import 'drift_group_repository.dart';

List<GroupCompanion> get defaultGroups {
  return [
    GroupCompanion.insert(
      level: const Value(0),
      studyTime: DateTime.parse('2023-08-10 13:27:00'),
      groupName: 'Level 0',
      creatingTime: DateTime.parse('2023-08-10 13:27:00'),
    ),
    GroupCompanion.insert(
      level: const Value(1),
      studyTime: DateTime.parse('2023-08-11 13:27:00'),
      groupName: 'Level 1',
      creatingTime: DateTime.parse('2023-08-09 13:27:00'),
    ),
    GroupCompanion.insert(
      level: const Value(2),
      studyTime: DateTime.parse('2023-08-13 13:27:00'),
      groupName: 'Le2 My second ',
      creatingTime: DateTime.parse('2023-08-08 13:27:00'),
    ),
    GroupCompanion.insert(
      level: const Value(3),
      studyTime: DateTime.parse('2023-08-17 13:27:00'),
      groupName: 'le3 Nice words for my third day',
      creatingTime: DateTime.parse('2023-08-03 13:27:00'),
    ),
    GroupCompanion.insert(
      level: const Value(4),
      studyTime: DateTime.parse('2023-08-24 13:27:00'),
      groupName: 'le4 gmd day',
      creatingTime: DateTime.parse('2023-07-27 13:27:00'),
    )
  ];
}

List<WordCompanion> get defaultWords {
  return [
    WordCompanion.insert(
        group: 1,
        foreignWord: 'accolade',
        wordMeans: 'an award-an expression of praise-الجوائز',
        wordImages: accoladeFakeData(),
        wordExamples:
            'There is no higher accolade at this school than an honorary degree.-She has been winning accolades or her performances in small plays.-The movie\'s special effects have drawn accolades from both fans and critics.',
        wordNote:
            'She has been winning accolades [=she has been receiving praise]',
        wordDate: DateTime.parse('2023-07-11 13:27:00')),
    WordCompanion.insert(
        group: 1,
        foreignWord: 'circumvent',
        wordMeans:
            'to avoid being stopped by (something, such as a law or rule)-to get around (something) in a clever and sometimes dishonest way-راوغ',
        wordImages: circumventFakeData(),
        wordExamples:
            'We circumvented the problem by using a different program-He found a way to circumvent the law-The circumvention of tax laws is illegal.',
        wordNote: 'verb and noun',
        wordDate: DateTime.parse('2023-07-11 14:27:00')),
    WordCompanion.insert(
        group: 1,
        foreignWord: 'praiseworthy',
        wordMeans: 'deserving praise-worthy of praise-جدير بالثناء',
        wordImages: praiseworthyFakeData(),
        wordExamples:
            'The boy has done praiseworthy work of planting trees on his birthday-praiseworthy efforts to develop an AIDS vaccine',
        wordNote: '',
        wordDate: DateTime.parse('2023-07-11 13:27:00')),
    WordCompanion.insert(
        group: 1,
        foreignWord: 'astound',
        wordMeans:
            'to cause a feeling of great surprise-wonder in (someone)-amaze,astonish-الذهول',
        wordImages: accoladeFakeData(),
        wordExamples:
            'What astounds me is that they never apologized-The magician will astound you with his latest tricks-It was an astounding performance',
        wordNote:
            'astound (verb)\nastounded (adjective)\nastounding (adjective)',
        wordDate: DateTime.parse('2023-07-11 15:30:00')),
    WordCompanion.insert(
        group: 2,
        foreignWord: 'pleasing',
        wordMeans:
            'good in a way that gives pleasure or enjoyment-Something which feels quite satisfying to hear or see-ارضاء',
        wordImages: praiseworthyFakeData(),
        wordExamples:
            'He wanted his kitchen to be both functional and aesthetically pleasing-There was  pleasing sounds-She had a very pleasing voice',
        wordNote: 'pleasing (adjective)\ncrowd–pleaser (noun)\nplease (verb)',
        wordDate: DateTime.parse('2023-07-10 15:30:00')),
    WordCompanion.insert(
        group: 2,
        foreignWord: 'Decency',
        wordMeans:
            'Behavior that conforms to accepted standards of morality-honest behavior and attitudes that show respect for other people',
        wordImages: '',
        wordExamples:
            'she had the decency to come and confess-Their behavior goes beyond the bounds of decency-Sending aid to the victims was simply a matter of common decency-Have you no sense of decency?',
        wordNote:
            'decencies [plural] formal : the behaviors that people in a society consider to be proper or acceptable\n  He had been taught to observe the ordinary decencies.',
        wordDate: DateTime.parse('2023-07-10 16:30:00')),
    WordCompanion.insert(
        group: 3,
        foreignWord: 'Optimist',
        wordMeans:
            'One who thinks positively and is hopeful-honest behavior and attitudes that show respect for other people',
        wordImages: '',
        wordExamples:
            'Try to be an optimist in life-Their behavior goes beyond the bounds of decency-You have to be a bit of an optimist to start a business-Somehow he remained an optimist despite all that had happened to him.',
        wordNote: 'plural optimists\n — opposite pessimist',
        wordDate: DateTime.parse('2023-07-09 16:31:00')),
  ];
}
