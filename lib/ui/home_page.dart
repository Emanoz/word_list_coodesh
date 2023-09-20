import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_list_coodesh_app/ui/favourite_page.dart';
import 'package:word_list_coodesh_app/ui/word_list_page.dart';

import '../utils/base_state_controller/state_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StateController<int> pageIndex = StateController(value: 0);
  late List<Widget> pages;

  @override
  void initState() {
    pages = [const WordListPage(), const WordListPage(), const FavouritePage()];
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
