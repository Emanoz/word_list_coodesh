import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_list_coodesh_app/ui/word_detail_page.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 24.0),
      width: double.infinity,
      color: Colors.white70,
      child: ListView.separated(
        itemBuilder: (_, index) => Padding(
          padding: EdgeInsets.only(bottom: index == 29 ? 24.0: 0.0),
          child: const FavouriteTile(
            title: 'Example',
            subtitle: 'egzample',
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox(
          height: 16.0,
        ),
        itemCount: 30,
      ),
    );
  }
}

class FavouriteTile extends StatelessWidget {
  const FavouriteTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

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
          onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => WordDetailPage(),
                ),
              ),
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
            onPressed: () {},
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
