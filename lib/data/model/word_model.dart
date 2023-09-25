import 'dart:convert';

import 'package:word_list_coodesh_app/data/collection/word_collection.dart';

class WordModel {
  int id;
  final String? word;
  final List<String>? meanings;
  final String? pronunciation;
  bool isFavourite;
  bool hasBeenVisited;
  List<String> uid;

  WordModel({
    required this.id,
    required this.word,
    this.pronunciation,
    this.meanings,
    this.isFavourite = false,
    this.hasBeenVisited = false,
    required this.uid,
  });

  WordModel.fromJson(Map<String, dynamic> json)
      : word = json['word'],
        meanings = List.from(json['results']).map((e) => e['definition'].toString()).toList(),
        pronunciation =
            json['pronunciation'] is Map<String, dynamic> ? json['pronunciation']['all'] : json['pronunciation'],
        isFavourite = false,
        hasBeenVisited = false,
        id = 0,
        uid = [];

  WordCollection toCollection() => WordCollection(
        id: id,
        word: word ?? '',
        meanings: meanings ?? [],
        pronunciation: pronunciation ?? '',
        isFavourite: isFavourite,
        hasBeenVisited: hasBeenVisited,
        uid: uid,
      );
}
