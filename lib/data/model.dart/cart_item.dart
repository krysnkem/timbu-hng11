import 'package:shop_bag_app/data/model.dart/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  bool isEqual(CartItem item) {
    return product.isEqual(item.product) && quantity == item.quantity;
  }

  @override
  String toString() {
    return 'CartIte product$product quantity $quantity';
  }
}
