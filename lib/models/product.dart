import 'dart:convert';

class Product {
  final String productName;
  final String discription;
  final double price;
  final double quantity;
  final String category;
  final List<String> images;

  Product(
      {required this.productName,
      required this.discription,
      required this.price,
      required this.quantity,
      required this.category,
      required this.images});

  Map<String, dynamic> toMap() {
    return {
      'name': productName,
      'description': discription,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productName: map['name'] ?? '',
      discription: map['description'] ?? '',
      quantity: map['quantity'] ?? 0.0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      price: map['price'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
