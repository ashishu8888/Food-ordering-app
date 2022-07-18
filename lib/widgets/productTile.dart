import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_ordering_app/models/product.dart';
import 'package:food_ordering_app/service/product_services.dart';
import 'package:food_ordering_app/service/userServices.dart';
import 'package:food_ordering_app/widgets/stars.dart';

class ProductTile extends StatefulWidget {
  final Product product;
  ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  final ProductServices productServices = ProductServices();
  final UserServices userServices = UserServices();
  void addToCart() {
    userServices.addToCart(
      context: context,
      product: widget.product,
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    double avgRating = 0;

    if (widget.product.rating != null) {
      for (int i = 0; i < widget.product.rating!.length; i++) {
        totalRating += widget.product.rating![i].rating;
      }

      if (totalRating != 0) {
        avgRating = totalRating / widget.product.rating!.length;
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 120.0,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Image.network(
                      widget.product.images[0],
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "${widget.product.name}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              onPressed: addToCart,
              icon: const Icon(Icons.shopping_cart),
            )
          ],
        ),
        Container(
          width: 235,
          padding: const EdgeInsets.all(8),
          child: RatingBar.builder(
            itemSize: 20,
            initialRating: avgRating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemPadding: const EdgeInsets.all(2),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            onRatingUpdate: (rating) {
              productServices.rateProduct(
                  context: context, product: widget.product, rating: rating);
              setState(() {});
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  "₹ ${widget.product.price.toString()}",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}



/*
ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: Image.network(
          product.images[0],
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          title: Text(
            product.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
          trailing: IconButton(
            onPressed: () {},
            iconSize: 20,
            icon: const Icon(Icons.shopping_cart),
          ),
        ),
      ),
    );
  }
}
*/
