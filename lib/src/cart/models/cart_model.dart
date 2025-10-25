import 'package:fashionapp/src/product/models/product_model.dart';

class CartModel {
  final int id;
  final Products product;
  final int quantity;
  final String size;
  final String color;

  CartModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.size,
    required this.color,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      product: Products.fromJson(json['product']), // ✅ استخدم Products
      quantity: json['quantity'],
      size: json['size'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
      'size': size,
      'color': color,
    };
  }
}
