import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_ordering_app/constants/Global_variables.dart';
import 'package:food_ordering_app/providers/user_provider.dart';
import 'package:food_ordering_app/service/userServices.dart';
import 'package:food_ordering_app/widgets/cart_product.dart';
import 'package:food_ordering_app/widgets/cart_subTotal.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  UserServices userServices = UserServices();
  placeOrder(double totalSum) {
    userServices.placeOrder(context: context, totalSum: totalSum);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Scaffold(
      backgroundColor: Colors.white54,
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
                onFieldSubmitted: null,
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
      body: Column(
        children: [
          const CartSubTotal(),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 5,
            child: DottedLine(
              direction: Axis.horizontal,
              lineLength: MediaQuery.of(context).size.width * 0.9,
              lineThickness: 1.0,
              dashLength: 4.0,
              dashColor: Colors.black,
              dashGradient: const [Colors.red, Colors.blue],
              dashRadius: 0,
              dashGapLength: 4.0,
              dashGapColor: Colors.transparent,
              dashGapGradient: const [Colors.red, Colors.blue],
              dashGapRadius: 0,
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: user.cart.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child:
                        FadeInAnimation(child: CartProductItem(index: index)),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          placeOrder(sum.toDouble());
        },
        child: Text(
          'Buy(${user.cart.length})',
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: GlobalVariables.selectedNavBarColor,
      ),
    );
  }
}
