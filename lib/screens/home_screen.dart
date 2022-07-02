import 'package:flutter/material.dart';
import 'package:food_ordering_app/providers/user_provider.dart';
import 'package:food_ordering_app/screens/auth_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Food Order'),
        ),
        body: Center(
          child: Text(user.toJson()),
        ));
  }
}
