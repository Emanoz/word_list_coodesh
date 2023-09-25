import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_list_coodesh_app/ui/word/word_detail_page.dart';

import '../../usecase/word_usecase_interface.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key, required this.usecase});

  final WordUseCaseInterface usecase;

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    widget.usecase.controller.resetPage();

    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0 &&
          widget.usecase.controller.wordlist.length == 30 * widget.usecase.controller.page) {
        widget.usecase.controller.addPage();
        await widget.usecase.getAllByFavourite();
      }
    });

    widget.usecase.controller.updateLoading(true);
    widget.usecase.getAllByFavourite();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 24.0),
      width: double.infinity,
      color: Colors.white54,
      child: Observer(builder: (context) {
        return ListView.separated(
          itemBuilder: (_, index) {
            if (index < widget.usecase.controller.wordlist.length) {
              var favourite = widget.usecase.controller.wordlist[index];

              return Padding(
                padding: EdgeInsets.only(bottom: index == 29 ? 24.0 : 0.0),
                child: FavouriteTile(
                  title: favourite.word ?? '',
                  subtitle: favourite.pronunciation ?? '',
                  onPressedRemove: () async {
                    widget.usecase.controller.updateLoading(true);
                    await widget.usecase.updateFavouriteWord(favourite.id, false);
                    widget.usecase.controller.resetPage();
                  },
                  onTap: () {
                    widget.usecase.controller.updateLoading(true);
                    widget.usecase.getWordDetail(favourite).then((value) async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => WordDetailPage(word: value, usecase: widget.usecase),
                        ),
                      );
                      //widget.usecase.controller.resetPage();
                    });
                  },
                ),
              );
            } else {
              if (widget.usecase.controller.wordlist.length == 30 * widget.usecase.controller.page) {
                return const Center(child: CircularProgressIndicator());
              }
            }
          },
          separatorBuilder: (_, __) => const SizedBox(
            height: 16.0,
          ),
          itemCount: widget.usecase.controller.wordlist.length + 1,
        );
      }),
    );
  }
}

class FavouriteTile extends StatelessWidget {
  const FavouriteTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPressedRemove,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onPressedRemove;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      elevation: 4.0,
      child: ListTile(
          minVerticalPadding: 16.0,
          onTap: onTap,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          leading: const Icon(
            Icons.favorite,
            size: 36.0,
            color: Colors.red,
          ),
          trailing: TextButton(
            onPressed: onPressedRemove,
            child: Text(
              'REMOVER',
              style: GoogleFonts.nunito(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ),
          title: Text(
            title,
            style: GoogleFonts.nunito(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: GoogleFonts.nunito(
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
            ),
          ),
          tileColor: Colors.white),
    );
  }
}
