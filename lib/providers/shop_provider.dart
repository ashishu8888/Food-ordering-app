import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/shopDetail.dart';

class ShopProvider extends ChangeNotifier {
  Shop _shop = Shop(
    id: '',
    avgPrice: 0,
    tags: [],
    imageUrl: [],
    shopName: '',
    ownerName: '',
  );

  Shop get shop => _shop;

  void setShop(String shop) {
    _shop = Shop.fromJson(shop);
    notifyListeners();
  }

  void setShopFromModel(Shop shop) {
    _shop = shop;
    notifyListeners();
  }
}
