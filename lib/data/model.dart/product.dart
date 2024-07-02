import 'package:shop_bag_app/screens/products_listing.dart';

class Product {
  final String name;
  final int price;
  final String image;
  final String brand;
  final String size;
  final String color;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.brand,
    required this.size,
    required this.color,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json['name'] as String,
        price: json['price'] as int,
        image: json['image'] as String,
        brand: json['brand'] as String,
        size: json['size'] as String,
        color: json['color'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'image': image,
        'brand': brand,
        'size': size,
        'color': color,
      };

  ProductItem toProductItem() {
    return ProductItem(
      brand: brand,
      itemTitle: name, // Assuming itemTitle is the same as name
      availableColors: color, // Assuming availableColors is a single color
      size: size, localAsset: image,
    );
  }

  bool isEqual(Product product) =>
      name == product.name &&
      brand == product.name &&
      color == product.color &&
      product.image == image &&
      product.price == price;

  @override
  String toString() {
    return '${toJson()}';
  }
}
