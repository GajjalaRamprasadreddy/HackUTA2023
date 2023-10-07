import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData myThemeData(BuildContext context) {
      return ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color(0xFF0EC0BD),
          backgroundColor: Colors.white,
          selectedRowColor: Color(0xFF90BEDD),
          unselectedWidgetColor: Color(0xFF5f5f5f),
          shadowColor: Color(0xFFF8f8f8),
          colorScheme: ColorScheme.fromSwatch().copyWith(
                brightness: Brightness.light,
                primary: Color(0xFF04B7B1),
                secondary: Color(0xFF1D2E59),
          ),
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
          fontFamily: GoogleFonts.urbanist().fontFamily,
          textTheme: const TextTheme(
                headline1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF3B3B3B)),
                headline5: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF3B3B3B)),
                headline2: TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.white),
                headline3: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF3B3B3B)),
                headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                bodyText2: TextStyle(
                    fontSize: 13.0, fontFamily: 'Urbanist', color: Color(0xFF3B3B3B)),
                bodyText1: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Urbanist',
                      color: Color(0xFF006DAB),
                ),
                button: TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white),
                caption:
                TextStyle(fontSize: 12, color: Color.fromARGB(221, 88, 88, 88)),
                labelMedium: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF006DAB)),
                headline4: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w200,
                    color: Colors.white),
                overline: TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF5f5f5f)),
          ));
}
