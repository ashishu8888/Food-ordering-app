import 'package:flutter/material.dart';

class ShopTile extends StatelessWidget {
  final String imageUrl;
  final String shopName;
  final double avgPrice;
  final List<String> tags;
  const ShopTile({
    Key? key,
    required this.imageUrl,
    required this.shopName,
    required this.avgPrice,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        children: [
          Row(
            children: [
              Image.network(imageUrl),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                shopName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                '$avgPrice',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Column(
              children: [
                ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tags.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(width: 3.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Center(
                          child: Text(
                            tags[index],
                          ),
                        ),
                      );
                    })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
