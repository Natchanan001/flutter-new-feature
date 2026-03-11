import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../main.dart';

class HealthInputScreen extends StatefulWidget {
  const HealthInputScreen({super.key});

  @override
  State<HealthInputScreen> createState() => _HealthInputScreenState();
}

class _HealthInputScreenState extends State<HealthInputScreen> {
  final _heightController = TextEditingController(); 
  final _weightController = TextEditingController(); 
  double? _bmi; 

  void _calculateBMI() { 
    final double? h = double.tryParse(_heightController.text);
    final double? w = double.tryParse(_weightController.text);

    if (h != null && h > 0 && w != null && w > 0) {
      setState(() {
        _bmi = w / math.pow(h / 100, 2); 
         bmiHistory.add(_bmi!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Data Input')), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _heightController, decoration: const InputDecoration(labelText: 'Height (cm)')),
            TextField(controller: _weightController, decoration: const InputDecoration(labelText: 'Weight (kg)')), 
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculateBMI, child: const Text('Calculate & Save')), 
            if (_bmi != null) Text('Your BMI: ${_bmi!.toStringAsFixed(2)}', style: const TextStyle(fontSize: 24)), 
          ],
        ),
      ),
    );
  }
}