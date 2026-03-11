import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; 
import '../main.dart';

class HealthAnalyticsScreen extends StatelessWidget {
  const HealthAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<FlSpot> spots = bmiHistory.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Health Analytics')), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('BMI Trend', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), 
            SizedBox(
              height: 300,
              child: LineChart( 
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots, 
                      isCurved: true, 
                      color: Colors.blue, 
                      dotData: const FlDotData(show: true), 
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}