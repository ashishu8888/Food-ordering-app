import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_ordering_app/admin/services/admin_services.dart';
import 'package:food_ordering_app/constants/Global_variables.dart';
import 'package:food_ordering_app/models/shopDetail.dart';
import 'package:food_ordering_app/models/user.dart';
import 'package:food_ordering_app/providers/shop_provider.dart';
import 'package:food_ordering_app/providers/user_provider.dart';
import 'package:food_ordering_app/screens/categories_screen.dart';
import 'package:food_ordering_app/search/search_screen.dart';
import 'package:food_ordering_app/widgets/loader.dart';
import 'package:food_ordering_app/widgets/shop_tile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;
  final AdminServices adminServices = AdminServices();
  List<Shop>? shops;
  List<String> tags = [];
  void initState() {
    // TODO: implement initState
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
    fetchAllShops();
  }

  fetchAllShops() async {
    shops = await adminServices.fetchAllShops(context);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return shops == null
        ? Loader()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                backgroundColor: GlobalVariables.selectedNavBarColor,
                title: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search in canteen...',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: shops!.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ShopTile(
                          ShopImageUrl: shops![index].imageUrl,
                          shopName: shops![index].shopName,
                          avgPrice: shops![index].avgPrice,
                          tags: shops![index].tags,
                          onTap: () {
                            Provider.of<ShopProvider>(context, listen: false)
                                .setShopFromModel(shops![index]);
                            Navigator.of(context)
                                .pushNamed(CatgoriesScreen.routeName);
                          },
                        ),
                      ),
                    )),
                  );
                },
              ),
            ),
          );
  }
}
