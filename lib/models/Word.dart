/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the Word type in your schema. */
class Word extends amplify_core.Model {
  static const classType = const _WordModelType();
  final String id;
  final String? _foreignWord;
  final List<String>? _wordMeans;
  final List<String>? _wordExamples;
  final String? _wordNote;
  final List<String>? _wordImages;
  final Group? _group;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  WordModelIdentifier get modelIdentifier {
      return WordModelIdentifier(
        id: id
      );
  }
  
  String get foreignWord {
    try {
      return _foreignWord!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<String> get wordMeans {
    try {
      return _wordMeans!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<String> get wordExamples {
    try {
      return _wordExamples!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get wordNote {
    return _wordNote;
  }
  
  List<String> get wordImages {
    try {
      return _wordImages!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Group get group {
    try {
      return _group!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime get createdAt {
    try {
      return _createdAt!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Word._internal({required this.id, required foreignWord, required wordMeans, required wordExamples, wordNote, required wordImages, required group, required createdAt, updatedAt}): _foreignWord = foreignWord, _wordMeans = wordMeans, _wordExamples = wordExamples, _wordNote = wordNote, _wordImages = wordImages, _group = group, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Word({String? id, required String foreignWord, required List<String> wordMeans, required List<String> wordExamples, String? wordNote, required List<String> wordImages, required Group group, required amplify_core.TemporalDateTime createdAt}) {
    return Word._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      foreignWord: foreignWord,
      wordMeans: wordMeans != null ? List<String>.unmodifiable(wordMeans) : wordMeans,
      wordExamples: wordExamples != null ? List<String>.unmodifiable(wordExamples) : wordExamples,
      wordNote: wordNote,
      wordImages: wordImages != null ? List<String>.unmodifiable(wordImages) : wordImages,
      group: group,
      createdAt: createdAt);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Word &&
      id == other.id &&
      _foreignWord == other._foreignWord &&
      DeepCollectionEquality().equals(_wordMeans, other._wordMeans) &&
      DeepCollectionEquality().equals(_wordExamples, other._wordExamples) &&
      _wordNote == other._wordNote &&
      DeepCollectionEquality().equals(_wordImages, other._wordImages) &&
      _group == other._group &&
      _createdAt == other._createdAt;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Word {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("foreignWord=" + "$_foreignWord" + ", ");
    buffer.write("wordMeans=" + (_wordMeans != null ? _wordMeans!.toString() : "null") + ", ");
    buffer.write("wordExamples=" + (_wordExamples != null ? _wordExamples!.toString() : "null") + ", ");
    buffer.write("wordNote=" + "$_wordNote" + ", ");
    buffer.write("wordImages=" + (_wordImages != null ? _wordImages!.toString() : "null") + ", ");
    buffer.write("group=" + (_group != null ? _group!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Word copyWith({String? foreignWord, List<String>? wordMeans, List<String>? wordExamples, String? wordNote, List<String>? wordImages, Group? group, amplify_core.TemporalDateTime? createdAt}) {
    return Word._internal(
      id: id,
      foreignWord: foreignWord ?? this.foreignWord,
      wordMeans: wordMeans ?? this.wordMeans,
      wordExamples: wordExamples ?? this.wordExamples,
      wordNote: wordNote ?? this.wordNote,
      wordImages: wordImages ?? this.wordImages,
      group: group ?? this.group,
      createdAt: createdAt ?? this.createdAt);
  }
  
  Word copyWithModelFieldValues({
    ModelFieldValue<String>? foreignWord,
    ModelFieldValue<List<String>>? wordMeans,
    ModelFieldValue<List<String>>? wordExamples,
    ModelFieldValue<String?>? wordNote,
    ModelFieldValue<List<String>?>? wordImages,
    ModelFieldValue<Group>? group,
    ModelFieldValue<amplify_core.TemporalDateTime>? createdAt
  }) {
    return Word._internal(
      id: id,
      foreignWord: foreignWord == null ? this.foreignWord : foreignWord.value,
      wordMeans: wordMeans == null ? this.wordMeans : wordMeans.value,
      wordExamples: wordExamples == null ? this.wordExamples : wordExamples.value,
      wordNote: wordNote == null ? this.wordNote : wordNote.value,
      wordImages: wordImages == null ? this.wordImages : wordImages.value,
      group: group == null ? this.group : group.value,
      createdAt: createdAt == null ? this.createdAt : createdAt.value
    );
  }
  
  Word.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _foreignWord = json['foreignWord'],
      _wordMeans = json['wordMeans']?.cast<String>(),
      _wordExamples = json['wordExamples']?.cast<String>(),
      _wordNote = json['wordNote'],
      _wordImages = json['wordImages']?.cast<String>(),
      _group = json['group']?['serializedData'] != null
        ? Group.fromJson(new Map<String, dynamic>.from(json['group']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'foreignWord': _foreignWord, 'wordMeans': _wordMeans, 'wordExamples': _wordExamples, 'wordNote': _wordNote, 'wordImages': _wordImages, 'group': _group?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'foreignWord': _foreignWord,
    'wordMeans': _wordMeans,
    'wordExamples': _wordExamples,
    'wordNote': _wordNote,
    'wordImages': _wordImages,
    'group': _group,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<WordModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<WordModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final FOREIGNWORD = amplify_core.QueryField(fieldName: "foreignWord");
  static final WORDMEANS = amplify_core.QueryField(fieldName: "wordMeans");
  static final WORDEXAMPLES = amplify_core.QueryField(fieldName: "wordExamples");
  static final WORDNOTE = amplify_core.QueryField(fieldName: "wordNote");
  static final WORDIMAGES = amplify_core.QueryField(fieldName: "wordImages");
  static final GROUP = amplify_core.QueryField(
    fieldName: "group",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Group'));
  static final CREATEDAT = amplify_core.QueryField(fieldName: "createdAt");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Word";
    modelSchemaDefinition.pluralName = "Words";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: amplify_core.AuthRuleProvider.USERPOOLS,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["groupID"], name: "byGroup")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Word.FOREIGNWORD,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Word.WORDMEANS,
      isRequired: true,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Word.WORDEXAMPLES,
      isRequired: true,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Word.WORDNOTE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Word.WORDIMAGES,
      isRequired: true,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Word.GROUP,
      isRequired: true,
      targetNames: ['groupID'],
      ofModelName: 'Group'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Word.CREATEDAT,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _WordModelType extends amplify_core.ModelType<Word> {
  const _WordModelType();
  
  @override
  Word fromJson(Map<String, dynamic> jsonData) {
    return Word.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Word';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Word] in your schema.
 */
class WordModelIdentifier implements amplify_core.ModelIdentifier<Word> {
  final String id;

  /** Create an instance of WordModelIdentifier using [id] the primary key. */
  const WordModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'WordModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is WordModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}