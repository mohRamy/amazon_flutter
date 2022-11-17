import 'dart:convert';

import 'product_model.dart';
import 'rating_model.dart';

class CartModel {
  String? id;
  int? price;
  String? image;
  String? name;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel? product;
  List<RatingModel>? rating;

  CartModel({
    this.id,
    this.price,
    this.image,
    this.name,
    this.quantity,
    this.isExist,
    this.time,
    this.product,
    this.rating,
  });

  // CartModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   price = json['price'];
  //   image = json['image'];
  //   name = json['name'];
  //   quantity = json['quantity'];
  //   isExist = json['isExist'];
  //   time = json['time'];
  //   product = ProductModel.fromJson(json['product']);
  //   rating = json['ratings'] != null
  //           ? List<RatingModel>.from(
  //               json['ratings']?.map(
  //                 (x) => RatingModel.fromMap(x),
  //               ),
  //             )
  //           : null;
  // }
  
  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "name": name,
  //       "price": price,
  //       "image": image,
  //       "quantity": quantity,
  //       "isExist": isExist,
  //       "time": time,
  //       "product": product!.toJson(),
  //       "ratings": rating,
  //     };

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'image': image,
      'name': name,
      'quantity': quantity,
      'isExist': isExist,
      'time': time,
      'product': product?.toMap(),
      'rating': rating?.map((x) => x.toMap()).toList(),
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'],
      price: map['price'],
      image: map['image'],
      name: map['name'],
      quantity: map['quantity']?.toInt(),
      isExist: map['isExist'],
      time: map['time'],
      product: map['product'] != null ? ProductModel.fromMap(map['product']) : null,
      rating: map['rating'] != null
            ? List<RatingModel>.from(
                map['rating']?.map(
                  (x) => RatingModel.fromMap(x),
                ),
              )
            : null
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) => CartModel.fromMap(json.decode(source));
}
