import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Past Orders 📜'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_rounded, color: Colors.redAccent),
            onPressed: () {
              final ordersBox = Hive.box('orders');
              if (ordersBox.isNotEmpty) {
                ordersBox.clear(); 
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('History cleared! 🧹')),
                );
              }
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('orders').listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No orders yet! Go buy something! 🥤'),
            );
          }

          final orders = box.values.toList().reversed.toList();

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index] as Map;
              final actualIndex = box.length - 1 - index;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 2,
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 232, 245, 233),
                    child: Icon(Icons.receipt_long, color: Colors.green),
                  ),
                  title: Text(
                    'Total: \$${order['total'].toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Items: ${order['items'].join(", ")}\nDate: ${order['date'].toString().split('.')[0]}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  onLongPress: () {
                    box.deleteAt(actualIndex);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order deleted! 🗑️')),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}