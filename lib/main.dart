import 'package:flutter/material.dart';
import 'package:noteapp/theme/app_theme.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteApp',
      debugShowCheckedModeBanner: false,
      theme: isDark ? AppTheme.dark : AppTheme.light,
      home: HomePage(onToggleTheme: toggleTheme),
    );
  }
}