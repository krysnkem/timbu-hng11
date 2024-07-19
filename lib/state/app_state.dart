import 'package:shop_bag_app/data/model.dart/cart_item.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';

class AppState {
  AppState(
      {required this.allProducts,
      this.cartItems = const [],
      this.productMapping = const {},
      this.isLoading = false,
      this.error});

  final List<Product> allProducts;
  final Map<String, List<List<Product>>> productMapping;

  final List<CartItem> cartItems;

  final bool isLoading;

  final String? error;

  AppState copyWith(
      {List<Product>? allProducts,
      List<CartItem>? cartItems,
      bool? isLoading,
      Map<String, List<List<Product>>>? productMapping,
      String? error}) {
    return AppState(
      allProducts: allProducts ?? this.allProducts,
      cartItems: cartItems ?? this.cartItems,
      isLoading: isLoading ?? this.isLoading,
      productMapping: productMapping ?? this.productMapping,
      error: error,
    );
  }
}
