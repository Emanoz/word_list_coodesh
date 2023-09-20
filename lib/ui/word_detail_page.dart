import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/base_button.dart';

class WordDetailPage extends StatelessWidget {
  WordDetailPage({super.key});

  final ScrollController _scrollController = ScrollController();

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
      ),
      body: Container(
        color: Colors.white70,
        child: Stack(
          alignment: Alignment.bottomCenter,
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
                              'Word',
                              style: GoogleFonts.nunito(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'uord',
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
                              onTap: () {},
                              child: const Icon(
                                Icons.play_arrow_outlined,
                                color: Colors.green,
                                size: 32.0,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: LinearProgressIndicator(
                              color: Color(0xFF4AF8AA),
                              minHeight: 8.0,
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            ),
                          )
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
                      itemCount: 30,
                      shrinkWrap: true,
                      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
                      itemBuilder: (_, index) => Text(
                        'Word means word.',
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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              color: Colors.white,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BaseButton(text: 'VOLTAR'),
                  BaseButton(text: 'PRÓXIMO'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}