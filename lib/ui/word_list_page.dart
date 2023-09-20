import 'package:flutter/material.dart';

import '../widgets/word_tile.dart';

class WordListPage extends StatelessWidget {
  const WordListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      color: Colors.white70,
      child: GridView.builder(
        itemCount: 100,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 120.0, mainAxisSpacing: 16.0, crossAxisSpacing: 16.0),
        itemBuilder: (_, index) => const WordTile(word: 'Example'),
      ),
    );
  }
}