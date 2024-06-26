import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:airsale/constants.dart';

// Let's apply light and dark theme on our app

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: primaryColorLight,
    scaffoldBackgroundColor: bgcolorLightTheme,
    appBarTheme: appBarTheme,
    iconTheme: const IconThemeData(color: primaryColorLight),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: primaryColorLight),
    colorScheme: const ColorScheme.light(
      primary: primaryColorLight,
      secondary: secondaryColorLight,
      error: errorColor,
    ),
    inputDecorationTheme: inputDecorationTheme.copyWith(
      fillColor: primaryColorLight.withOpacity(0.04),
      hintStyle: GoogleFonts.poppins(color: primaryColorLight.withOpacity(0.3), fontSize: 16)
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: primaryColorDark,
    scaffoldBackgroundColor: bgcolorDarkTheme,
    appBarTheme: appBarTheme,
    iconTheme: const IconThemeData(color: primaryColorDark),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: primaryColorDark),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: primaryColorDark,
      secondary: secondaryColorDark,
      error: errorColor,
    ),
    inputDecorationTheme: inputDecorationTheme.copyWith(
      fillColor: primaryColorDark.withOpacity(0.04),
      hintStyle: GoogleFonts.poppins(color: primaryColorDark.withOpacity(0.3), fontSize: 16),
    ),
  );
}

const appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
InputDecorationTheme inputDecorationTheme = const InputDecorationTheme(
  filled: true,
  fillColor: Colors.transparent,
  contentPadding: EdgeInsets.symmetric(
      horizontal: defaultPadding * 1.5, vertical: defaultPadding),
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);
