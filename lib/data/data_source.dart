import 'package:shop_bag_app/data/model.dart/product.dart';

const allProductsDataSource = [
  {
    "name": "Casual Corporate Outfit 1",
    "price": 8500,
    "image": "casual-coprate#1.jpg",
    "brand": "H&M",
    "size": "L",
    "color": "unspecified"
  },
  {
    "name": "Plain White Polo Shirt",
    "price": 4500,
    "image": "plain-white-polo.jpg",
    "brand": "Tommy Hilfiger",
    "size": "XL",
    "color": "white"
  },
  {
    "name": "Blue Jean and Blazer Outfit",
    "price": 12000,
    "image": "blue-jean-and-blazer.jpg",
    "brand": "Calvin Klein",
    "size": "M",
    "color": "blue"
  },
  {
    "name": "Wool Jacket",
    "price": 18000,
    "image": "wool-jacket.jpg",
    "brand": "Patagonia",
    "size": "XXL",
    "color": "brown"
  },
  {
    "name": "Rugged Blue Jeans",
    "price": 6800,
    "image": "rugged-blue-jeans.jpg",
    "brand": "Levi's",
    "size": "L",
    "color": "blue"
  },
  {
    "name": "Blue Jeans Set",
    "price": 7500,
    "image": "blue-jeans-set.jpg",
    "brand": "Gap",
    "size": "M",
    "color": "blue"
  },
  {
    "name": "Casual Set 1",
    "price": 9200,
    "image": "casual-set#1.jpg",
    "brand": "Nike",
    "size": "XL",
    "color": "black"
  },
  {
    "name": "Blue All Star Shoes",
    "price": 5200,
    "image": "blue-allstars.jpg",
    "brand": "Converse",
    "size": "M",
    "color": "blue"
  },
  {
    "name": "Shirt and Brown Shoes",
    "price": 10500,
    "image": "shirt-brown-shoes.jpg",
    "brand": "Ralph Lauren",
    "size": "L",
    "color": "unspecified"
  },
  {
    "name": "Winter Outfit",
    "price": 15000,
    "image": "winter-assemble.jpg",
    "brand": "The North Face",
    "size": "XL",
    "color": "grey"
  }
];

class DataSource {
  static List<Product> getProducts = allProductsDataSource
      .map(
        (e) => Product.fromJson(e),
      )
      .toList();
}
