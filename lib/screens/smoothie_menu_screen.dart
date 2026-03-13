import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/cart_item.dart';

class SmoothieMenuScreen extends StatelessWidget {
  const SmoothieMenuScreen({super.key});

  final List<Map<String, dynamic>> menuItems = const [
    {'name': 'Strawberry Bliss 🍓', 'price': 5.5},
    {'name': 'Mango Magic 🥭', 'price': 6.0},
    {'name': 'Blueberry Bomb 🫐', 'price': 6.5},
    {'name': 'Avocado Dream 🥑', 'price': 7.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smoothie Menu 🥤')),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('\$${item['price']}'),
              trailing: IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.orangeAccent),
                onPressed: () {
                  final cartBox = Hive.box<CartItem>('cart');
                  cartBox.add(CartItem(
                    name: item['name'],
                    price: item['price'],
                    quantity: 1,
                  ));
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added ${item['name']} to cart! ✨')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}