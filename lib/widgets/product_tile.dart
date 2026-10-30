import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final bool isSaved;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const ProductTile({
    super.key,
    required this.product,
    required this.isSaved,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final inCart = cart.isInCart(product.id);

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: const Color(0xFFE0EDBD),
        child: Icon(
          Icons.directions_run,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        product.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('\${product.category.toUpperCase()} • ⭐ \${product.rating}'),
          const SizedBox(height: 4),
          Text(
            money(product.price),
            style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black87),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(inCart ? Icons.shopping_bag : Icons.shopping_bag_outlined),
            color: inCart ? const Color(0xFF476A36) : Colors.grey,
            onPressed: () => cart.toggleCart(product),
          ),
          IconButton(
            icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
            onPressed: onFavorite,
          ),
        ],
      ),
    );
  }
}
