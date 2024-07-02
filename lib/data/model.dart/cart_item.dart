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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem &&
        other.product == product &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;

  @override
  String toString() {
    return 'CartIte product$product quantity $quantity';
  }
}
