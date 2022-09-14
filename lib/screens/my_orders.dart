import 'package:flutter/material.dart';
import 'package:food_ordering_app/constants/Global_variables.dart';

class MyOrders extends StatelessWidget {
  static const String routeName = '/my-orders';
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: GlobalVariables.selectedNavBarColor,
          title: const Text('Your Orders')),
      body: Container(),
    );
  }
}
