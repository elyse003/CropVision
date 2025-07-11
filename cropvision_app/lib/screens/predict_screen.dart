import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictScreen extends StatefulWidget {
  @override
  _PredictScreenState createState() => _PredictScreenState();
}

class _PredictScreenState extends State<PredictScreen> {
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

  String result = "";

  Future<void> predict() async {
    final url = Uri.parse("https://cropvision.onrender.com/predict"); 
    final data = {for (var k in controllers.keys) k: double.parse(controllers[k]!.text)};
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        result = "Predicted Yield: ${responseData['predicted_yield_kg_per_hectare']} kg/ha";
      });
    } else {
      setState(() {
        result = "Error: ${response.body}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crop Yield Predictor"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => Navigator.pushNamed(context, '/about'),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              for (var k in controllers.keys)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: controllers[k],
                    decoration: InputDecoration(labelText: k.replaceAll("_", " ")),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Enter $k' : null,
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) predict();
                },
                child: Text("Predict"),
              ),
              SizedBox(height: 20),
              Text(result, style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
