import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtracker/providers/theme_provider.dart';
import 'package:subtracker/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        // ChangeNotifierProvider(create: (context) => S()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SubTracker',
            theme: ThemeData(
              primarySwatch: themeProvider.primaryColor,
              brightness: Brightness.light,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme: AppBarTheme(
                backgroundColor: themeProvider.primaryColor,
                foregroundColor: Colors.white,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: themeProvider.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: themeProvider.primaryColor,
              brightness: Brightness.dark,
              visualDensity: VisualDensity.adaptivePlatformDensity,

              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: themeProvider.primaryColor[300],
              ),
            ),
            themeMode: themeProvider.themeMode,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
