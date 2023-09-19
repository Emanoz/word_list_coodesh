import 'dart:convert';

class WordModel {
  final String word;
  final List<String> meanings;
  final String pronunciation;

  WordModel.fromJson(Map<String, dynamic> json)
      : word = json['word'],
        meanings = List.from(jsonDecode(json['result'])).map((e) => e['definition'].toString()).toList(),
        pronunciation = json['pronunciation']['all'];

  Map<String, dynamic> toJson() => {
        'word': word,
        'meaning': meanings,
        'pronunciation': pronunciation,
      };
}
