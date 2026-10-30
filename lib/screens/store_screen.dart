import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/products.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/product_tile.dart';
import 'detail_screen.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late List<Product> catalogProducts;
  final Set<String> favorites = {};
  bool isGridView = false;

  @override
  void initState() {
    super.initState();
    catalogProducts = List.from(initialProducts);
  }

  void _resetCatalog() {
    setState(() {
      catalogProducts = List.from(initialProducts);
    });
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    final newProduct = Product(
      id: 'item_\${DateTime.now().millisecondsSinceEpoch}',
      name: 'Fresh Release \${catalogProducts.length + 1}',
      category: 'Running',
      image: 'assets/images/shoe_0.jpg',
      price: 49900,
      rating: 5.0,
      description: 'Newly pulled item from remote feed.',
    );
    setState(() {
      catalogProducts.insert(0, newProduct);
    });
  }

  void _toggleFavorite(Product p) {
    setState(() {
      if (!favorites.add(p.id)) {
        favorites.remove(p.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SMART CATALOG', style: TextStyle(fontWeight: FontWeight.w900)),
        actions: [
          IconButton(
            tooltip: isGridView ? 'Switch to List' : 'Switch to Grid',
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () => setState(() => isGridView = !isGridView),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () {},
              ),
              if (cart.itemCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    child: Text(
                      '\${cart.itemCount}',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: catalogProducts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('Catalog is Empty', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: _resetCatalog,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset Catalog'),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _handleRefresh,
              child: isGridView ? _buildGridCatalog() : _buildListCatalog(),
            ),
    );
  }

  Widget _buildListCatalog() {
    return ListView.separated(
      itemCount: catalogProducts.length,
      separatorBuilder: (_, __) => const Divider(height: 1, indent: 16, endIndent: 16),
      itemBuilder: (context, index) {
        final product = catalogProducts[index];
        return Dismissible(
          key: ValueKey(product.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white, size: 28),
          ),
          onDismissed: (_) {
            final removedIndex = index;
            final removedProduct = catalogProducts[removedIndex];

            setState(() {
              catalogProducts.removeAt(removedIndex);
            });

            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('\${removedProduct.name} deleted'),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    setState(() {
                      catalogProducts.insert(removedIndex, removedProduct);
                    });
                  },
                ),
              ),
            );
          },
          child: ProductTile(
            product: product,
            isSaved: favorites.contains(product.id),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailScreen(
                  product: product,
                  saved: favorites.contains(product.id),
                  onFavorite: () => _toggleFavorite(product),
                ),
              ),
            ),
            onFavorite: () => _toggleFavorite(product),
          ),
        );
      },
    );
  }

  Widget _buildGridCatalog() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: catalogProducts.length,
      itemBuilder: (context, index) {
        final product = catalogProducts[index];
        return ProductCard(
          product: product,
          saved: favorites.contains(product.id),
          onOpen: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailScreen(
                product: product,
                saved: favorites.contains(product.id),
                onFavorite: () => _toggleFavorite(product),
              ),
            ),
          ),
          onFavorite: () => _toggleFavorite(product),
        );
      },
    );
  }
}
