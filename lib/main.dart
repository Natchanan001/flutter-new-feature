import 'package:flutter/material.dart';
import 'map_screen.dart'; 
import 'voice_screen.dart';
import 'screens/health_input_screen.dart';
import 'screens/health_analytics_screen.dart';

List<double> bmiHistory = [22.0, 23.5, 21.8];

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map & Voice App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 36, 190, 56)),
        useMaterial3: true,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  // รวมร่างทุกกลุ่มไว้ตรงนี้ค่ะ พส.
  final List<Widget> _pages = [
    const MapScreen(),   // หน้ากลุ่ม 1: Binner
    const VoiceScreen(), // หน้ากลุ่ม 2: Voice Workshop
    const HealthInputScreen(),    // กลุ่ม Happy Superman (บันทึกข้อมูล)
    const HealthAnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed, 
        selectedItemColor: const Color.fromARGB(255, 36, 190, 56), 
        unselectedItemColor: Colors.grey, 

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Binner Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic_none),
            activeIcon: Icon(Icons.mic),
            label: 'Voice Workshop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            activeIcon: Icon(Icons.medical_services),
            label: 'Health Input',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_outlined),
            activeIcon: Icon(Icons.show_chart),
            label: 'Health Analytics',
          ),
        ],
      ),
    );
  }
}