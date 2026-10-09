import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool saved;
  final VoidCallback onOpen, onFavorite;
  const ProductCard({super.key, required this.product, required this.saved,
    required this.onOpen, required this.onFavorite});

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero, elevation: 0, color: Colors.white,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    child: InkWell(onTap: onOpen, child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          AspectRatio(aspectRatio: 1.4, child: Image.asset(product.image,
            fit: BoxFit.cover, semanticLabel: product.name)),
          Positioned(top: 8, right: 8, child: IconButton.filledTonal(
            tooltip: saved ? 'Remove favorite' : 'Save favorite',
            onPressed: onFavorite,
            icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border))),
        ]),
        Padding(padding: const EdgeInsets.all(16), child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(product.category.toUpperCase(), style: const TextStyle(
              fontSize: 11, letterSpacing: 1.4, color: Color(0xFF5A6356))),
            const SizedBox(height: 8),
            Text(product.name, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Wrap(spacing: 16, runSpacing: 8, children: [
              Text(money(product.price), style: const TextStyle(fontWeight: FontWeight.w700)),
              Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.star_rounded, size: 18, color: Color(0xFFB77B08)),
                Text(' ${product.rating}')]),
            ]),
          ])),
      ])),
  );
}
