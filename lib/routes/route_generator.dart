import 'package:flutter/material.dart';
import 'package:platzi_store/auth/loginScreen.dart';
import 'package:platzi_store/details/item_details.dart';
import 'package:platzi_store/home/screen/cart_screen.dart';
import 'package:platzi_store/home/screen/homeScreen.dart';
import 'package:platzi_store/home/screen/wishlist_screen.dart';
import 'package:platzi_store/routes/route_name.dart';
import 'package:platzi_store/update/update_screen.dart';

class RouteGenerator {
  RouteGenerator._();
  static Route<dynamic>? generateRouter(RouteSettings settings) {
    Object? arguments = settings.arguments;
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());
      case Routes.detailsScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => ItemDetailsScreen(id: arguments as int));
      case Routes.updateScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => ProductUpdateScreen(id: arguments as int));
      case Routes.wishlistScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const WishlistScreen());
      case Routes.cartScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CartScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const LoginScreen());
    }
  }
}
