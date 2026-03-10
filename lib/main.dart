import 'package:flutter/material.dart';
import 'map_screen.dart'; // แยกหน้าแมพออกไป
import 'voice_screen.dart'; // หน้าฟีเจอร์ใหม่

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
        ],
      ),
    );
  }
}