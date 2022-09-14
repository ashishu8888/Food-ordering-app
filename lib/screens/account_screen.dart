import 'package:flutter/material.dart';
import 'package:food_ordering_app/constants/Global_variables.dart';
import 'package:food_ordering_app/constants/utils.dart';
import 'package:food_ordering_app/models/order.dart';
import 'package:food_ordering_app/providers/user_provider.dart';
import 'package:food_ordering_app/screens/auth_screen.dart';
import 'package:food_ordering_app/screens/my_orders.dart';
import 'package:food_ordering_app/screens/order_detail_screen.dart';
import 'package:food_ordering_app/service/account_services.dart';
import 'package:food_ordering_app/widgets/accounts_tile.dart';
import 'package:food_ordering_app/widgets/loader.dart';
import 'package:food_ordering_app/widgets/single_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<Order>? orders;
  AccountServices accountServices = AccountServices();

  fetchUserOrder() async {
    orders = await accountServices.fetchMyOrders(context: context);
    orders!.reversed;
    setState(() {});
  }

  void logOut(BuildContext context) async {
    accountServices.logOut(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserOrder();
  }
  // List orders = [
  //   "https://images.unsplash.com/photo-1656859617812-1f8a93f77f60?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1964&q=80",
  //   "https://images.unsplash.com/photo-1656861085999-75a6a0402c29?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
  //   "https://images.unsplash.com/photo-1656840953401-3db0c4c34564?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
  //   "https://images.unsplash.com/photo-1656848221842-974d8be992ca?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1112&q=80",
  //   "https://images.unsplash.com/photo-1656850289052-75bf261340e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80",
  //   "https://images.unsplash.com/photo-1656796050205-34817aad7d50?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
  //   "https://images.unsplash.com/photo-1656796050347-7acb13f4b08c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
  // ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: GlobalVariables.selectedNavBarColor,
          title: Row(
            children: [
              const Text(
                'Hello, ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${user.name}',
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AccountTile(
                name: 'My orders',
                iconType: const Icon(Icons.shop),
                onTap: () {
                  Navigator.of(context).pushNamed(MyOrders.routeName);
                }),
            AccountTile(
                name: 'My WishList',
                iconType: const Icon(Icons.list_alt),
                onTap: () {
                  Navigator.of(context).pushNamed(MyOrders.routeName);
                }),
            AccountTile(
                name: 'Settings',
                iconType: const Icon(Icons.settings),
                onTap: () {
                  Navigator.of(context).pushNamed(MyOrders.routeName);
                }),
            AccountTile(
                name: 'Log out',
                iconType: const Icon(Icons.logout),
                onTap: () {
                  logOut(context);
                }),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Your orders',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ("see all"),
                      style:
                          TextStyle(color: GlobalVariables.selectedNavBarColor),
                    ),
                  ),
                )
              ],
            ),
            orders == null
                ? const Loader()
                : Container(
                    height: 150,
                    padding: EdgeInsets.only(left: 10, top: 20, right: 0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: orders!.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, OrderDetailScreen.routeName,
                                  arguments: orders![index]);
                            },
                            child: SingleProduct(
                                order: orders![index].products[0]));
                      }),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
