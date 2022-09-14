import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/tag_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ShopTile extends StatelessWidget {
  final List<String> ShopImageUrl;
  final String shopName;
  final double avgPrice;
  final List<String> tags;
  final VoidCallback onTap;
  const ShopTile({
    Key? key,
    required this.ShopImageUrl,
    required this.shopName,
    required this.avgPrice,
    required this.tags,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 280,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white70,
          ),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: CarouselSlider(
                      options: CarouselOptions(height: 150),
                      items: ShopImageUrl.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Image.network(
                                  i,
                                  fit: BoxFit.fitWidth,
                                ));
                          },
                        );
                      }).toList(),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  shopName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Average Price',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w400),
                    ),
                    const Spacer(),
                    Text(
                      avgPrice.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 30,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: tags.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return TagTile(
                          tagName: tags[index],
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
