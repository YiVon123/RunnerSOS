import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextstyles {
  static TextStyle h1 = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static TextStyle h2 = GoogleFonts.poppins(
    fontSize: 26,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static TextStyle h3 = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static TextStyle h4 = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w200,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }
}
