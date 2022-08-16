import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widgetbook_challenge/app.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'WidgetBook Challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      home: const App(),
    ),
  );
}
