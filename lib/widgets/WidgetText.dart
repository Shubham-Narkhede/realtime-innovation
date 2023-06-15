import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// this is common widget for the text
Widget widgetText(
    {required String text,
    final bool isCentered = false,
    final int maxLine = 1,
    final double latterSpacing = 0.5,
    final bool textAllCaps = false,
    final isLongText = false,
    final TextStyle? textStyle}) {
  return Text(textAllCaps ? text.toUpperCase() : text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: isLongText ? null : maxLine,
      style: textStyle);
}

TextStyle textStyle(
    {double fontSize = 14,
    Color? textColor,
    FontWeight fontWeight = FontWeight.w500,
    TextStyle? textStyle}) {
  return GoogleFonts.roboto(
      fontSize: fontSize,
      color: textColor,
      fontWeight: fontWeight,
      textStyle: textStyle);
}

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
}
