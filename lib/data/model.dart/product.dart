import 'package:shop_bag_app/secrets/secret_constants.dart';
import 'package:shop_bag_app/utils/extensions.dart';

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
        category = (cat['name'] as String).cleanText.capitalize;
      }
    }

    // Extracting price
    double price = json['current_price'].isNotEmpty &&
            json['current_price'][0]['NGN'] != null &&
            json['current_price'][0]['NGN'][0] != null
        ? json['current_price'][0]['NGN'][0].toDouble()
        : 0.0;

    return Product(
      id: json['id'],
      name: (json['name'] as String).cleanText,
      description: json['description'],
      isAvailable: json['is_available'],
      imageUrl: imageUrl,
      rating: rating,
      category: category,
      price: price,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.isAvailable == isAvailable &&
        other.imageUrl == imageUrl &&
        other.rating == rating &&
        other.category == category &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        isAvailable.hashCode ^
        imageUrl.hashCode ^
        rating.hashCode ^
        category.hashCode ^
        price.hashCode;
  }
}
