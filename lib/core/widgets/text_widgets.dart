import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallText extends StatelessWidget {
  final double myFontSize;
  final Color myTextColor;
  final TextAlign myTextAlign;
  final String text;
  final FontWeight myfontWeight;
  const SmallText({
    super.key,
    required this.text,
    this.myfontWeight = FontWeight.normal,
    this.myTextAlign = TextAlign.start,
    this.myTextColor = Colors.black,
    this.myFontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: myTextAlign,
      text,
      style: GoogleFonts.poppins(
        color: myTextColor,
        fontSize: myFontSize,
        fontWeight: myfontWeight,
      ),
    );
  }
}

class SmallTextWhite extends StatelessWidget {
  final double myFontSize;
  final Color myTextColor;
  final TextAlign myTextAlign;
  final String text;
  final FontWeight myfontWeight;
  const SmallTextWhite({
    super.key,
    required this.text,
    this.myFontSize = 15,
    this.myfontWeight = FontWeight.normal,
    this.myTextAlign = TextAlign.start,
    this.myTextColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: myTextAlign,
      style: GoogleFonts.poppins(
        color: myTextColor,
        fontSize: myFontSize,
        fontWeight: myfontWeight,
      ),
    );
  }
}

class MediumText extends StatelessWidget {
  final double myFontSize;
  final Color myTextColor;
  final TextAlign myTextAlign;
  final String text;
  final FontWeight myfontWeight;
  const MediumText({
    super.key,
    required this.text,
    this.myFontSize = 17,
    this.myfontWeight = FontWeight.w500,
    this.myTextAlign = TextAlign.start,
    this.myTextColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: myTextAlign,
      style: GoogleFonts.poppins(
        color: myTextColor,
        fontSize: myFontSize,
        fontWeight: myfontWeight,
      ),
    );
  }
}

class LargeText extends StatelessWidget {
  final Color myTextColor;
  final TextAlign myTextAlign;
  final String text;
  final double myFontSize;
  final FontWeight myfontWeight;
  const LargeText({
    super.key,
    required this.text,
    this.myFontSize = 24,
    this.myfontWeight = FontWeight.bold,
    this.myTextAlign = TextAlign.start,
    this.myTextColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: myTextAlign,
      style: GoogleFonts.poppins(
        color: myTextColor,
        fontSize: myFontSize,
        fontWeight: myfontWeight,
      ),
    );
  }
}
