import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:isar/isar.dart';
import 'package:word_list_coodesh_app/data/collection/word_collection.dart';
import 'package:word_list_coodesh_app/data/datasource/isar_database.dart';
import 'package:word_list_coodesh_app/data/model/word_model.dart';
import 'package:word_list_coodesh_app/repository/word/word_repository_interface.dart';
import 'package:http/http.dart' as http;

class WordRepository implements WordRepositoryInterface {
  @override
  Future<List<WordCollection>> getAllByPage(int page) async {
    int limit = 30;

    return await IsarDatabase.isarDb.wordCollections.where().offset((page - 1) * limit).limit(limit).findAll();
  }

  @override
  Future<WordCollection?> getWordById(int id) async {
    return await IsarDatabase.isarDb.wordCollections.get(id);
  }

  @override
  Future<void> updateWord(WordCollection item) async {
    await IsarDatabase.isarDb.writeTxn(() => IsarDatabase.isarDb.wordCollections.put(item));
  }

  @override
  Future<void> saveAll(List<WordCollection> items) async {
    await IsarDatabase.isarDb.writeTxn(() => IsarDatabase.isarDb.wordCollections.putAll(items));
  }

  @override
  Future<int> getSize() async {
    return await IsarDatabase.isarDb.wordCollections.getSize();
  }

  @override
  Future<List<WordCollection>> getWordsByFavourite(int page) async {
    int limit = 30;
    String? uid;

    if (FirebaseAuth.instance.currentUser != null) {
      uid = FirebaseAuth.instance.currentUser?.uid;
    }

    return await IsarDatabase.isarDb.wordCollections
        .filter()
        .uidElementContains(uid!)
        .isFavouriteEqualTo(true)
        .offset((page - 1) * limit)
        .limit(limit)
        .findAll();
  }

  @override
  Future<List<WordCollection>> getWordsByHistory(int page) async {
    int limit = 30;
    String? uid;

    if (FirebaseAuth.instance.currentUser != null) {
      uid = FirebaseAuth.instance.currentUser?.uid;
    }

    return await IsarDatabase.isarDb.wordCollections
        .filter()
        .uidElementContains(uid!)
        .hasBeenVisitedEqualTo(true)
        .offset((page - 1) * limit)
        .limit(limit)
        .findAll();
  }

  @override
  Future<WordModel> getWordDetail(WordModel word) async {
    try {
      String? uid;

      if (FirebaseAuth.instance.currentUser != null) {
        uid = FirebaseAuth.instance.currentUser?.uid;
      }

      var cached = await IsarDatabase.isarDb.wordCollections
          .filter()
          .uidElementContains(uid!)
          .hasBeenVisitedEqualTo(true)
          .idEqualTo(word.id)
          .findFirst();

      if (cached == null) {
        var response = await http.get(Uri.parse('https://wordsapiv1.p.rapidapi.com/words/${word.word}'), headers: {
          'X-RapidAPI-Key': '55ca3dc844msheeecc5ac5f628ecp1cff2djsn5fcb0e729e5f',
          'X-RapidAPI-Host': 'wordsapiv1.p.rapidapi.com',
        });

        var collection = await IsarDatabase.isarDb.wordCollections.get(word.id);

        var object = WordModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        object.id = word.id;
        object.hasBeenVisited = true;
        object.isFavourite = collection!.isFavourite;

        if (!object.uid.contains(uid)) {
          object.uid.add(uid);
        }

        await IsarDatabase.isarDb
            .writeTxn(() async => await IsarDatabase.isarDb.wordCollections.put(object.toCollection()));

        return object;
      } else {
        return cached.toModel();
      }
    } catch (e) {
      rethrow;
    }
  }
}
