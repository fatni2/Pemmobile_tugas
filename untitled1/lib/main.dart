import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/calculator_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/converter_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = false;

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Flutter',
      debugShowCheckedModeBanner: false,
      theme: _isDarkTheme
          ? ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Colors.pinkAccent,
          secondary: Colors.tealAccent,
        ),
      )
          : ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          primary: Colors.pink,
          secondary: Colors.teal,
        ),
      ),
      // Mulai dari SplashScreen
      initialRoute: SplashScreen.routeName,
      routes: {
        // Splash screen
        SplashScreen.routeName: (ctx) =>
            SplashScreen(onToggleTheme: _toggleTheme),

        // Home screen
        HomeScreen.routeName: (ctx) =>
            HomeScreen(onToggleTheme: _toggleTheme),

        // Kalkulator
        CalculatorScreen.routeName: (ctx) =>
            CalculatorScreen(onToggleTheme: _toggleTheme),

        // Pengaturan
        SettingsScreen.routeName: (ctx) =>
            SettingsScreen(onToggleTheme: _toggleTheme),

        // Converter
        ConverterScreen.routeName: (ctx) =>
        const ConverterScreen(),
      },
    );
  }
}
