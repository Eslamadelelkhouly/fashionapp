class AddCartModel {
  final int product;
  final int quantity;
  final String color;
  final String size;

  AddCartModel({
    required this.product,
    required this.quantity,
    required this.color,
    required this.size,
  });

  factory AddCartModel.fromJson(Map<String, dynamic> json) {
    return AddCartModel(
      product: json['product'],
      quantity: json['quantity'],
      color: json['color'] ?? '',
      size: json['size'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'quantity': quantity,
      'color': color,
      'size': size,
    };
  }
}
