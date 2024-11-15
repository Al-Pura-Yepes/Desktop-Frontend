import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff323742),
            primary: const Color(0xff323742),
            primaryFixed: const Color(0xff323742),
            secondary: const Color(0xff7AD0AC),
            tertiary: const Color(0xff7AA9D0),
            error: const Color(0xffFF0004)),
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
        scaffoldBackgroundColor: const Color(0xffdadada),
      );
}
