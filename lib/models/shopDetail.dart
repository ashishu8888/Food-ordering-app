import 'dart:convert';

class Shop {
  String? id;
  String ownerName;
  String shopName;
  double avgPrice;
  List<String> imageUrl;
  List<String> tags;

  Shop(
      {this.id,
      required this.ownerName,
      required this.shopName,
      required this.avgPrice,
      required this.imageUrl,
      required this.tags});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerName': ownerName,
      'shopName': shopName,
      'avgPrice': avgPrice,
      'imageUrl': imageUrl,
      'tags': tags,
    };
  }

  factory Shop.fromMap(Map<String, dynamic> map) {
    return Shop(
      id: map['_id'] ?? '',
      ownerName: map['ownerName'] ?? '',
      shopName: map['shopName'] ?? '',
      avgPrice: map['avgPrice']?.toDouble() ?? 0.0,
      imageUrl: List<String>.from(map['imageUrl']),
      tags: List<String>.from(map['tags']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Shop.fromJson(String source) => Shop.fromMap(json.decode(source));
}
