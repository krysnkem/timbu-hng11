import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:shop_bag_app/secrets/secret_constants.dart';
import 'package:shop_bag_app/utils/extensions.dart';

part 'product.g.dart';

@HiveType(typeId: 1)
class Product extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final bool isAvailable;
  @HiveField(4)
  final String imageUrl;
  @HiveField(5)
  final String rating;
  @HiveField(6)
  final String category;
  @HiveField(7)
  final double price;

  const Product({
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isAvailable': isAvailable,
      'imageUrl': imageUrl,
      'rating': rating,
      'category': category,
      'price': price,
    };
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    bool? isAvailable,
    String? imageUrl,
    String? rating,
    String? category,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isAvailable: isAvailable ?? this.isAvailable,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      category: category ?? this.category,
      price: price ?? this.price,
    );
  }

  @override
  String toString() {
    return '${toJson()}';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        isAvailable,
        imageUrl,
        rating,
        category,
        price,
      ];
}
