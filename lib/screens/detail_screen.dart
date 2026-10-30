import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  final bool saved;
  final VoidCallback onFavorite;

  const DetailScreen({
    super.key,
    required this.product,
    required this.saved,
    required this.onFavorite,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int selectedSize = 42;

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final p = widget.product;

    return Scaffold(
      appBar: AppBar(title: Text(p.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE0EDBD),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.directions_run, size: 100, color: Color(0xFF476A36)),
            ),
            const SizedBox(height: 20),
            Text(p.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(money(p.price), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            const Text('Select Size (EU)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: p.sizes.map((size) {
                return ChoiceChip(
                  label: Text('\$size'),
                  selected: selectedSize == size,
                  onSelected: (_) => setState(() => selectedSize = size),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text(p.description, style: const TextStyle(fontSize: 15, height: 1.5)),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: () {
              cart.addToCart(p, size: selectedSize);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('\${p.name} (EU \$selectedSize) added to cart!')),
              );
            },
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Add to Cart'),
          ),
        ),
      ),
    );
  }
}
