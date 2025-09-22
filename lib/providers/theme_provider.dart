import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// A map to easily convert color names (string) to MaterialColor objects
const Map<String, MaterialColor> materialColors = {
  'purple': Colors.purple,
  'deepPurple': Colors.deepPurple,
  'blue': Colors.blue,
  'indigo': Colors.indigo,
  'teal': Colors.teal,
  'green': Colors.green,
  'orange': Colors.orange,
  'red': Colors.red,
  'pink': Colors.pink,
  'cyan': Colors.cyan,
  'amber': Colors.amber,
  'lime': Colors.lime,
  'blueGrey': Colors.blueGrey,
  'brown': Colors.brown,
  'grey': Colors.grey,
  'lightBlue': Colors.lightBlue,
  'lightGreen': Colors.lightGreen,
  'deepOrange': Colors.deepOrange,
  'yellow': Colors.yellow,
};

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  MaterialColor _primaryColor = Colors.teal;

  ThemeMode get themeMode => _themeMode;
  MaterialColor get primaryColor => _primaryColor;

  ThemeProvider() {
    _loadTheme();
  }

  // Sets the theme mode (light, dark, system) and persists the choice.
  void setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
  }

  // Sets the primary color swatch and persists the choice.
  void setPrimaryColor(MaterialColor color) async {
    _primaryColor = color;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // We save the color's name and look it up later.
    final colorName = materialColors.entries
        .firstWhere((entry) => entry.value == color)
        .key;
    await prefs.setString('primaryColor', colorName);
  }

  // Loads the saved theme preferences from SharedPreferences.
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    // Load ThemeMode
    final themeModeIndex = prefs.getInt('themeMode') ?? ThemeMode.system.index;
    _themeMode = ThemeMode.values[themeModeIndex];

    // Load Primary Color
    final colorName = prefs.getString('primaryColor') ?? 'teal';
    _primaryColor = materialColors[colorName] ?? Colors.teal;

    notifyListeners();
  }
}
