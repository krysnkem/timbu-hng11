import 'package:equatable/equatable.dart';
import 'package:shop_bag_app/data/model/cart_item/cart_item.dart';
import 'package:shop_bag_app/data/model/order_contact_details/order_contact_details.dart';
import 'package:shop_bag_app/data/model/payment_detail/payment_details.dart';
import 'package:shop_bag_app/data/model/pre_order/pre_order.dart';
import 'package:shop_bag_app/data/model/product/product.dart';

class AppState extends Equatable {
  const AppState({
    required this.allProducts,
    this.cartItems = const [],
    this.productMapping = const {},
    this.isLoadingAllProducts = false,
    this.isLoadingCartItems = false,
    this.error,
    this.preOrder,
    this.contactDetails,
    this.paymentDetails,
  });

  final List<Product> allProducts;
  final Map<String, List<List<Product>>> productMapping;
  final List<CartItem> cartItems;
  final bool isLoadingAllProducts;
  final bool isLoadingCartItems;
  final String? error;
  final PreOrder? preOrder;
  final OrderContactDetails? contactDetails;
  final PaymentDetails? paymentDetails;

  AppState copyWith({
    List<Product>? allProducts,
    List<CartItem>? cartItems,
    bool? isLoadingAllProducts,
    bool? isLoadingCartItems,
    Map<String, List<List<Product>>>? productMapping,
    String? error,
    PreOrder? preOrder,
    OrderContactDetails? contactDetails,
    PaymentDetails? paymentDetails,
    bool shouldClear = false,
  }) {
    return AppState(
      allProducts: allProducts ?? this.allProducts,
      cartItems: cartItems ?? this.cartItems,
      isLoadingAllProducts: isLoadingAllProducts ?? this.isLoadingAllProducts,
      productMapping: productMapping ?? this.productMapping,
      error: error ?? this.error,
      preOrder: shouldClear ? null : preOrder ?? this.preOrder,
      contactDetails:
          shouldClear ? null : contactDetails ?? this.contactDetails,
      paymentDetails:
          shouldClear ? null : paymentDetails ?? this.paymentDetails,
      isLoadingCartItems: isLoadingCartItems ?? this.isLoadingCartItems,
    );
  }

  @override
  List<Object?> get props => [
        allProducts,
        cartItems,
        productMapping,
        isLoadingAllProducts,
        error,
        preOrder,
        contactDetails,
        paymentDetails,
      ];
}
