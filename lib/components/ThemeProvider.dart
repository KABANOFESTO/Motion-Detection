import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _currentTheme;
  final String key = "theme";
  SharedPreferences? _prefs;

  ThemeNotifier() : _currentTheme = blackTheme {
    _loadFromPrefs();
  }

  ThemeData get currentTheme => _currentTheme;

  Future<void> toggleTheme() async {
    _currentTheme = (_currentTheme == blackTheme) ? whiteTheme : blackTheme;
    await _saveToPrefs(_currentTheme == blackTheme ? 'black' : 'white');
    notifyListeners();
  }

  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> _loadFromPrefs() async {
    await _initPrefs();
    final themeStr = _prefs!.getString(key) ?? 'black';
    _currentTheme = (themeStr == 'white') ? whiteTheme : blackTheme;
    notifyListeners();
  }

  Future<void> _saveToPrefs(String themeStr) async {
    await _initPrefs();
    await _prefs!.setString(key, themeStr);
  }
}

ThemeData blackTheme = ThemeData(
  primaryColor: Colors.black,
  hintColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  // Define other text styles as needed
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.green, // Or any other color
  ),
  // Add other customizations as needed
);

ThemeData whiteTheme = ThemeData(
  primaryColor: Colors.white,
  hintColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  // Define other text styles as needed
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.green, // Or any other color
  ),
  // Add other customizations as needed
);

