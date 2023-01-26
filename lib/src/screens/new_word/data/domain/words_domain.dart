// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:langpocket/src/screens/new_word/data/domain/group_words_model.dart';

class Words {
  final Map<String, GroupWords> groups;
  const Words([this.groups = const {}]);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'groups': groups,
    };
  }

  factory Words.fromMap(Map<String, dynamic> map) {
    return Words(
      Map<String, GroupWords>.from((map['groups'] as Map<String, GroupWords>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Words.fromJson(String source) =>
      Words.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Words(groups: $groups)';
}
