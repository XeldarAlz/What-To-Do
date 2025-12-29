import 'package:flutter/material.dart';
import 'package:what_to_do_app/core/core.dart';
import 'package:what_to_do_app/features/home/home.dart';

class WhatToDoApp extends StatelessWidget {
  const WhatToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ne Yapalım?',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Automatically switches based on device settings
      home: const HomePage(),
    );
  }
}
