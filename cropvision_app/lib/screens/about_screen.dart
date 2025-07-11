import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About CropVision"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("🌾 CropVision",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text("📱 What This App Does:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 6),
            Text("• 🌱 At CropVision, we're on a mission to empower agriculture through smart, AI-powered insights.\n\n\n"),
            Text("• Our app helps farmers and agronomists predict crop yield accurately using real-time data like soil pH, moisture, temperature, and more without guesswork.\n\n\n"),
            Text("• Powered by machine learning and cloud-based APIs, CropVision delivers fast, reliable yield forecasts to guide better planting, irrigation, and harvest decisions.\n\n\n"),
            Text("• Built with Flutter for a clean mobile experience."),
            SizedBox(height: 16),
            Text("🔗 API Endpoint:", style: TextStyle(fontWeight: FontWeight.bold)),
            SelectableText("https://cropvision.onrender.com/predict",
                style: TextStyle(color: Colors.black87)),
            SizedBox(height: 16),
            Text(" Developer: [Marie Elyse Uyiringiye]"),
            Text(" Version: 1.0"),
          ],
        ),
      ),
    );
  }
}
