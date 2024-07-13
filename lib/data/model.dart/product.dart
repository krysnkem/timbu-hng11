import 'package:shop_bag_app/secrets/secret_constants.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final bool isAvailable;
  final String imageUrl;
  final String rating;
  final String category;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.isAvailable,
    required this.imageUrl,
    required this.rating,
    required this.category,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Extracting imageUrl
    String imageUrl = json['photos'].isNotEmpty
        ? '$imageBaseUrl/${json['photos'][0]['url']}'
        : '';

    // Extracting category and rating
    String rating = '';
    String category = '';
    for (var cat in json['categories']) {
      if (int.tryParse(cat['name']) != null) {
        rating = cat['name'];
      } else {
        category = cat['name'];
      }
    }

    // Extracting price
    double price = json['current_price'].isNotEmpty && json['current_price'][0]['NGN'] != null && json['current_price'][0]['NGN'][0] != null
        ? json['current_price'][0]['NGN'][0].toDouble()
        : 0.0;

    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isAvailable: json['is_available'],
      imageUrl: imageUrl,
      rating: rating,
      category: category,
      price: price,
    );
  }
}
