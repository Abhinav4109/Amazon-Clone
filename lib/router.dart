import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/screens/product_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/catogery_deals_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/product_detail/screens/product_detail_screen.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/main.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case HomePage.routeName:
      return MaterialPageRoute(builder: (_) => const HomePage());
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(builder: (_) => const BottomBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddProductScreen());
    case ProductScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ProductScreen());
    case CatogeryDealsScreen.routeName:
      final catogery = settings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => CatogeryDealsScreen(catogery: catogery));
    case SearchScreen.routeName:
      final searchQuery = settings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => SearchScreen(searchQuery: searchQuery));
    case ProductDetailScreen.routeName:
      final product = settings.arguments as Product;
      return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product));
    default:
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text('Default Page'))),
      );
  }
}
