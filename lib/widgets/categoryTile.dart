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
                  child: productList == null || productList!.length == 0
                      ? Image.network(
                          'https://cdn.dribbble.com/users/856748/screenshots/3378756/media/2567526420085dc9c835c2cd8a52bffc.gif',
                          fit: BoxFit.contain,
                        )
                      : Image.network(
                          productList![0].images[0],
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  height: 120,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.category,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
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
