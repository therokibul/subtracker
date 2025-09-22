import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:subtracker/providers/subscription_provider.dart';
import 'package:subtracker/providers/theme_provider.dart';
import 'package:subtracker/screens/home_screen.dart';
import 'package:subtracker/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  NotificationService().requestIOSPermissions();
  await _requestPermissions();
  runApp(const MyApp());
}

Future<void> _requestPermissions() async {
  // Request notification permission
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }

  // On Android, also request the exact alarm permission.
  // This will open the system settings for the user to grant the permission.
  if (await Permission.scheduleExactAlarm.isDenied) {
    await Permission.scheduleExactAlarm.request();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => SubscriptionProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SubTracker',
            theme: ThemeData(
              primarySwatch: themeProvider.primaryColor,
              primaryColor: themeProvider.primaryColor,
              brightness: Brightness.light,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme: AppBarTheme(
                backgroundColor: themeProvider.primaryColor,
                foregroundColor: Colors.white,
                centerTitle: true,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: themeProvider.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: themeProvider.primaryColor,
              primaryColor: themeProvider.primaryColor,
              brightness: Brightness.dark,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme: AppBarTheme(centerTitle: true),
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
