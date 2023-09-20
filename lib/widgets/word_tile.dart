import 'package:flutter/material.dart';
import 'package:word_list_coodesh_app/ui/word_detail_page.dart';

class WordTile extends StatelessWidget {
  final String word;

  const WordTile({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => WordDetailPage(),
        ),
      ),
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
