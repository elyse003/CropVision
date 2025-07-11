import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/cropvison.jpeg', height: 100),
            SizedBox(height: 20),
            Text('Smarter Farming Starts Here',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green[900]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'CropVision uses AI to help farmers make data-driven decisions. By predicting crop yield based on climate and soil inputs, we improve agricultural efficiency and sustainability.',
              style: TextStyle(fontSize: 16, color: Colors.green[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/predict'),
              child: Text('Continue to Prediction'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}