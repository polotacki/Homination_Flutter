import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  textTheme: GoogleFonts.poppinsTextTheme(),
  useMaterial3: true,
);
const Color iconColorDark = Colors.white;
const Color iconColorLight = Colors.black;
const Color textColor2 = Colors.black;
const Color textColor1 = Colors.white;
const Color appBarColor = Color.fromRGBO(36, 41, 46, 1);
const Color scaffoldBgcolor = Color.fromRGBO(36, 41, 46, 1);
const Color light = Colors.white;
const Color dark = Color.fromRGBO(36, 41, 46, 1);
const Color shadowColorLight = Color.fromRGBO(36, 41, 46, 1);

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    iconTheme: const IconThemeData(color: iconColorDark),
    drawerTheme: const DrawerThemeData(backgroundColor: Colors.deepPurple),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: iconColorDark),
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: dark),
      backgroundColor: dark,
    ),
    shadowColor: dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedIconTheme: IconThemeData(color: iconColorDark),
      backgroundColor: dark,
      type: BottomNavigationBarType.fixed,
    ),
    scaffoldBackgroundColor: scaffoldBgcolor,
    fontFamily: 'Gilroy',
    useMaterial3: true,
    colorScheme: const ColorScheme.highContrastDark(
      primary: Colors.deepPurple,
      onPrimary: iconColorDark,
      outline: Colors.grey,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: dark,
    ),
    primaryColor: Colors.deepPurple,
    textTheme: const TextTheme(
      labelSmall: TextStyle(
          fontSize: 16, fontFamily: "Gilroy-Regular.ttf", color: textColor1),
      titleLarge: TextStyle(
          fontSize: 32, fontFamily: "Gilroy-Regular.ttf", color: textColor1),
      titleMedium: TextStyle(
          fontSize: 16,
          fontFamily: "Gilroy-Regular.ttf",
          color: Colors.deepPurple),
      titleSmall: TextStyle(
          fontSize: 16,
          fontFamily: "Gilroy-Regular.ttf",
          color: Colors.redAccent),
      bodyLarge: TextStyle(
          fontSize: 16, fontFamily: "Gilroy-Regular.ttf", color: textColor1),
      displayMedium: TextStyle(
          fontSize: 24, fontFamily: "Gilroy-Regular.ttf", color: textColor2),
      displaySmall: TextStyle(fontSize: 16, color: textColor1),
      labelMedium: TextStyle(
          fontSize: 32,
          fontFamily: "Gilroy-Regular.ttf",
          color: textColor1,
          fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(
          fontSize: 24,
          fontFamily: "Gilroy-Regular.ttf",
          color: textColor1,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w500),
      labelLarge: TextStyle(
          fontSize: 24,
          fontFamily: "Gilroy-Regular.ttf",
          color: Colors.deepPurple),
      bodySmall: TextStyle(
        fontSize: 15,
        fontFamily: "Gilroy-Regular.ttf",
        color: textColor1,
      ),
    ).apply(fontFamily: 'Gilroy'));
