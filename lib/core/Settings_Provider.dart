import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier{
  String currentLanguage="ar";
  ThemeMode CurrentThemeMode=ThemeMode.dark;

  void changeLanguage(String newLanguage) {
    currentLanguage = newLanguage;
    notifyListeners() ;
  }
  void changeMode(ThemeMode newMode) {
    CurrentThemeMode = newMode;
    notifyListeners() ;
  }

  String getsplashviewbackground(){
    return CurrentThemeMode == ThemeMode.dark? "assets/images/splash – 1 (1).png" : "assets/images/splash_background.png";
  }
  bool isDark(){
    return CurrentThemeMode == ThemeMode.dark;

  }

}