import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();

  int get itemCount => _items.values.fold(0, (sum, item) => sum + item.quantity);

  int get totalAmount => _items.values.fold(0, (sum, item) => sum + item.total);

  bool isInCart(String productId) => _items.containsKey(productId);

  void toggleCart(Product product, {int size = 42}) {
    if (_items.containsKey(product.id)) {
      _items.remove(product.id);
    } else {
      _items[product.id] = CartItem(product: product, size: size, quantity: 1);
    }
    notifyListeners();
  }

  void addToCart(Product product, {int size = 42}) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
    } else {
      _items[product.id] = CartItem(product: product, size: size, quantity: 1);
    }
    notifyListeners();
  }

  void updateQuantity(CartItem item, int delta) {
    if (_items.containsKey(item.product.id)) {
      final current = _items[item.product.id]!;
      current.quantity += delta;
      if (current.quantity <= 0) {
        _items.remove(item.product.id);
      }
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
