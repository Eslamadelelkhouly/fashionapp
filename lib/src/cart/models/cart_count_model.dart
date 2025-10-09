class CartCountModel {
  final int cartCount;

  CartCountModel({required this.cartCount});

  factory CartCountModel.fromJson(Map<String, dynamic> json) {
    return CartCountModel(
      cartCount: json['cart_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cart_count': cartCount,
    };
  }
}
