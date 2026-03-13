import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Past Orders 📜')),
      body: ValueListenableBuilder(
        // เฝ้าดูลิ้นชัก 'orders' แบบถาวร
        valueListenable: Hive.box('orders').listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('No orders yet! Go buy something! 🥤'));
          }

          final orders = box.values.toList().reversed.toList(); // เอาล่าสุดขึ้นก่อน

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index] as Map;
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: const Icon(Icons.receipt_long, color: Colors.green),
                  title: Text('Order Total: \$${order['total'].toStringAsFixed(2)}'),
                  subtitle: Text('Items: ${order['items'].join(", ")}\nDate: ${order['date'].toString().split('.')[0]}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}