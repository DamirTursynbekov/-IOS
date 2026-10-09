import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sneaker_store/main.dart';
import 'package:sneaker_store/data/products.dart';
import 'package:sneaker_store/screens/detail_screen.dart';

void main() {
  testWidgets('Size required; favorites and cart survive navigation', (tester) async {
    await tester.pumpWidget(const SneakerApp());
    await tester.tap(find.byTooltip('Save favorite').first);
    await tester.pump();
    await tester.ensureVisible(find.text('Velocity Red'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Velocity Red'));
    await tester.pumpAndSettle();
    final button = find.byKey(const ValueKey('addToCart'));
    expect(tester.widget<FilledButton>(button).onPressed, isNull);
    await tester.ensureVisible(find.text('42'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('42'));
    await tester.pump();
    await tester.tap(button);
    await tester.pump();
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cart'));
    await tester.pumpAndSettle();
    expect(find.text('EU 42'), findsOneWidget);
    await tester.tap(find.byTooltip('Increase quantity'));
    await tester.pump();
    expect(find.text('85 800 ₸'), findsNWidgets(2));
    await tester.tap(find.text('Remove'));
    await tester.pump();
    expect(find.textContaining('Your cart is empty'), findsOneWidget);
    await tester.tap(find.text('Favorites'));
    await tester.pump();
    expect(find.text('Velocity Red'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  for (final size in [const Size(320, 568), const Size(390, 844), const Size(1024, 768)]) {
    for (final scale in [1.0, 1.5]) {
      testWidgets('Detail layout $size text $scale', (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)), child: child!),
          home: DetailScreen(product: products.first, saved: false,
            onFavorite: () {}, onAdd: (_) {})));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await tester.ensureVisible(find.text('44'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.byKey(const ValueKey('addToCart')).hitTestable(), findsOneWidget);
      });
    }
    testWidgets('Catalogue layout $size', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const SneakerApp());
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}
