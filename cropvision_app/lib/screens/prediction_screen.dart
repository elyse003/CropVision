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
    final url = Uri.parse("https://cropvision.onrender.com/predict");

    try {
      final data = {
        "soil_moisture": double.tryParse(controllers["soil_moisture"]!.text) ?? 0,
        "soil_pH": double.tryParse(controllers["soil_pH"]!.text) ?? 0,
        "temperature": double.tryParse(controllers["temperature"]!.text) ?? 0,
        "rainfall": double.tryParse(controllers["rainfall"]!.text) ?? 0,
        "humidity": double.tryParse(controllers["humidity"]!.text) ?? 0,
        "sunlight_hours": double.tryParse(controllers["sunlight_hours"]!.text) ?? 0,
        "irrigation_type": int.tryParse(controllers["irrigation_type"]!.text) ?? 0,
        "fertilizer_type": int.tryParse(controllers["fertilizer_type"]!.text) ?? 0,
        "pesticide_usage": double.tryParse(controllers["pesticide_usage"]!.text) ?? 0,
        "total_days": int.tryParse(controllers["total_days"]!.text) ?? 0,
        "NDVI_index": double.tryParse(controllers["NDVI_index"]!.text) ?? 0,
        "crop_type": int.tryParse(controllers["crop_type"]!.text) ?? 0,
        "crop_disease_status": int.tryParse(controllers["crop_disease_status"]!.text) ?? 0,
      };

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final yieldValue = result['predicted_yield_kg_per_hectare'];

        if (yieldValue != null && yieldValue is num) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: Colors.green[50],
              title: Column(
                children: [
                  Icon(Icons.agriculture, size: 48, color: Colors.green[800]),
                  SizedBox(height: 12),
                  Text(
                    "Predicted Yield",
                    style: TextStyle(
                      color: Colors.green[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${yieldValue.toStringAsFixed(2)} kg/hectare",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      clearInputs(); // Reset form
                    },
                    icon: Icon(Icons.refresh),
                    label: Text("Clear & Predict Again"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 105, 244, 54),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          throw Exception("Invalid response format");
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("API error: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error: $e")),
      );
    }
  }

  void clearInputs() {
    for (var controller in controllers.values) {
      controller.clear();
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
