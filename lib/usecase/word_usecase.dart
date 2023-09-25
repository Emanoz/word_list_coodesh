import 'package:firebase_auth/firebase_auth.dart';
import 'package:word_list_coodesh_app/data/collection/word_collection.dart';
import 'package:word_list_coodesh_app/data/model/word_model.dart';
import 'package:word_list_coodesh_app/repository/word/word_repository_interface.dart';
import 'package:word_list_coodesh_app/ui/word/state/wordlist_state.dart';
import 'package:word_list_coodesh_app/usecase/word_usecase_interface.dart';

class WordUseCase extends WordUseCaseInterface {
  WordUseCase({
    required WordRepositoryInterface repository,
    required WordListState controller,
  }) : super(repository: repository, controller: controller);

  @override
  Future<void> getAllByPage(bool hasBeenVisited) async {
    try {
      //controller.updateLoading(true);
      var words = hasBeenVisited
          ? await repository.getWordsByHistory(controller.page)
          : await repository.getAllByPage(controller.page);

      var list = words.map((word) => word.toModel()).toList();
      controller.addAllWords(list);
    } catch (e) {
      rethrow;
    } finally {
      controller.updateLoading(false);
    }
  }

  @override
  Future<void> getAllByFavourite() async {
    try {
      var words = await repository.getWordsByFavourite(controller.page);

      var list = words.map((word) => word.toModel()).toList();
      controller.addAllWords(list);
    } catch (e) {
      rethrow;
    } finally {
      controller.updateLoading(false);
    }
  }

  @override
  Future<void> updateFavouriteWord(int id, bool update) async {
    try {
      var word = await repository.getWordById(id);
      if (word != null) {
        word = _checkUserState(word.toModel()).toCollection();
        word.isFavourite = update;
        await repository.updateWord(word);
      }
    } catch (e) {
      rethrow;
    } finally {
      controller.updateLoading(false);
    }
  }

  @override
  Future<WordModel> getWordDetail(WordModel word) async {
    try {
      var words = await repository.getWordDetail(word);
      return words;
    } catch (e) {
      rethrow;
    } finally {
      controller.updateLoading(false);
    }
  }

  @override
  Future<WordModel?> getWordById(int id) async {
    try {
      var word = await repository.getWordById(id);
      return word?.toModel();
    } catch(e) {
      rethrow;
    } finally {

    }
  }

  WordModel _checkUserState(WordModel word) {
    if (FirebaseAuth.instance.currentUser != null) {
      var uid = FirebaseAuth.instance.currentUser?.uid;
      if(!word.uid.contains(uid)) {
        word.uid.add(uid!);
      }
    }
    return word;
  }
}
