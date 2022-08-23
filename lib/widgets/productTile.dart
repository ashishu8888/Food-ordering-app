import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_ordering_app/models/product.dart';
import 'package:food_ordering_app/service/product_services.dart';
import 'package:food_ordering_app/service/userServices.dart';
import 'package:food_ordering_app/widgets/stars.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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
      children: [
        Container(
          //color: Colors.blue,
          padding: EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.product.images[0],
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 12.0),
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
              onPressed: () {
                show_Dialog(context);
              },
              icon: const Icon(Icons.shopping_cart),
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(10)),
          width: 150,
          margin: EdgeInsets.all(2),
          padding: const EdgeInsets.all(4),
          child: RatingBar.builder(
            itemSize: 20,
            initialRating: avgRating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemPadding: const EdgeInsets.only(top: 2, bottom: 2, left: 7),
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
        SizedBox(
          height: 10,
        ),
        Container(
          //color: Colors.amber,
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            "₹ ${widget.product.price.toString()}",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  show_Dialog(context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Are you Sure?',
      desc: 'This item will be added to your Cart!',
      btnCancelOnPress: () {},
      btnOkOnPress: addToCart,
    )..show();
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
