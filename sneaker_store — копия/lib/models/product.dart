class Product {
  final String id, name, category, image, description;
  final int price;
  final double rating;
  final List<int> sizes;
  const Product({required this.id, required this.name,
    required this.category, required this.image, required this.price,
    required this.rating, required this.description,
    this.sizes = const [38, 39, 40, 41, 42, 43, 44]});
}

class CartItem {
  final Product product;
  final int size;
  int quantity;
  CartItem({required this.product, required this.size, this.quantity = 1});
  int get total => product.price * quantity;
}

String money(int value) {
  final digits = value.toString();
  final result = StringBuffer();
  for (int i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) result.write(' ');
    result.write(digits[i]);
  }
  return '${result.toString()} ₸';
}
