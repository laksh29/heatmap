import 'package:flutter/material.dart';
import 'package:scapia/hm_page.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HeatmapScreen(),
    );
  }
}

class HeatmapScreen extends StatelessWidget {
  const HeatmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spending Heatmap"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: Heatmap(),
      ),
    );
  }
}
