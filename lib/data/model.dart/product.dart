import 'package:shop_bag_app/secrets/secret_constants.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json['name'] as String,
        price: json['available_quantity'] as double,
        image: '$imageBaseUrl/${json['photos'][0]['url'] as String}',
        id: json['id'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'image': image,
        'available_quantity': price,
        'description': description,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        name == other.name &&
        description == other.description &&
        id == other.id &&
        other.image == image &&
        other.price == price;
  }

  @override
  String toString() {
    return '${toJson()}';
  }

  @override
  int get hashCode => name.hashCode;
}
