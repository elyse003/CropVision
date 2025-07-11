import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/predict_screen.dart';
import 'screens/about_screen.dart';

void main() => runApp(CropVisionApp());

class CropVisionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CropVision',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/predict': (context) => PredictScreen(),
        '/about': (context) => AboutScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
