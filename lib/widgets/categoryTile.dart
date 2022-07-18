import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/product.dart';
import 'package:food_ordering_app/providers/shop_provider.dart';
import 'package:food_ordering_app/service/userServices.dart';
import 'package:provider/provider.dart';

class CategoryTile extends StatefulWidget {
  final String category;
  final VoidCallback onTap;
  CategoryTile({Key? key, required this.category, required this.onTap})
      : super(key: key);

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  List<Product>? productList;

  UserServices homeServices = UserServices();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchCategoryProduct();
  }

  fetchCategoryProduct() async {
    var shop = Provider.of<ShopProvider>(context).shop;
    productList = await homeServices.fetchCategoryProduct(
      context: context,
      category: widget.category,
    );
    productList!
        .removeWhere((productCat) => (productCat.whichShop != shop.shopName));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          padding: const EdgeInsets.all(20.0),
          height: 150,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: productList == null || productList!.isEmpty
                      ? const Text('not available')
                      : Image.network(
                          productList![0].images[0],
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent
                      ])),
                ),
              )
            ],
          )),
    );
  }
}
