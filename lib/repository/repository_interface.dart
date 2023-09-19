import 'package:word_list_coodesh_app/data/datasource/datasource_interface.dart';

import '../data/model/word_model.dart';

abstract class RepositoryInterface {
  late DataSourceInterface<WordModel> local;

  late DataSourceInterface<WordModel> remote;

  Future<List<WordModel>> getAllWords();

  Future<WordModel> getDetailsByWord();

  Future<void> addToFavourite(WordModel item);

  Future<void> removeFromFavourite(WordModel item);
}