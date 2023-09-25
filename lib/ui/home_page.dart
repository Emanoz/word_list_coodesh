import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_list_coodesh_app/repository/word/word_repository_interface.dart';
import 'package:word_list_coodesh_app/ui/favourite/favourite_page.dart';
import 'package:word_list_coodesh_app/ui/word/state/wordlist_state.dart';
import 'package:word_list_coodesh_app/ui/word/word_list_page.dart';
import 'package:word_list_coodesh_app/usecase/word_usecase_interface.dart';

import '../utils/base_state_controller/state_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StateController<int> pageIndex = StateController(value: 0);
  late List<Widget> pages = [
    WordListPage(
      key: const Key('wordslist'),
      usecase: WordUseCaseInterface.factory(
        repository: WordRepositoryInterface.factory(),
        controller: WordListState(),
      ),
    ),
    WordListPage(
      key: const Key('wordshistory'),
      hasBeenVisited: true,
      usecase: WordUseCaseInterface.factory(
        repository: WordRepositoryInterface.factory(),
        controller: WordListState(),
      ),
    ),
    FavouritePage(
      usecase: WordUseCaseInterface.factory(
        repository: WordRepositoryInterface.factory(),
        controller: WordListState(),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF14545C),
          title: Text(
            'Word list app',
            style: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.0),
          ),
        ),
        body: pages[pageIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 16.0,
          backgroundColor: const Color(0xFF14545C),
          selectedItemColor: const Color(0xFF4AF8AA),
          selectedLabelStyle: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14.0),
          unselectedLabelStyle: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14.0),
          unselectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), label: 'Words'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined), label: 'Favourite'),
          ],
          onTap: (index) => pageIndex.update(index),
          currentIndex: pageIndex.value,
        ),
      );
    });
  }
}
