import 'package:flutter/material.dart';
import 'package:word_list_coodesh_app/ui/word/word_detail_page.dart';

class WordTile extends StatelessWidget {
  final String word;
  final VoidCallback onTap;

  const WordTile({super.key, required this.word, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: const Color(0x334AF8AA),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black12),
        ),
        child: Center(
          child: FittedBox(child: Text(word)),
        ),
      ),
    );
  }
}
