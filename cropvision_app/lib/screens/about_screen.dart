import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('CropVision'),
        centerTitle: true,
        backgroundColor: Colors.green[900],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset('images/cropvison.jpeg', height: 180, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            Text(
              'Smarter Farming Starts Here',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.green[900]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'CropVision uses Machine Learning to help farmers make data-driven decisions. By predicting crop yield based on climate and soil inputs, we improve agricultural efficiency and sustainability.',
              style: TextStyle(fontSize: 18, color: Colors.green[700], height: 1.4),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/predict'),
            
              label: Text('Click to Predict'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}