import 'package:flutter/material.dart';
import 'screens/store_screen.dart';

void main() => runApp(const SneakerApp());

class SneakerApp extends StatelessWidget {
  const SneakerApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Sneaker Store', debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF476A36)),
      scaffoldBackgroundColor: const Color(0xFFF7F7F2),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFF7F7F2),
        foregroundColor: Color(0xFF182018), elevation: 0),
      filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFF182018), foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)))),
    ),
    home: const StoreScreen(),
  );
}
