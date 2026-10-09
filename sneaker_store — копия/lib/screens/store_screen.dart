import 'package:flutter/material.dart';
import '../data/products.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'detail_screen.dart';
import 'cart_screen.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});
  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  int tab = 0;
  String query = '', category = 'All';
  final searchController = TextEditingController();
  final Set<String> favorites = {};
  final List<CartItem> cart = [];

  @override
  void dispose() { searchController.dispose(); super.dispose(); }

  void toggleFavorite(Product p) => setState(() {
    if (!favorites.add(p.id)) favorites.remove(p.id);
  });

  void addToCart(Product p, int size) => setState(() {
    final index = cart.indexWhere((item) => item.product.id == p.id && item.size == size);
    if (index == -1) {
      cart.add(CartItem(product: p, size: size));
    } else {
      cart[index].quantity++;
    }
  });

  void openProduct(Product p) {
    Navigator.push(context, MaterialPageRoute<void>(builder: (_) => DetailScreen(
      product: p, saved: favorites.contains(p.id),
      onFavorite: () => toggleFavorite(p), onAdd: (size) => addToCart(p, size))));
  }

  @override
  Widget build(BuildContext context) {
    final count = cart.fold<int>(0, (sum, item) => sum + item.quantity);
    final visible = products.where((p) => tab == 1
      ? favorites.contains(p.id)
      : (category == 'All' || p.category == category) &&
        '${p.name} ${p.category}'.toLowerCase().contains(query.toLowerCase())).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('SNEAKER / STORE', style: TextStyle(
        fontWeight: FontWeight.w800, letterSpacing: 1, fontSize: 18)), actions: [
          IconButton(tooltip: 'Cart ($count)', onPressed: () => setState(() => tab = 2),
            icon: const Icon(Icons.shopping_bag_outlined))]),
      body: SafeArea(child: Center(child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: tab == 2 ? CartScreen(items: cart, onQuantity: (item, change) {
          setState(() {
            item.quantity += change;
            if (item.quantity <= 0) cart.remove(item);
          });
        }) : ListView(key: PageStorageKey('catalog-$tab'), padding: const EdgeInsets.all(20), children: [
          if (tab == 0) ...[
            Container(padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: const Color(0xFFE0EDBD), borderRadius: BorderRadius.circular(28)),
              child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('FIND YOUR NEXT PAIR', style: TextStyle(fontSize: 11, letterSpacing: 2)),
                SizedBox(height: 12),
                Text(
                  'Your pace.\nYour pair.',
                  style: TextStyle(
                    fontSize: 38,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 12), Text('Everyday sneakers. Easy choices.', style: TextStyle(fontSize: 16)),
              ])),
            const SizedBox(height: 20),
            TextField(controller: searchController, onChanged: (value) => setState(() => query = value.trim()),
              decoration: InputDecoration(hintText: 'Search sneakers', prefixIcon: const Icon(Icons.search),
                filled: true, fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none))),
            const SizedBox(height: 12),
            Wrap(spacing: 8, runSpacing: 8, children: ['All', 'Running', 'Lifestyle', 'Training']
              .map((value) => ChoiceChip(label: Text(value), selected: category == value,
                onSelected: (_) => setState(() => category = value))).toList()),
            const SizedBox(height: 24),
          ],
          Row(children: [Expanded(child: Text(tab == 1 ? 'Saved pairs' : 'The collection',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800))),
            Text('${visible.length} items')]),
          const SizedBox(height: 16),
          if (visible.isEmpty) Padding(padding: const EdgeInsets.symmetric(vertical: 40),
            child: Text(tab == 1 ? 'Tap a bookmark to save your favorite pair.' : 'No matches. Try another search or category.')),
          LayoutBuilder(builder: (context, constraints) {
            // Natural card heights avoid fixed-height grid overflow with larger text.
            final columns = constraints.maxWidth < 480 ? 1 : constraints.maxWidth < 850 ? 2 : 3;
            final width = (constraints.maxWidth - (columns - 1) * 16) / columns;
            return Wrap(spacing: 16, runSpacing: 16, children: visible.map((p) => SizedBox(
              width: width, child: ProductCard(product: p, saved: favorites.contains(p.id),
                onOpen: () => openProduct(p), onFavorite: () => toggleFavorite(p)))).toList());
          }),
          const SizedBox(height: 20),
        ])))),
      bottomNavigationBar: NavigationBar(selectedIndex: tab,
        onDestinationSelected: (value) => setState(() => tab = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'Discover'),
          NavigationDestination(icon: Icon(Icons.bookmark_border), selectedIcon: Icon(Icons.bookmark), label: 'Favorites'),
          NavigationDestination(icon: Icon(Icons.shopping_bag_outlined), selectedIcon: Icon(Icons.shopping_bag), label: 'Cart'),
        ]),
    );
  }
}
