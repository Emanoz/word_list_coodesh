import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120.0,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: const Color(0xFF4AF8AA),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}