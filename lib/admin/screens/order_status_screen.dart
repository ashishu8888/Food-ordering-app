import 'package:flutter/material.dart';
import 'package:food_ordering_app/admin/services/admin_services.dart';
import 'package:food_ordering_app/models/order.dart';
import 'package:food_ordering_app/screens/order_detail_screen.dart';
import 'package:food_ordering_app/widgets/loader.dart';
import 'package:food_ordering_app/widgets/single_widget.dart';
import 'package:intl/intl.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({Key? key}) : super(key: key);

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  List<Order>? order;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    order = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return order == null
        ? const Loader()
        : GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: order!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final orderData = order![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailScreen.routeName,
                      arguments: orderData);
                },
                child: Card(
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    height: 140,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total: ${orderData.totalPrice}',
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Order Date: ${DateFormat().format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  orderData.orderedAt),
                            )}',
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: orderData.products.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                          'Item : ${orderData.products[index].name} x ${orderData.quantity[index]}'),
                                    )
                                  ],
                                );
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
  }
}
