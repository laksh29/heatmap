import 'package:flutter/material.dart';
import 'package:scapia/screens/intro_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Heatmap',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          // elevation: 0.0,
        ),
        useMaterial3: false,
      ),
      home: const IntroScreen(),
    );
  }
}
