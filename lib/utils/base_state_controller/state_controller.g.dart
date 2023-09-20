// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StateController<T> on StateControllerBase<T>, Store {
  late final _$valueAtom =
      Atom(name: 'StateControllerBase.value', context: context);

  @override
  T get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(T value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  late final _$StateControllerBaseActionController =
      ActionController(name: 'StateControllerBase', context: context);

  @override
  void update(T value) {
    final _$actionInfo = _$StateControllerBaseActionController.startAction(
        name: 'StateControllerBase.update');
    try {
      return super.update(value);
    } finally {
      _$StateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
