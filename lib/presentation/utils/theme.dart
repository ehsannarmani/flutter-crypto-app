import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes {
  static final darkTheme = ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color.fromRGBO(37, 53, 76, 1),
      appBarTheme: const AppBarTheme(color: Color.fromRGBO(25, 36, 54, 1)),
      primaryColor: const Color.fromRGBO(37, 53, 76, 1),
      primaryColorDark: const Color.fromRGBO(25, 36, 54, 1),
      primaryColorLight: const Color.fromRGBO(60, 86, 122, 0.7),
      highlightColor: Colors.white.withOpacity(.3),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(34, 164, 239, 1)),
      drawerTheme:
      const DrawerThemeData(backgroundColor: Color.fromRGBO(25, 36, 54, 1)),
      textTheme: TextTheme(
        headline1: GoogleFonts.signikaNegative(fontSize: 20),
        headline2: GoogleFonts.signikaNegative(fontSize: 18),
        headline3: GoogleFonts.signikaNegative(fontSize: 16),
        headline4: GoogleFonts.signikaNegative(fontSize: 14),
        headline5: GoogleFonts.signikaNegative(fontSize: 12),
        headline6: GoogleFonts.signikaNegative(fontSize: 10),
        subtitle2: GoogleFonts.signikaNegative(fontSize: 12, color: Colors.grey),
        bodyText1: GoogleFonts.ubuntu(fontSize: 26,color: Colors.white),
        bodyText2: GoogleFonts.ubuntu(fontSize: 22,color: Colors.grey.shade300),
        labelMedium: GoogleFonts.ubuntu(fontSize: 14,color: Colors.white),

      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: const Color.fromRGBO(60, 86, 122, 0.7),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              textStyle: GoogleFonts.ubuntu()
          )
      )
  );

  static final lightTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(color: Colors.blue),
      primaryColor: Colors.blue,
      primaryColorDark: Colors.blue[700],
      highlightColor: Colors.blue.withOpacity(.9),
      floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.blue[700]),
      primaryColorLight: Colors.blue[300],
      textTheme: TextTheme(
        headline1: GoogleFonts.signikaNegative(fontSize: 20),
        headline2: GoogleFonts.signikaNegative(fontSize: 18),
        headline3: GoogleFonts.signikaNegative(fontSize: 16),
        headline4: GoogleFonts.signikaNegative(fontSize: 14),
        headline5: GoogleFonts.signikaNegative(fontSize: 12),
        headline6: GoogleFonts.signikaNegative(fontSize: 10),
        subtitle2: GoogleFonts.signikaNegative(
            fontSize: 12, color: Colors.grey.shade400
        ),
        bodyText1: GoogleFonts.ubuntu(fontSize: 26,color: Colors.black),
        bodyText2: GoogleFonts.ubuntu(fontSize: 22,color: Colors.black.withOpacity(.8)),
        labelMedium: GoogleFonts.ubuntu(fontSize: 14,color: Colors.black.withOpacity(.9)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              textStyle: GoogleFonts.ubuntu()

          )
      )
  );
}