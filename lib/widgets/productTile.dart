import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_ordering_app/models/product.dart';
import 'package:food_ordering_app/service/product_services.dart';
import 'package:food_ordering_app/widgets/stars.dart';

class ProductTile extends StatelessWidget {
  final ProductServices productServices = ProductServices();
  final Product product;
  ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    double avgRating = 0;

    if (product.rating != null) {
      for (int i = 0; i < product.rating!.length; i++) {
        totalRating += product.rating![i].rating;
      }

      if (totalRating != 0) {
        avgRating = totalRating / product.rating!.length;
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
                      product.images[0],
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                // Container(
                //   child: item.fav
                //       ? Icon(
                //           Icons.favorite,
                //           size: 20.0,
                //           color: Colors.red,
                //         )
                //       : Icon(
                //           Icons.favorite_border,
                //           size: 20.0,
                //         ),
                // )
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
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                "${product.name}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))
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
                  context: context, product: product, rating: rating);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  "₹ ${product.price.toString()}",
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
