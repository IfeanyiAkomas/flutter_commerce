import 'dart:convert';

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;
  final int ratingCount;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.ratingCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final rating = json['rating'] ?? {};
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: (rating['rate'] as num?)?.toDouble() ?? 0.0,
      ratingCount: (rating['count'] as int?) ?? 0,
    );
  }

  static List<Product> fromJsonList(String jsonStr) {
    final List data = json.decode(jsonStr);
    return data.map((e) => Product.fromJson(e)).toList();
  }
}
