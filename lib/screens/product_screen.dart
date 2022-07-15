import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryProductScreen extends StatefulWidget {
  static const routeName = "/product-screen";
  final String category;
  const CategoryProductScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<CategoryProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
    );
  }
}
