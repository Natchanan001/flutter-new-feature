import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/cart_item.dart';
import 'order_history_screen.dart'; // หรือ 'screens/order_history_screen.dart' ตามที่ พส. วางไฟล์ไว้

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
        title: const Text('Smoothie Cart'),
        actions: [
          // 📜 ปุ่มดูประวัติการสั่งซื้อ (Order History)
          IconButton(
            icon: const Icon(Icons.history_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderHistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<CartItem>('cart').listenable(),
        builder: (context, Box<CartItem> box, _) {
          final items = box.values.toList();

          if (items.isEmpty) return const Center(child: Text('Empty Cart 🥤'));

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) {
              final item = items[i];
              return ListTile(
                title: Text(item.name),
                subtitle: Text('\$${item.price}'),
                trailing: Text('x${item.quantity}'),
                onLongPress: () => item.delete(), // กดค้างเพื่อลบของชิ้นนี้
              );
            },
          );
        },
      ),
      // 🚀 ปุ่ม Checkout: ย้ายของจาก Cart ไป Orders Box
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final cartBox = Hive.box<CartItem>('cart');
          final ordersBox = Hive.box('orders');

          if (cartBox.isNotEmpty) {
            // 1. แพ็กของใส่ถุงเตรียมเข้าประวัติแบบ Persistent
            final orderData = {
              'date': DateTime.now(),
              'total': cartBox.values.fold(0.0, (sum, item) => sum + (item.price * item.quantity)),
              'items': cartBox.values.map((item) => item.name).toList(),
            };


            ordersBox.add(orderData);

            // 3. ล้างตะกร้าให้ว่างพร้อมช้อปใหม่
            cartBox.clear();
            
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Ordered! See you in History 💅')),
            );
          } else {
            // ถ้าตะกร้าว่างแล้วเผลอกด
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Your cart is empty! 🥤')),
            );
          }
        },
        backgroundColor: const Color.fromARGB(255, 36, 190, 56),
        child: const Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}