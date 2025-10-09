class CartModel {
  final ProductModel product;

  CartModel({
    required this.product,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      product: ProductModel.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
    };
  }
}

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final bool isFeatured;
  final String clothesType;
  final double ratings;
  final List<String> sizes;
  final List<String> colors;
  final List<String> imageUrl;
  final String createdAt;
  final int category;
  final int brand;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.isFeatured,
    required this.clothesType,
    required this.ratings,
    required this.sizes,
    required this.colors,
    required this.imageUrl,
    required this.createdAt,
    required this.category,
    required this.brand,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      isFeatured: json['is_featured'],
      clothesType: json['clothesType'],
      ratings: (json['ratings'] as num).toDouble(),
      sizes: List<String>.from(json['sizes']),
      colors: List<String>.from(json['colors']),
      imageUrl: List<String>.from(json['imageUrl']),
      createdAt: json['created_at'],
      category: json['category'],
      brand: json['brand'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'is_featured': isFeatured,
      'clothesType': clothesType,
      'ratings': ratings,
      'sizes': sizes,
      'colors': colors,
      'imageUrl': imageUrl,
      'created_at': createdAt,
      'category': category,
      'brand': brand,
    };
  }
}
