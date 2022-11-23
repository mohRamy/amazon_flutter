import 'dart:convert';

import 'rating_model.dart';

class ProductModel {
  final String? id;
  final String name;
  final String description;
  final int quantity;
  final List<String> images;
  final String category;
  final int price;
  final int oldPrice;
  final List<RatingModel>? rating;
  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    required this.oldPrice,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'oldPrice': oldPrice,
      'id': id,
      'rating': rating,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        quantity: map['quantity'],
        images: List<String>.from(map['images']),
        category: map['category'] ?? '',
        price: map['price']?? 0,
        oldPrice: map['oldPrice']?? 0,
        id: map['_id'],
        rating: map['ratings'] != null
            ? List<RatingModel>.from(
                map['ratings']?.map(
                  (x) => RatingModel.fromMap(x),
                ),
              )
            : null);
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
