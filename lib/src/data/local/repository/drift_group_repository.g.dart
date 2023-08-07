// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_group_repository.dart';

// ignore_for_file: type=lint
class $GroupTable extends Group with TableInfo<$GroupTable, GroupData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _groupNameMeta =
      const VerificationMeta('groupName');
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
      'group_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _creatingTimeMeta =
      const VerificationMeta('creatingTime');
  @override
  late final GeneratedColumn<DateTime> creatingTime = GeneratedColumn<DateTime>(
      'creating_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, groupName, level, creatingTime];
  @override
  String get aliasedName => _alias ?? 'group';
  @override
  String get actualTableName => 'group';
  @override
  VerificationContext validateIntegrity(Insertable<GroupData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_name')) {
      context.handle(_groupNameMeta,
          groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta));
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    }
    if (data.containsKey('creating_time')) {
      context.handle(
          _creatingTimeMeta,
          creatingTime.isAcceptableOrUnknown(
              data['creating_time']!, _creatingTimeMeta));
    } else if (isInserting) {
      context.missing(_creatingTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      groupName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_name'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      creatingTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}creating_time'])!,
    );
  }

  @override
  $GroupTable createAlias(String alias) {
    return $GroupTable(attachedDatabase, alias);
  }
}

class GroupData extends DataClass implements Insertable<GroupData> {
  final int id;
  final String groupName;
  final int level;
  final DateTime creatingTime;
  const GroupData(
      {required this.id,
      required this.groupName,
      required this.level,
      required this.creatingTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group_name'] = Variable<String>(groupName);
    map['level'] = Variable<int>(level);
    map['creating_time'] = Variable<DateTime>(creatingTime);
    return map;
  }

  GroupCompanion toCompanion(bool nullToAbsent) {
    return GroupCompanion(
      id: Value(id),
      groupName: Value(groupName),
      level: Value(level),
      creatingTime: Value(creatingTime),
    );
  }

  factory GroupData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupData(
      id: serializer.fromJson<int>(json['id']),
      groupName: serializer.fromJson<String>(json['groupName']),
      level: serializer.fromJson<int>(json['level']),
      creatingTime: serializer.fromJson<DateTime>(json['creatingTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'groupName': serializer.toJson<String>(groupName),
      'level': serializer.toJson<int>(level),
      'creatingTime': serializer.toJson<DateTime>(creatingTime),
    };
  }

  GroupData copyWith(
          {int? id, String? groupName, int? level, DateTime? creatingTime}) =>
      GroupData(
        id: id ?? this.id,
        groupName: groupName ?? this.groupName,
        level: level ?? this.level,
        creatingTime: creatingTime ?? this.creatingTime,
      );
  @override
  String toString() {
    return (StringBuffer('GroupData(')
          ..write('id: $id, ')
          ..write('groupName: $groupName, ')
          ..write('level: $level, ')
          ..write('creatingTime: $creatingTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupName, level, creatingTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupData &&
          other.id == this.id &&
          other.groupName == this.groupName &&
          other.level == this.level &&
          other.creatingTime == this.creatingTime);
}

class GroupCompanion extends UpdateCompanion<GroupData> {
  final Value<int> id;
  final Value<String> groupName;
  final Value<int> level;
  final Value<DateTime> creatingTime;
  const GroupCompanion({
    this.id = const Value.absent(),
    this.groupName = const Value.absent(),
    this.level = const Value.absent(),
    this.creatingTime = const Value.absent(),
  });
  GroupCompanion.insert({
    this.id = const Value.absent(),
    required String groupName,
    this.level = const Value.absent(),
    required DateTime creatingTime,
  })  : groupName = Value(groupName),
        creatingTime = Value(creatingTime);
  static Insertable<GroupData> custom({
    Expression<int>? id,
    Expression<String>? groupName,
    Expression<int>? level,
    Expression<DateTime>? creatingTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupName != null) 'group_name': groupName,
      if (level != null) 'level': level,
      if (creatingTime != null) 'creating_time': creatingTime,
    });
  }

  GroupCompanion copyWith(
      {Value<int>? id,
      Value<String>? groupName,
      Value<int>? level,
      Value<DateTime>? creatingTime}) {
    return GroupCompanion(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      level: level ?? this.level,
      creatingTime: creatingTime ?? this.creatingTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (creatingTime.present) {
      map['creating_time'] = Variable<DateTime>(creatingTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupCompanion(')
          ..write('id: $id, ')
          ..write('groupName: $groupName, ')
          ..write('level: $level, ')
          ..write('creatingTime: $creatingTime')
          ..write(')'))
        .toString();
  }
}

class $WordTable extends Word with TableInfo<$WordTable, WordData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _groupMeta = const VerificationMeta('group');
  @override
  late final GeneratedColumn<int> group = GeneratedColumn<int>(
      'group', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES "group" (id)'));
  static const VerificationMeta _foreignWordMeta =
      const VerificationMeta('foreignWord');
  @override
  late final GeneratedColumn<String> foreignWord = GeneratedColumn<String>(
      'foreign_word', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wordMeansMeta =
      const VerificationMeta('wordMeans');
  @override
  late final GeneratedColumn<String> wordMeans = GeneratedColumn<String>(
      'means', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wordImagesMeta =
      const VerificationMeta('wordImages');
  @override
  late final GeneratedColumn<String> wordImages = GeneratedColumn<String>(
      'images', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wordExamplesMeta =
      const VerificationMeta('wordExamples');
  @override
  late final GeneratedColumn<String> wordExamples = GeneratedColumn<String>(
      'examples', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wordNoteMeta =
      const VerificationMeta('wordNote');
  @override
  late final GeneratedColumn<String> wordNote = GeneratedColumn<String>(
      'note', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wordDateMeta =
      const VerificationMeta('wordDate');
  @override
  late final GeneratedColumn<DateTime> wordDate = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        group,
        foreignWord,
        wordMeans,
        wordImages,
        wordExamples,
        wordNote,
        wordDate
      ];
  @override
  String get aliasedName => _alias ?? 'word';
  @override
  String get actualTableName => 'word';
  @override
  VerificationContext validateIntegrity(Insertable<WordData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group')) {
      context.handle(
          _groupMeta, group.isAcceptableOrUnknown(data['group']!, _groupMeta));
    } else if (isInserting) {
      context.missing(_groupMeta);
    }
    if (data.containsKey('foreign_word')) {
      context.handle(
          _foreignWordMeta,
          foreignWord.isAcceptableOrUnknown(
              data['foreign_word']!, _foreignWordMeta));
    } else if (isInserting) {
      context.missing(_foreignWordMeta);
    }
    if (data.containsKey('means')) {
      context.handle(_wordMeansMeta,
          wordMeans.isAcceptableOrUnknown(data['means']!, _wordMeansMeta));
    } else if (isInserting) {
      context.missing(_wordMeansMeta);
    }
    if (data.containsKey('images')) {
      context.handle(_wordImagesMeta,
          wordImages.isAcceptableOrUnknown(data['images']!, _wordImagesMeta));
    } else if (isInserting) {
      context.missing(_wordImagesMeta);
    }
    if (data.containsKey('examples')) {
      context.handle(
          _wordExamplesMeta,
          wordExamples.isAcceptableOrUnknown(
              data['examples']!, _wordExamplesMeta));
    } else if (isInserting) {
      context.missing(_wordExamplesMeta);
    }
    if (data.containsKey('note')) {
      context.handle(_wordNoteMeta,
          wordNote.isAcceptableOrUnknown(data['note']!, _wordNoteMeta));
    } else if (isInserting) {
      context.missing(_wordNoteMeta);
    }
    if (data.containsKey('date')) {
      context.handle(_wordDateMeta,
          wordDate.isAcceptableOrUnknown(data['date']!, _wordDateMeta));
    } else if (isInserting) {
      context.missing(_wordDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      group: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group'])!,
      foreignWord: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}foreign_word'])!,
      wordMeans: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}means'])!,
      wordImages: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}images'])!,
      wordExamples: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}examples'])!,
      wordNote: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note'])!,
      wordDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $WordTable createAlias(String alias) {
    return $WordTable(attachedDatabase, alias);
  }
}

class WordData extends DataClass implements Insertable<WordData> {
  final int id;
  final int group;
  final String foreignWord;
  final String wordMeans;
  final String wordImages;
  final String wordExamples;
  final String wordNote;
  final DateTime wordDate;
  const WordData(
      {required this.id,
      required this.group,
      required this.foreignWord,
      required this.wordMeans,
      required this.wordImages,
      required this.wordExamples,
      required this.wordNote,
      required this.wordDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group'] = Variable<int>(group);
    map['foreign_word'] = Variable<String>(foreignWord);
    map['means'] = Variable<String>(wordMeans);
    map['images'] = Variable<String>(wordImages);
    map['examples'] = Variable<String>(wordExamples);
    map['note'] = Variable<String>(wordNote);
    map['date'] = Variable<DateTime>(wordDate);
    return map;
  }

  WordCompanion toCompanion(bool nullToAbsent) {
    return WordCompanion(
      id: Value(id),
      group: Value(group),
      foreignWord: Value(foreignWord),
      wordMeans: Value(wordMeans),
      wordImages: Value(wordImages),
      wordExamples: Value(wordExamples),
      wordNote: Value(wordNote),
      wordDate: Value(wordDate),
    );
  }

  factory WordData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordData(
      id: serializer.fromJson<int>(json['id']),
      group: serializer.fromJson<int>(json['group']),
      foreignWord: serializer.fromJson<String>(json['foreignWord']),
      wordMeans: serializer.fromJson<String>(json['wordMeans']),
      wordImages: serializer.fromJson<String>(json['wordImages']),
      wordExamples: serializer.fromJson<String>(json['wordExamples']),
      wordNote: serializer.fromJson<String>(json['wordNote']),
      wordDate: serializer.fromJson<DateTime>(json['wordDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'group': serializer.toJson<int>(group),
      'foreignWord': serializer.toJson<String>(foreignWord),
      'wordMeans': serializer.toJson<String>(wordMeans),
      'wordImages': serializer.toJson<String>(wordImages),
      'wordExamples': serializer.toJson<String>(wordExamples),
      'wordNote': serializer.toJson<String>(wordNote),
      'wordDate': serializer.toJson<DateTime>(wordDate),
    };
  }

  WordData copyWith(
          {int? id,
          int? group,
          String? foreignWord,
          String? wordMeans,
          String? wordImages,
          String? wordExamples,
          String? wordNote,
          DateTime? wordDate}) =>
      WordData(
        id: id ?? this.id,
        group: group ?? this.group,
        foreignWord: foreignWord ?? this.foreignWord,
        wordMeans: wordMeans ?? this.wordMeans,
        wordImages: wordImages ?? this.wordImages,
        wordExamples: wordExamples ?? this.wordExamples,
        wordNote: wordNote ?? this.wordNote,
        wordDate: wordDate ?? this.wordDate,
      );
  @override
  String toString() {
    return (StringBuffer('WordData(')
          ..write('id: $id, ')
          ..write('group: $group, ')
          ..write('foreignWord: $foreignWord, ')
          ..write('wordMeans: $wordMeans, ')
          ..write('wordImages: $wordImages, ')
          ..write('wordExamples: $wordExamples, ')
          ..write('wordNote: $wordNote, ')
          ..write('wordDate: $wordDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, group, foreignWord, wordMeans, wordImages,
      wordExamples, wordNote, wordDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordData &&
          other.id == this.id &&
          other.group == this.group &&
          other.foreignWord == this.foreignWord &&
          other.wordMeans == this.wordMeans &&
          other.wordImages == this.wordImages &&
          other.wordExamples == this.wordExamples &&
          other.wordNote == this.wordNote &&
          other.wordDate == this.wordDate);
}

class WordCompanion extends UpdateCompanion<WordData> {
  final Value<int> id;
  final Value<int> group;
  final Value<String> foreignWord;
  final Value<String> wordMeans;
  final Value<String> wordImages;
  final Value<String> wordExamples;
  final Value<String> wordNote;
  final Value<DateTime> wordDate;
  const WordCompanion({
    this.id = const Value.absent(),
    this.group = const Value.absent(),
    this.foreignWord = const Value.absent(),
    this.wordMeans = const Value.absent(),
    this.wordImages = const Value.absent(),
    this.wordExamples = const Value.absent(),
    this.wordNote = const Value.absent(),
    this.wordDate = const Value.absent(),
  });
  WordCompanion.insert({
    this.id = const Value.absent(),
    required int group,
    required String foreignWord,
    required String wordMeans,
    required String wordImages,
    required String wordExamples,
    required String wordNote,
    required DateTime wordDate,
  })  : group = Value(group),
        foreignWord = Value(foreignWord),
        wordMeans = Value(wordMeans),
        wordImages = Value(wordImages),
        wordExamples = Value(wordExamples),
        wordNote = Value(wordNote),
        wordDate = Value(wordDate);
  static Insertable<WordData> custom({
    Expression<int>? id,
    Expression<int>? group,
    Expression<String>? foreignWord,
    Expression<String>? wordMeans,
    Expression<String>? wordImages,
    Expression<String>? wordExamples,
    Expression<String>? wordNote,
    Expression<DateTime>? wordDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (group != null) 'group': group,
      if (foreignWord != null) 'foreign_word': foreignWord,
      if (wordMeans != null) 'means': wordMeans,
      if (wordImages != null) 'images': wordImages,
      if (wordExamples != null) 'examples': wordExamples,
      if (wordNote != null) 'note': wordNote,
      if (wordDate != null) 'date': wordDate,
    });
  }

  WordCompanion copyWith(
      {Value<int>? id,
      Value<int>? group,
      Value<String>? foreignWord,
      Value<String>? wordMeans,
      Value<String>? wordImages,
      Value<String>? wordExamples,
      Value<String>? wordNote,
      Value<DateTime>? wordDate}) {
    return WordCompanion(
      id: id ?? this.id,
      group: group ?? this.group,
      foreignWord: foreignWord ?? this.foreignWord,
      wordMeans: wordMeans ?? this.wordMeans,
      wordImages: wordImages ?? this.wordImages,
      wordExamples: wordExamples ?? this.wordExamples,
      wordNote: wordNote ?? this.wordNote,
      wordDate: wordDate ?? this.wordDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (group.present) {
      map['group'] = Variable<int>(group.value);
    }
    if (foreignWord.present) {
      map['foreign_word'] = Variable<String>(foreignWord.value);
    }
    if (wordMeans.present) {
      map['means'] = Variable<String>(wordMeans.value);
    }
    if (wordImages.present) {
      map['images'] = Variable<String>(wordImages.value);
    }
    if (wordExamples.present) {
      map['examples'] = Variable<String>(wordExamples.value);
    }
    if (wordNote.present) {
      map['note'] = Variable<String>(wordNote.value);
    }
    if (wordDate.present) {
      map['date'] = Variable<DateTime>(wordDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordCompanion(')
          ..write('id: $id, ')
          ..write('group: $group, ')
          ..write('foreignWord: $foreignWord, ')
          ..write('wordMeans: $wordMeans, ')
          ..write('wordImages: $wordImages, ')
          ..write('wordExamples: $wordExamples, ')
          ..write('wordNote: $wordNote, ')
          ..write('wordDate: $wordDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$DriftGroupRepository extends GeneratedDatabase {
  _$DriftGroupRepository(QueryExecutor e) : super(e);
  late final $GroupTable group = $GroupTable(this);
  late final $WordTable word = $WordTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [group, word];
}
