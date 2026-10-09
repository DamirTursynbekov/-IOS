import '../models/product.dart';

// Fictional demo catalogue. Photos are illustrative, not verified listings.
const products = <Product>[
  Product(id: 'red', name: 'Velocity Red', category: 'Running',
    image: 'assets/images/shoe_0.jpg', price: 42900, rating: 4.8,
    description: 'Bring energy to your daily routine. A lightweight upper and a cushioned sole offer a comfortable feel for your everyday runs.'),
  Product(id: 'cloud', name: 'Cloud Everyday', category: 'Lifestyle',
    image: 'assets/images/shoe_1.jpg', price: 38900, rating: 4.7,
    description: 'A versatile everyday sneaker for campus, city walks and weekend plans. A clean silhouette makes it easy to pair with your wardrobe.'),
  Product(id: 'court', name: 'Court Essential', category: 'Lifestyle',
    image: 'assets/images/shoe_2.jpg', price: 35900, rating: 4.9,
    description: 'Classic court-inspired style with a comfortable padded collar. Designed as an easy addition to your everyday rotation.'),
  Product(id: 'move', name: 'Urban Move', category: 'Training',
    image: 'assets/images/shoe_3.jpg', price: 46900, rating: 4.6,
    description: 'An athletic look for active days. A supportive feel and flexible construction make this a practical choice for your daily movement.'),
];
