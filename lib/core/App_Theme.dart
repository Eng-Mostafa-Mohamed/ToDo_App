import 'package:flutter/material.dart';

class AppThemeManager {
  static const Color primaryColor = Color(0xFF5D9CEC);
  static const Color sprimaryColor = Color(0xFFDFECDB);
  static const Color darkprimaryColor = Color(0xFF0B092B);
  static const Color darksprimaryColor = Color(0xFF1B2025);

  static ThemeData lightThemeData = ThemeData(
      scaffoldBackgroundColor: sprimaryColor ,
      primaryColor: primaryColor,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        toolbarHeight: 120,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),


      ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(
        fontFamily: "Poppins",
        fontSize: 12,
        fontWeight: FontWeight.w800,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: "Poppins",
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: Colors.grey
      ),
      selectedIconTheme: IconThemeData(
        color: primaryColor,

        size: 26,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.grey,
        size: 23,
      ),
    ),
    dividerTheme: const DividerThemeData (
      color: primaryColor,

    ),
    textTheme:const  TextTheme(
      titleLarge:  TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: "Poppins"),
      bodyLarge: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontFamily: "Poppins"),
      bodyMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontFamily: "Poppins"),
      bodySmall: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontFamily: "Poppins"),
    ),
  );

  static ThemeData darkThemeData = ThemeData(
    scaffoldBackgroundColor: darkprimaryColor ,
    primaryColor: primaryColor,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      toolbarHeight: 120,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: "Poppins",
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),


    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darksprimaryColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.white,
      selectedLabelStyle: TextStyle(
        fontFamily: "Poppins",
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.w800,
      ),
      unselectedLabelStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: Colors.grey
      ),
      selectedIconTheme: IconThemeData(
        color: primaryColor,

        size: 26,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.white,
        size: 23,
      ),
    ),
    dividerTheme: const DividerThemeData (
      color: Colors.white,

    ),
    textTheme:const  TextTheme(
      titleLarge:  TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: "Poppins"),
      bodyLarge: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontFamily: "Poppins"),
      bodyMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontFamily: "Poppins"),
      bodySmall: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontFamily: "Poppins"),
    ),
  );
}
