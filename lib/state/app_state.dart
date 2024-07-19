import 'package:equatable/equatable.dart';
import 'package:shop_bag_app/data/model.dart/cart_item.dart';
import 'package:shop_bag_app/data/model.dart/order_contact_details.dart';
import 'package:shop_bag_app/data/model.dart/payment_details.dart';
import 'package:shop_bag_app/data/model.dart/pre_order.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';

class AppState extends Equatable {
  const AppState({
    required this.allProducts,
    this.cartItems = const [],
    this.productMapping = const {},
    this.isLoading = false,
    this.error,
    this.preOrder,
    this.contactDetails,
    this.paymentDetails,
  });

  final List<Product> allProducts;
  final Map<String, List<List<Product>>> productMapping;
  final List<CartItem> cartItems;
  final bool isLoading;
  final String? error;
  final PreOrder? preOrder;
  final OrderContactDetails? contactDetails;
  final PaymentDetails? paymentDetails;

  AppState copyWith({
    List<Product>? allProducts,
    List<CartItem>? cartItems,
    bool? isLoading,
    Map<String, List<List<Product>>>? productMapping,
    String? error,
    PreOrder? preOrder,
    OrderContactDetails? contactDetails,
    PaymentDetails? paymentDetails,
    bool shouldClear= false,
  }) {
    return AppState(
      allProducts: allProducts ?? this.allProducts,
      cartItems: cartItems ?? this.cartItems,
      isLoading: isLoading ?? this.isLoading,
      productMapping: productMapping ?? this.productMapping,
      error: error ?? this.error,
      preOrder: shouldClear ? null : preOrder ?? this.preOrder,
      contactDetails: shouldClear ? null: contactDetails ?? this.contactDetails,
      paymentDetails: shouldClear ? null: paymentDetails ?? this.paymentDetails,
    );
  }

  @override
  List<Object?> get props => [
        allProducts,
        cartItems,
        productMapping,
        isLoading,
        error,
        preOrder,
        contactDetails,
        paymentDetails,
      ];
}
