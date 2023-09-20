import 'package:mobx/mobx.dart';

part 'state_controller.g.dart';

class StateController<T> = StateControllerBase<T> with _$StateController;

abstract class StateControllerBase<T> with Store {
  StateControllerBase({required this.value});

  @observable
  T value;

  @action
  void update(T value) {
    this.value = value;
  }
}