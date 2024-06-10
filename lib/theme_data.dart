import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


ThemeData dark = ThemeData(
  primarySwatch: Colors.grey,
  scaffoldBackgroundColor: Colors.black,
   elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
    ),
  ),
  textTheme: TextTheme(
    titleMedium: TextStyle(color: Colors.white, ), 
    headlineSmall: TextStyle(color: Colors.white, ),

  )
);

ThemeData light = ThemeData(
  primarySwatch: Colors.yellow,
  scaffoldBackgroundColor: Colors.yellow.shade50,
   elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
    ),
  ),
  textTheme: TextTheme(
    titleMedium: TextStyle(color: Colors.black, ), 
    headlineSmall: TextStyle(color: Colors.black, ),

  )
);

class ThemeColorData with ChangeNotifier {
  SharedPreferences _sharedPreferences;
  bool _isDark;

  ThemeColorData(this._sharedPreferences) : _isDark=true;

  bool get isDark => _isDark;

  ThemeData get themeColor {
    return _isDark ? dark : light;
  }

  Future<void> createSharedPrefObject() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void saveThemeToSharedPref(bool value) {
    _sharedPreferences.setBool('themeData', value);
  }

  Future<void> loadThemeFromSharedPref() async {
    await createSharedPrefObject();
    _isDark = _sharedPreferences.getBool('themeData') ?? true;
    notifyListeners();
  }

  void toggleTheme() {
    _isDark =!_isDark;
    saveThemeToSharedPref(_isDark);
    notifyListeners();
  }
}