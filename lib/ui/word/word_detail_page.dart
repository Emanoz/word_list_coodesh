import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_list_coodesh_app/data/model/word_model.dart';
import 'package:word_list_coodesh_app/usecase/word_usecase_interface.dart';
import 'package:word_list_coodesh_app/utils/base_state_controller/state_controller.dart';
import 'package:word_list_coodesh_app/utils/tts_manager.dart';
import 'package:word_list_coodesh_app/widgets/base_error_dialog.dart';

import '../../widgets/base_button.dart';

class WordDetailPage extends StatefulWidget {
  const WordDetailPage({
    super.key,
    required this.word,
    required this.usecase,
  });

  final WordModel word;
  final WordUseCaseInterface usecase;

  @override
  State<WordDetailPage> createState() => _WordDetailPageState();
}

class _WordDetailPageState extends State<WordDetailPage> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _controller;
  late StateController<bool> isFavourite;
  late StateController<WordModel> _word;
  final TtsManager ttsManager = TtsManager();

  @override
  void initState() {
    _word = StateController(value: widget.word);
    isFavourite = StateController(value: _word.value.isFavourite);
    ttsManager.setProgressHandler();

    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF14545C),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          'Word detail',
          style: GoogleFonts.nunito(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
        actions: [
          Observer(builder: (context) {
            return IconButton(
              onPressed: () async {
                bool isFavourite = _word.value.isFavourite;

                widget.usecase.controller.updateLoading(true);
                await widget.usecase.updateFavouriteWord(_word.value.id, !isFavourite);
                this.isFavourite.update(!isFavourite);
              },
              icon: Icon(
                isFavourite.value ? Icons.favorite : Icons.favorite_border,
                size: 32.0,
              ),
              color: Colors.red,
            );
          }),
        ],
      ),
      body: Observer(builder: (context) {
        return Container(
          color: Colors.white54,
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        elevation: 3.0,
                        child: Container(
                          height: MediaQuery.sizeOf(context).height / 3,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.black12),
                              color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _word.value.word ?? '',
                                style: GoogleFonts.nunito(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                _word.value.pronunciation ?? '',
                                style: GoogleFonts.nunito(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black26,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: InkWell(
                                onTap: () async {
                                  ttsManager.state.update(!ttsManager.state.value);
                                  if (ttsManager.state.value) {
                                    _controller.forward();
                                    await ttsManager.speak(_word.value.word ?? '');
                                    _controller.reverse();
                                    ttsManager.progressController.update(0.0);
                                  } else {
                                    _controller.reverse();
                                    await ttsManager.pause();
                                  }
                                },
                                child: AnimatedIcon(
                                  icon: AnimatedIcons.play_pause,
                                  color: Colors.green,
                                  size: 32.0,
                                  progress: _controller,
                                ),
                              ),
                            ),
                            Observer(builder: (context) {
                              return Expanded(
                                child: LinearProgressIndicator(
                                  value: ttsManager.progressController.value,
                                  color: const Color(0xFF4AF8AA),
                                  minHeight: 8.0,
                                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          'Meanings',
                          style: GoogleFonts.nunito(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      ListView.separated(
                        controller: _scrollController,
                        itemCount: (_word.value.meanings ?? []).length,
                        shrinkWrap: true,
                        separatorBuilder: (_, __) => const SizedBox(height: 8.0),
                        itemBuilder: (_, index) => Text(
                          _word.value.meanings![index],
                          style: GoogleFonts.nunito(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BaseButton(
                        text: 'VOLTAR',
                        onTap: () async {
                          if(_word.value.id > 1) {
                            await _getNextOrPreviousWord(context, _word.value.id - 1);
                          }
                        },
                      ),
                      BaseButton(
                        text: 'PRÓXIMO',
                        onTap: () async {
                          await _getNextOrPreviousWord(context, _word.value.id + 1);
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Future<void> _getNextOrPreviousWord(BuildContext context, int id) async {
    WordModel? word;
    try {
      word = await widget.usecase.getWordById(id);
      if (word != null) {
        word = await widget.usecase.getWordDetail(word);
        _word.update(word);
      } else {
        _word.update(WordModel(id: word!.id, word: word.word, uid: []));
        showDialog(context: context, builder: (_) => const BaseErrorDialog());
      }
    } catch (e) {
      _word.update(WordModel(id: word!.id, word: word.word, uid: []));
      showDialog(context: context, builder: (_) => const BaseErrorDialog());
    }
  }
}
