import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/auth_screen.dart';
import 'package:food_ordering_app/screens/home_screen.dart';
import 'package:food_ordering_app/widgets/bottom_bar.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) {
        return const AuthScreen();
      });
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) {
        return HomeScreen();
      });
    case BottomBar.routeName:
      return MaterialPageRoute(builder: (_) {
        return const BottomBar();
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
