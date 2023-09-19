// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wordlist_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WordListState on WordListStateBase, Store {
  late final _$wordlistAtom =
      Atom(name: 'WordListStateBase.wordlist', context: context);

  @override
  ObservableList<WordModel> get wordlist {
    _$wordlistAtom.reportRead();
    return super.wordlist;
  }

  @override
  set wordlist(ObservableList<WordModel> value) {
    _$wordlistAtom.reportWrite(value, super.wordlist, () {
      super.wordlist = value;
    });
  }

  late final _$pageAtom =
      Atom(name: 'WordListStateBase.page', context: context);

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$WordListStateBaseActionController =
      ActionController(name: 'WordListStateBase', context: context);

  @override
  void addAllWords(List<WordModel> words) {
    final _$actionInfo = _$WordListStateBaseActionController.startAction(
        name: 'WordListStateBase.addAllWords');
    try {
      return super.addAllWords(words);
    } finally {
      _$WordListStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addPage() {
    final _$actionInfo = _$WordListStateBaseActionController.startAction(
        name: 'WordListStateBase.addPage');
    try {
      return super.addPage();
    } finally {
      _$WordListStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetPage() {
    final _$actionInfo = _$WordListStateBaseActionController.startAction(
        name: 'WordListStateBase.resetPage');
    try {
      return super.resetPage();
    } finally {
      _$WordListStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
wordlist: ${wordlist},
page: ${page}
    ''';
  }
}
