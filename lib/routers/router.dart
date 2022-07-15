import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/auth_screen.dart';
import 'package:food_ordering_app/screens/categories_screen.dart';
import 'package:food_ordering_app/screens/home_screen.dart';
import 'package:food_ordering_app/screens/product_screen.dart';
import 'package:food_ordering_app/widgets/bottom_bar.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const AuthScreen();
          });
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) {
            return HomeScreen();
          });
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const BottomBar();
          });
    case CatgoriesScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) {
            return CategoryProductScreen(
              category: category,
            );
          });
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Screen does not exist"),
          ),
        ),
      );
  }
}
