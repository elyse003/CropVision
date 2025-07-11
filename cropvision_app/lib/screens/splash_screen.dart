import 'package:flutter/material.dart';
import 'dart:async';

class CropVisionSplash extends StatefulWidget {
  @override
  _CropVisionSplashState createState() => _CropVisionSplashState();
}

class _CropVisionSplashState extends State<CropVisionSplash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 10), () {
      Navigator.pushReplacementNamed(context, '/about');
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
            Image.asset('images/cropvison.jpeg', height: 120),
            SizedBox(height: 20),
            Text('CropVision',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green[900]),
            ),
            SizedBox(height: 10),
            Text('Smarter Farming Starts Here',
              style: TextStyle(fontSize: 16, color: Colors.green[700]),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(color: Colors.green[800]),
          ],
        ),
      ),
    );
  }
}