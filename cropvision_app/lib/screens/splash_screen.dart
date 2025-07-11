import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/predict');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.agriculture, size: 100, color: Colors.green[800]),
            SizedBox(height: 20),
            Text(
              'CropVision',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green[900]),
            ),
            SizedBox(height: 10),
            Text(
              'Smart Crop Yield Predictor',
              style: TextStyle(fontSize: 16, color: Colors.green[700]),
            ),
          ],
        ),
      ),
    );
  }
}
