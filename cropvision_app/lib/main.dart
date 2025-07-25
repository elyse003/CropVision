import 'package:flutter/material.dart';
import 'theme_manager.dart';
import 'screens/about_screen.dart';
import 'screens/prediction_screen.dart';
import 'screens/splash_screen.dart'; 

void main() {
  runApp(CropVisionApp());
}

class CropVisionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeManager.themeMode,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'CropVision',
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: mode,
          initialRoute: '/',
          routes: {
            '/': (context) => CropVisionSplash(),
            '/about': (context) => AboutScreen(),
            '/predict': (context) => PredictionScreen(),
          },
        );
      },
    );
  }
}