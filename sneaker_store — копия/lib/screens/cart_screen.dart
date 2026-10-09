import 'package:flutter/material.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  final List<CartItem> items;
  final void Function(CartItem, int) onQuantity;
  const CartScreen({super.key, required this.items, required this.onQuantity});
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Your cart is empty.\nFind your next pair in Discover.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
    final total = items.fold<int>(0, (sum, item) => sum + item.total);
    return ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Your selection',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
      const SizedBox(height: 16),
      ...items.map((item) => Card(
          color: Colors.white,
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(item.product.image,
                                  width: 64, height: 64, fit: BoxFit.cover)),
                          const SizedBox(width: 12),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(item.product.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17)),
                                Text('EU ${item.size}'),
                                Text(money(item.product.price)),
                              ])),
                        ]),
                    const SizedBox(height: 12),
                    Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            IconButton(
                                tooltip: 'Decrease quantity',
                                onPressed: () => onQuantity(item, -1),
                                icon: const Icon(Icons.remove_circle_outline)),
                            Text('${item.quantity}'),
                            IconButton(
                                tooltip: 'Increase quantity',
                                onPressed: () => onQuantity(item, 1),
                                icon: const Icon(Icons.add_circle_outline)),
                          ]),
                          Text(money(item.total),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700)),
                          TextButton(
                              onPressed: () => onQuantity(item, -item.quantity),
                              child: const Text('Remove'))
                        ]),
                  ])))),
      const SizedBox(height: 20),
      Wrap(spacing: 20, runSpacing: 8, children: [
        const Text('Total', style: TextStyle(fontSize: 24)),
        Text(money(total),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800))
      ]),
      const SizedBox(height: 16),
      const Text(
          'Milestone 1 demo. Checkout and payments are not connected.\nYour selections are kept until the app restarts.',
          style: TextStyle(color: Colors.black54, height: 1.5)),
    ]);
  }
}
