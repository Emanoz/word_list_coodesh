import 'package:flutter_tts/flutter_tts.dart';
import 'package:word_list_coodesh_app/utils/base_state_controller/state_controller.dart';

class TtsManager {
  late FlutterTts flutterTts = FlutterTts();
  final StateController<bool> state = StateController(value: false);
  final StateController<double> progressController = StateController(value: 0.0);

  Future speak(String word) async {
    var result = await flutterTts.speak(word);
    if (result == 1) state.update(false);
  }

  Future pause() async {
    var result = await flutterTts.pause();
    if (result == 1) state.update(true);
  }

  void setProgressHandler() async {
    await flutterTts.awaitSpeakCompletion(true);
    flutterTts.setProgressHandler((String text, int startOffset, int endOffset, String word) {
      print('$startOffset - $endOffset - $text');
      progressController.update((endOffset - (endOffset - startOffset) / word.length).toDouble());
    });
  }
}
