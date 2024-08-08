import 'dart:convert';

import 'package:amazon_clone/models/rating.dart';

class Product {
  final String productName;
  final String discription;
  final int price;
  final int quantity;
  final String category;
  final String? id;
  final List<String> images;
  final List<Rating>? rating;

  Product(
      {required this.productName,
      required this.discription,
      required this.price,
      required this.quantity,
      required this.category,
      required this.images,
      this.id,
      this.rating});

  Map<String, dynamic> toMap() {
    return {
      'name': productName,
      'description': discription,
      'quantity': quantity,
      'images': images,
      'category': category,
      'id': id,
      'price': price,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productName: map['name'] ?? '',
      discription: map['description'] ?? '',
      quantity: map['quantity'] ?? 0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      id: map['_id'],
      price: map['price'] ?? 0,
      rating: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
