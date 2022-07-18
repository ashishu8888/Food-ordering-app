import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_ordering_app/admin/services/admin_services.dart';
import 'package:food_ordering_app/constants/Global_variables.dart';
import 'package:food_ordering_app/models/shopDetail.dart';
import 'package:food_ordering_app/providers/shop_provider.dart';
import 'package:food_ordering_app/providers/user_provider.dart';
import 'package:food_ordering_app/screens/category_product_screen.dart';
import 'package:food_ordering_app/widgets/categoryTile.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

class CatgoriesScreen extends StatefulWidget {
  static const routeName = "/categories-screen";
  const CatgoriesScreen({Key? key}) : super(key: key);

  @override
  State<CatgoriesScreen> createState() => _CatgoriesScreenState();
}

class _CatgoriesScreenState extends State<CatgoriesScreen> {
  User? user;
  final AdminServices adminServices = AdminServices();
  Shop? shop;
  List<String>? tags;
  void navigateToCategoryProductScreen(BuildContext context, String category) {
    Navigator.pushNamed(
      context,
      CategoryProductScreen.routeName,
      arguments: category,
    );
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    shop = Provider.of<ShopProvider>(
      context,
    ).shop;
    tags = shop!.tags;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalVariables.selectedNavBarColor,
          title: const Text("Catogries"),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: tags!.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: CategoryTile(
                        category: tags![index],
                        onTap: () {
                          navigateToCategoryProductScreen(
                              context, tags![index]);
                        },
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
