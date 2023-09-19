import 'package:mobx/mobx.dart';

import '../../data/model/word_model.dart';

part 'wordlist_state.g.dart';

class WordListState = WordListStateBase with _$WordListState;

abstract class WordListStateBase with Store {
  @observable
  ObservableList<WordModel> wordlist = ObservableList();

  @observable
  int page = 1;

  @action
  void addAllWords(List<WordModel> words) {
    wordlist.addAll(words);
  }

  @action
  void addPage() {
    page += 1;
  }

  @action
  void resetPage() {
    page = 1;
    wordlist.clear();
  }
}