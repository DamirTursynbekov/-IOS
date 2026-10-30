import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'screens/cart_screen.dart';
import 'screens/store_screen.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
        child: const SneakerApp(),
      ),
    );

class SneakerApp extends StatefulWidget {
  const SneakerApp({super.key});

  @override
  State<SneakerApp> createState() => _SneakerAppState();
}

class _SneakerAppState extends State<SneakerApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    StoreScreen(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Catalog App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF476A36)),
        scaffoldBackgroundColor: const Color(0xFFF7F7F2),
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) => setState(() => _currentIndex = index),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.store), label: 'Catalog'),
            NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          ],
        ),
      ),
    );
  }
}
