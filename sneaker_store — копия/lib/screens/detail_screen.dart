import 'package:flutter/material.dart';
import '../models/product.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  final bool saved;
  final VoidCallback onFavorite;
  final ValueChanged<int> onAdd;
  const DetailScreen({super.key, required this.product, required this.saved,
    required this.onFavorite, required this.onAdd});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late bool saved;
  int? selectedSize;
  @override
  void initState() { super.initState(); saved = widget.saved; }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final photo = ClipRRect(borderRadius: BorderRadius.circular(28),
      child: Stack(children: [
        AspectRatio(aspectRatio: 1.1,
          child: Image.asset(p.image, fit: BoxFit.cover, semanticLabel: p.name)),
        Positioned(right: 12, top: 12, child: IconButton.filledTonal(
          tooltip: saved ? 'Remove favorite' : 'Save favorite',
          onPressed: () {
            setState(() => saved = !saved);
            widget.onFavorite();
          }, icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border))),
      ]));
    final info = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('THE EVERYDAY COLLECTION', style: TextStyle(
        letterSpacing: 1.8, fontSize: 12, color: Color(0xFF58634D))),
      const SizedBox(height: 12),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Text(p.name, style: const TextStyle(
          fontSize: 32, fontWeight: FontWeight.w800, height: 1.1))),
      ]),
      const SizedBox(height: 16),
      Wrap(spacing: 20, runSpacing: 10, crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(money(p.price), style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
          Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.star_rounded, color: Color(0xFFB77B08)),
            Text(' ${p.rating} / 5')]),
        ]),
      const SizedBox(height: 12),
      Wrap(spacing: 8, runSpacing: 8, children: [
        Chip(label: Text(p.category)), const Chip(label: Text('New collection')),
        const Chip(label: Text('In stock'))]),
      const SizedBox(height: 20),
      const Text('Choose your size · EU', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
      const SizedBox(height: 10),
      Wrap(spacing: 8, runSpacing: 8, children: p.sizes.map((size) => ChoiceChip(
        label: Text('$size'), selected: selectedSize == size,
        onSelected: (_) => setState(() => selectedSize = size))).toList()),
      const SizedBox(height: 20),
      Text(p.description, style: const TextStyle(fontSize: 16, height: 1.6)),
      const SizedBox(height: 16),
      const Text('Demo catalogue • illustrative product information',
        style: TextStyle(color: Colors.black54, fontSize: 12)),
      const SizedBox(height: 12),
      TextButton.icon(onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back), label: const Text('Back to collection')),
    ]);
    return Scaffold(
      appBar: AppBar(title: const Text('Product details')),
      body: SafeArea(child: SingleChildScrollView(
        padding: const EdgeInsets.all(20), child: Center(child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth >= 720) {
              return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: photo), const SizedBox(width: 32), Expanded(child: info)]);
            }
            return Column(children: [photo, const SizedBox(height: 24), info]);
          }))))),
      // Outside the scroll view: stays visible while product content scrolls.
      bottomNavigationBar: SafeArea(top: false, child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        child: Row(children: [Expanded(child: FilledButton.icon(
          key: const ValueKey('addToCart'),
          onPressed: selectedSize == null ? null : () {
            widget.onAdd(selectedSize!);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${p.name} · EU $selectedSize added to cart')));
          }, icon: const Icon(Icons.shopping_bag_outlined),
          label: Text(selectedSize == null ? 'Select a size' : 'Add to Cart'),
        ))]))),
    );
  }
}
