import 'package:flutter/material.dart';
import 'package:food_ordering_app/constants/Global_variables.dart';
import 'package:food_ordering_app/models/order.dart';
import 'package:food_ordering_app/search/search_screen.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatefulWidget {
  static const routeName = '/order-detail-screen';
  final Order order;
  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'View order details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Date:        ${DateFormat().format(
                    DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt),
                  )}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('orderId :              ${widget.order.id}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Total amount :    ₹ ${widget.order.totalPrice}'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'View order details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < widget.order.products.length; i++)
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.order.products[i].name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'x ${widget.order.quantity[i]}',
                            ),
                          ],
                        ))
                      ],
                    )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Tracking',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Stepper(
                elevation: 10,
                currentStep: currentStep,
                physics: BouncingScrollPhysics(),
                controlsBuilder: (context, detail) {
                  return const SizedBox();
                },
                steps: [
                  Step(
                    title: Text('Pending order request'),
                    content: Text(
                        'Your order request has been sent to seller and is yet to be confirmed.'),
                    isActive: currentStep >= 0,
                    state: currentStep >= 0
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: Text('order request has been accepted'),
                    content: Text('seller has accepted your order.'),
                    isActive: currentStep >= 1,
                    state: currentStep >= 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: Text('in progress'),
                    content: Text('your order is being prepared'),
                    isActive: currentStep >= 2,
                    state: currentStep >= 2
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: Text('Ready'),
                    content: Text('your order is ready to take'),
                    isActive: currentStep >= 3,
                    state: currentStep >= 3
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
