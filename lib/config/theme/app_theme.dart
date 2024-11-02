import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xff323742),
            primary: Color(0xff323742),
            primaryFixed: Color(0xff323742),
            secondary: Color(0xff7AD0AC),
            tertiary: Color(0xff7AA9D0),
            error: Color(0xffFF0004)),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.poppins()
              .copyWith(fontSize: 40, fontWeight: FontWeight.bold),
          titleMedium: GoogleFonts.poppins()
              .copyWith(fontSize: 32, fontWeight: FontWeight.normal),
          titleSmall: GoogleFonts.poppins()
              .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
          bodyLarge: GoogleFonts.poppins()
              .copyWith(fontSize: 25, fontWeight: FontWeight.normal),
          bodyMedium: GoogleFonts.poppins()
              .copyWith(fontSize: 20, fontWeight: FontWeight.normal),
          bodySmall: GoogleFonts.poppins()
              .copyWith(fontSize: 15, fontWeight: FontWeight.normal),
        ),
        scaffoldBackgroundColor: Color(0xffC8C8C8),
      );
}
