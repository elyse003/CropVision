import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/about_screen.dart';
import 'screens/prediction_screen.dart';

void main() => runApp(CropVisionApp());

class CropVisionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CropVision',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => CropVisionSplash(),
        '/about': (context) => AboutScreen(),
        '/predict': (context) => PredictionScreen(),
      },
    );
  }
}