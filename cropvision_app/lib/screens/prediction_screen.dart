import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictionScreen extends StatefulWidget {
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> controllers = {
    "soil_moisture": TextEditingController(),
    "soil_pH": TextEditingController(),
    "temperature": TextEditingController(),
    "rainfall": TextEditingController(),
    "humidity": TextEditingController(),
    "sunlight_hours": TextEditingController(),
    "irrigation_type": TextEditingController(),
    "fertilizer_type": TextEditingController(),
    "pesticide_usage": TextEditingController(),
    "total_days": TextEditingController(),
    "NDVI_index": TextEditingController(),
    "crop_type": TextEditingController(),
    "crop_disease_status": TextEditingController(),
  };

  Future<void> predict() async {
    final url = Uri.parse("https://cropvision.onrender.com/predict"); // Replace with your actual API endpoint

    final data = {
      for (var k in controllers.keys)
        k: double.parse(controllers[k]!.text)
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final predictedYield =
          responseData['predicted_yield_kg_per_hectare'].toStringAsFixed(2);

      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.green[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (ctx) => Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.agriculture, size: 40, color: Colors.green[800]),
              SizedBox(height: 12),
              Text(
                'Predicted Yield',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
              ),
              SizedBox(height: 10),
              Text(
                '$predictedYield kg/hectare',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Smarter Farming Starts Here 🌿',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green[700],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.body}')),
      );
    }
  }

  Widget inputCard(String label, TextEditingController controller) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: label.replaceAll("_", " ").toUpperCase(),
            labelStyle: TextStyle(color: Colors.green[700]),
            border: UnderlineInputBorder(),
          ),
          validator: (value) =>
              value == null || value.isEmpty ? 'Please enter $label' : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prediction Screen"),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => Navigator.pushNamed(context, '/about'),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              for (var k in controllers.keys) inputCard(k, controllers[k]!),
              SizedBox(height: 24),
              ElevatedButton.icon(
                icon: Icon(Icons.insights),
                label: Text("Predict Yield"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    predict();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}