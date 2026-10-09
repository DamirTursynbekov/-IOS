# Sneaker Store
Flutter coursework: LAB 5 + Capstone Milestone 1.

## Concept
A shopping app for students and young adults to browse sneakers, compare prices, save favorites and choose sizes. This MVP uses a fictional local catalogue.

## Features
- Four products with offline photos, prices in KZT and demo ratings.
- Search, category filters and empty states.
- Adaptive catalogue with one, two or three columns.
- Detail screen: Stack cover/bookmark, rating, price, Wrap tags and EU sizes.
- Sticky Add to Cart using Row > Expanded; size selection is required.
- Favorites synchronized between catalogue and details.
- Cart grouped by product + size, quantity controls, removal and total.
- Navigator.push with Product; back navigation preserves shopping state.
- StatefulWidget + setState; no third-party packages.

## Setup
Install Flutter stable (Dart >=3.4), Android SDK and VS Code Flutter extension. This source kit does not include generated platform folders or an APK. Open this folder and run:

```sh
flutter doctor
flutter create --platforms=android,web --project-name sneaker_store .
flutter pub get
dart format lib test
flutter analyze
flutter test
flutter run
```

The dot scaffolds the platform folders here. Keep the supplied lib, test, assets and pubspec.yaml if asked about overwriting. For Chrome: `flutter run -d chrome`.

## Structure
- lib/main.dart: entry point and theme.
- lib/models/product.dart: Product, CartItem, currency formatting.
- lib/data/products.dart: fictional sample products.
- lib/screens/store_screen.dart: navigation and shared state.
- lib/screens/detail_screen.dart: details and size selection.
- lib/screens/cart_screen.dart: quantities and totals.
- lib/widgets/product_card.dart: reusable card.
- assets/images/: bundled photos.
- test/widget_test.dart: interaction and layout tests.
- START_HERE_RU.md: Russian setup instructions.
- DEFENSE.md: defense script and explanations.

## Requirements
| Requirement | Implementation |
|---|---|
| Stack cover + bookmark | ProductCard, DetailScreen |
| Title, rating, price with Row/Wrap | DetailScreen |
| Category badges | Wrap + Chip |
| Sticky full-width button | bottomNavigationBar > Row > Expanded |
| Column, Row, Card | StoreScreen, ProductCard |
| At least two screens | Catalogue and detail; extra favorites/cart views |
| StatefulWidget + setState | StoreScreen, DetailScreen |
| Clean architecture | screens, widgets, models, data |
| Adaptivity | LayoutBuilder, Expanded, Wrap, scrolling, natural card heights |

## Validation status
Flutter and Dart SDKs were unavailable in the preparation environment. A build, analyzer, widget tests and emulator visual review have NOT been run. Execute the commands above before submission. Included layout tests cover 320×568, 390×844 and 1024×768; detail tests also cover 1.5× text. Manually check all tabs, landscape and keyboard. Do not claim zero overflow until checks pass.

## Scope
Selections survive navigation but reset on full restart. No API, database, login, checkout or real payment yet. Names, ratings, prices and descriptions are fictional; photos are illustrative. Later milestones will add APIs, persistence and BLoC.

## Image sources
Bundled Unsplash photographs:
- https://images.unsplash.com/photo-1542291026-7eec264c27ff
- https://images.unsplash.com/photo-1600185365483-26d7a4cc7519
- https://images.unsplash.com/photo-1600269452121-4f2416e55c28
- https://images.unsplash.com/photo-1549298916-b41d501d3772

The fictional product names do not identify the photographed shoe models. This is an educational prototype.

## Framework references
https://docs.flutter.dev/ui/layout/constraints
https://api.flutter.dev/flutter/widgets/Wrap-class.html

## GitHub
Create an empty repository in your account. After local validation:

```sh
git init
git add .
git commit -m "Build Sneaker Store Milestone 1"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/sneaker_store.git
git push -u origin main
```

Replace YOUR_USERNAME. Submit the repository link and add actual running-app screenshots to this README.
