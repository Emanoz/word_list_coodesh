import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_list_coodesh_app/repository/word/word_repository_interface.dart';
import 'package:word_list_coodesh_app/ui/word/word_detail_page.dart';
import 'package:word_list_coodesh_app/usecase/word_usecase_interface.dart';

import '../../widgets/base_error_dialog.dart';
import '../../widgets/word_tile.dart';

class WordListPage extends StatefulWidget {
  const WordListPage({super.key, required this.usecase, this.hasBeenVisited = false});

  final WordUseCaseInterface usecase;
  final bool hasBeenVisited;

  @override
  State<WordListPage> createState() => _WordListPageState();
}

class _WordListPageState extends State<WordListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    widget.usecase.controller.resetPage();

    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0 &&
          widget.usecase.controller.wordlist.length == 30 * widget.usecase.controller.page) {
        widget.usecase.controller.addPage();
        widget.usecase.controller.updateLoading(true);
        await widget.usecase.getAllByPage(widget.hasBeenVisited);
      }
    });

    widget.usecase.controller.updateLoading(true);
    widget.usecase.getAllByPage(widget.hasBeenVisited);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        var controller = widget.usecase.controller;

        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            color: Colors.white70,
            child: ListView(
              controller: _scrollController,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  controller: ScrollController(),
                  itemCount: controller.wordlist.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 120.0,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                  ),
                  itemBuilder: (_, index) {
                    var item = controller.wordlist[index];

                    return WordTile(
                      word: item.word ?? '',
                      onTap: () async {
                        widget.usecase.controller.updateLoading(true);
                        widget.usecase
                            .getWordDetail(item)
                            .then(
                              (value) => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => WordDetailPage(
                                    word: value,
                                    usecase: widget.usecase,
                                  ),
                                ),
                              ),
                            )
                            .catchError(
                              (e) => showDialog(
                                context: context,
                                builder: (_) => const BaseErrorDialog(),
                              ),
                            );
                      },
                    );
                  },
                ),
                if (widget.usecase.controller.wordlist.length == 30 * widget.usecase.controller.page)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}
