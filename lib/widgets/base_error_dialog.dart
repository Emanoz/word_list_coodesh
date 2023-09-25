import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BaseErrorDialog extends StatelessWidget {
  const BaseErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.error, color: Colors.red),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Text(
                'Um erro ocorreu!',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            Text(
              'Um erro ocorreu ao buscar pela palavra selecionada\nCertifique-se de que essa palavra existe e que você possui conexão com a internet.',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
