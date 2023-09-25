import 'package:word_list_coodesh_app/data/collection/word_collection.dart';
import 'package:word_list_coodesh_app/repository/word/word_repository.dart';

import '../../data/model/word_model.dart';

abstract class WordRepositoryInterface {
  factory WordRepositoryInterface.factory() => WordRepository();

  Future<List<WordCollection>> getAllByPage(int page);

  Future<WordCollection?> getWordById(int id);

  Future<List<WordCollection>> getWordsByFavourite(int page);

  Future<List<WordCollection>> getWordsByHistory(int page);

  Future<WordModel> getWordDetail(WordModel word);

  Future<void> updateWord(WordCollection item);

  Future<void> saveAll(List<WordCollection> items);

  Future<int> getSize();
}