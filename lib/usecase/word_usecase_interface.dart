import 'package:word_list_coodesh_app/ui/word/state/wordlist_state.dart';
import 'package:word_list_coodesh_app/usecase/word_usecase.dart';

import '../data/model/word_model.dart';
import '../repository/word/word_repository_interface.dart';

abstract class WordUseCaseInterface {
  WordUseCaseInterface({required this.repository, required this.controller});

  factory WordUseCaseInterface.factory({
    required WordRepositoryInterface repository,
    required WordListState controller,
  }) =>
      WordUseCase(repository: repository, controller: controller);

  final WordRepositoryInterface repository;
  final WordListState controller;

  Future<void> getAllByPage(bool hasBeenVisited);
  Future<void> getAllByFavourite();
  Future<void> updateFavouriteWord(int id, bool update);
  Future<WordModel> getWordDetail(WordModel word);
  Future<WordModel?> getWordById(int id);
}
