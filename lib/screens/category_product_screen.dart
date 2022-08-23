import 'package:flutter/material.dart';
import 'package:food_ordering_app/constants/Global_variables.dart';
import 'package:food_ordering_app/models/product.dart';
import 'package:food_ordering_app/providers/shop_provider.dart';
import 'package:food_ordering_app/service/product_services.dart';
import 'package:food_ordering_app/service/userServices.dart';
import 'package:food_ordering_app/widgets/loader.dart';
import 'package:food_ordering_app/widgets/productTile.dart';
import 'package:provider/provider.dart';

class CategoryProductScreen extends StatefulWidget {
  static const routeName = "/category_product-screen";
  final String category;
  const CategoryProductScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<CategoryProductScreen> {
  List<Product>? productList;
  UserServices homeServices = UserServices();

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchCategoryProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.selectedNavBarColor,
        title: Text(widget.category),
      ),
      body: productList == null
          ? const Loader()
          : GridView.builder(
              itemCount: productList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //maxCrossAxisExtent: 200,
                crossAxisCount: 2,
                childAspectRatio: 2 / 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) =>
                  ProductTile(product: productList![index]),
            ),
    );
  }
}
