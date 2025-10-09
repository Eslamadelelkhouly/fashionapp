import 'dart:convert';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  final int id;
  final String title;
  final double price;
  final String description;
  final bool isFeatured;
  final String clothesType;
  final double ratings;
  final List<String> colors;
  final List<String> imageUrls;
  final List<String> sizes;
  final DateTime createdAt;
  final int category;
  final int brand;

  Products({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.isFeatured,
    required this.clothesType,
    required this.ratings,
    required this.colors,
    required this.imageUrls,
    required this.sizes,
    required this.createdAt,
    required this.category,
    required this.brand,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble() ?? 0.0,
        description: json["description"] ?? "",
        isFeatured: json["is_featured"] ?? false,
        clothesType: json["clothesType"] ?? "",
        ratings: json["ratings"]?.toDouble() ?? 0.0,
        colors: json["colors"] == null
            ? []
            : List<String>.from(json["colors"].map((x) => x)),
        imageUrls: json["imageUrl"] == null
            ? []
            : List<String>.from(json["imageUrl"].map((x) => x)),
        sizes: json["sizes"] == null
            ? []
            : List<String>.from(json["sizes"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        category: json["category"] ?? 0, // default 0
        brand: json["brand"] ?? 0, // default 0
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "is_featured": isFeatured,
        "clothesType": clothesType,
        "ratings": ratings,
        "colors": List<dynamic>.from(colors.map((x) => x)),
        "imageUrl": List<dynamic>.from(imageUrls.map((x) => x)),
        "sizes": List<dynamic>.from(sizes.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "category": category,
        "brand": brand,
      };
}
