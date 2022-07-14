import 'package:flutter/material.dart';
import 'package:food_ordering_app/constants/Global_variables.dart';

class CatgoriesScreen extends StatelessWidget {
  static const String routeName = "/categories-screen";
  const CatgoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.selectedNavBarColor,
        title: const Text("Catogries"),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              child: const Card(
                child: Text(
                  'category 1',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {},
            child: const Card(
              child: Text(
                'category 2',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {},
            child: const Card(
              child: Text(
                'category 3',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {},
            child: const Card(
              child: Text(
                'category 4',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
