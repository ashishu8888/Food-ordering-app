import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/order.dart';
import 'package:food_ordering_app/models/product.dart';
import 'package:food_ordering_app/service/account_services.dart';

class SingleProduct extends StatefulWidget {
  final Product order;
  const SingleProduct({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(10),
          child: Image.network(
            widget.order.images[0],
            fit: BoxFit.fitHeight,
            width: 180,
          ),
        ),
      ),
    );
  }
}
