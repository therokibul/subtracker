import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
/// A mapping of color names to MaterialColor objects
const Map<String, MaterialColor> materialColor = {
  'red': Colors.red,
  'pink': Colors.pink,
  'purple': Colors.purple,
  'deepPurple': Colors.deepPurple,
  'indigo': Colors.indigo,
  'blue': Colors.blue,
  'lightBlue': Colors.lightBlue,
  'cyan': Colors.cyan,
  'teal': Colors.teal,
  'green': Colors.green,
  'lightGreen': Colors.lightGreen,
  'lime': Colors.lime,
  'yellow': Colors.yellow,
  'amber': Colors.amber,
  'orange': Colors.orange,
  'deepOrange': Colors.deepOrange,
  'brown': Colors.brown,
  'grey': Colors.grey,
  'blueGrey': Colors.blueGrey,
};
/// A provider class to manage theme settings
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  MaterialColor _primaryColor = Colors.green;

  ThemeMode get themeMode => _themeMode;
  MaterialColor get primaryColor => _primaryColor;

  ThemeProvider() {
    _loadTheme();
  }
  /// Sets the theme mode and saves it to shared preferences
  void setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
  }
/// Sets the primary color and saves it to shared preferences
  void setPrimaryColor(MaterialColor color) async {
    _primaryColor = color;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final ColorName = materialColor.entries
        .firstWhere((entry) => entry.value == color)
        .key;
    await prefs.setString('primaryColor', ColorName);
  }
/// Loads the theme settings from shared preferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final themeModeIndex = prefs.getInt('themeMode') ?? ThemeMode.system.index;
    _themeMode = ThemeMode.values[themeModeIndex];

    final colorName = prefs.getString('primaryColor') ?? 'green';
    _primaryColor = materialColor[colorName] ?? Colors.green;
    notifyListeners();
  }
}
