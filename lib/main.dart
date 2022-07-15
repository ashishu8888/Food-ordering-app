import 'package:flutter/material.dart';
import 'package:food_ordering_app/admin/screens/add_product_screen.dart';
import 'package:food_ordering_app/admin/screens/add_shop_screen.dart';
import 'package:food_ordering_app/admin/screens/admin_screen.dart';
import 'package:food_ordering_app/constants/Global_variables.dart';
import 'package:food_ordering_app/providers/shop_provider.dart';
import 'package:food_ordering_app/providers/user_provider.dart';
import 'package:food_ordering_app/screens/auth_screen.dart';
import 'package:food_ordering_app/screens/categories_screen.dart';
import 'package:food_ordering_app/screens/my_orders.dart';
import 'package:food_ordering_app/service/auth_service.dart';
import 'package:food_ordering_app/widgets/bottom_bar.dart';
import 'package:provider/provider.dart';
import 'routers/router.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ShopProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food Ordering App',
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? Provider.of<UserProvider>(context).user.type == 'user'
                ? const BottomBar()
                : const AdminScreen()
            : const AuthScreen(),
        routes: {
          MyOrders.routeName: (ctx) => const MyOrders(),
          CatgoriesScreen.routeName: (ctx) => const CatgoriesScreen(),
          AddProductScreen.routeName: (ctx) => const AddProductScreen(),
          AddShopScreen.routeName: (ctx) => const AddShopScreen(),
        });
  }
}
